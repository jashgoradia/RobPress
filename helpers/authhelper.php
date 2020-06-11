<?php

	class AuthHelper {

		/** Construct a new Auth helper */
		public function __construct($controller) {
			$this->controller = $controller;
		}

		/** Attempt to resume a previously logged in session if one exists */
		public function resume() {
			$f3=Base::instance();
			$db = $this->controller->db;

			//Ignore if already running session
			if($f3->exists('SESSION.user.id')) return;

			if($f3->exists('COOKIE.RobPress_User')){
				//get cookie token
				$cookieToken = $f3->get('COOKIE.RobPress_User');
				$results = $db->connection->exec("SELECT `user_id` FROM `cookies` WHERE `token` = ?", array(1=>$cookieToken));
				$userId = $results[0];
				$results = $db->connection->exec("SELECT `expiryTime` FROM `cookies` WHERE `token` = ?", array(1=>$cookieToken));
				$expiry = $results[0];
				//ensure user id and expiry are not empty
				if(empty($userId) or empty($expiry)){
					return false;
				}
				//check if token has expired
				if($expiry<time()){
					$db->connection->exec("DELETE FROM `cookies` WHERE `token` = ?", array(1=>$cookieToken));
					return false;
				}

				//log the user in from the cookie
				$user = $this->controller->Model->Users->fetchById($userId);
				$this->forceLogin($user);
			}

			/*//Log user back in from cookie
			if($f3->exists('COOKIE.RobPress_User')) {
				$user = unserialize(base64_decode($f3->get('COOKIE.RobPress_User')));
				$this->forceLogin($user);
			}*/
		}

		/** Perform any checks before starting login */
		public function checkLogin($username,$password,$request,$debug) {

			//DO NOT check login when in debug mode
			if($debug == 1) { return true; }

			return true;
		}

		/** Look up user by username and password and log them in */
		public function login($username,$password) {
			$f3=Base::instance();
			$db = $this->controller->db;

			//$results gets all usernames(just going to be the one) matching the criteria and uses that to generate user information; also uses named parameters to avoid SQL Injection
			$results = $db->connection->exec("SELECT * FROM `users` WHERE `username`=:usr", array(':usr' => $username)); //AND `password`=:pwd",array(':usr'=>$username, ':pwd'=>$password))
			if (!empty($results)) {

				$user = $results[0];
				$count = $user['attempts'];

				if($count >= 2){  //max amount of tries before reCAPTCHA is triggered =3
					//StatusMessage::add('If statement returned false');
					$f3->set('count', $count);
					if(isset($_POST['g-recaptcha-response']) && !empty($_POST['g-recaptcha-response']) ) {
						$secret = '6LeJacUUAAAAAEwvkYHLuUUYPB4lzvm3dTM4jVCg';
						$verifyResponse = file_get_contents('https://www.google.com/recaptcha/api/siteverify?secret='.$secret.'&response='.$_POST['g-recaptcha-response']);
						$responseData = json_decode($verifyResponse);
						if($responseData->success && password_verify($password,$user['password'])) {
							$this->setupSession($user);
							//reset attempts counter if successful in login
							$db->connection->exec("UPDATE `users` SET  `attempts` = 0 WHERE `username`= ?", array(1=>$username));
							return $this->forceLogin($user);
						} else {
							$errMsg = 'Robot verification failed, please try again.';
							StatusMessage::add('Incorrect response to reCAPTCHA', 'danger');
						}
					}

				}

				//if the counter is less than the max. value (2) and the password entered is correct, the user must be allowed to pass
				if($count < 3 && password_verify($password,$user['password'])) {
					//reset attempts counter if successful in login
					$db->connection->exec("UPDATE `users` SET  `attempts` = 0 WHERE `username`= ?", array(1=>$username));
					$this->setupSession($user);
					return $this->forceLogin($user);

				} else {
					//increment the attempts counter every time the user tried to log in incorrectly
					$db->connection->exec("UPDATE `users` SET  `attempts` = `attempts` + 1 WHERE `username`= ?", array(1=>$username));
					//$count++;
				}

				//if the counter goes above the max. tries before the captcha is called and validated and all checks(username-password, captcha), the user must be allowed to proceed
				if($count > 2 && (password_verify($password,$user['password']) && isset($_POST['g-recaptcha-response']) && !empty($_POST['g-recaptcha-response']))) {
					//reset attempts counter if successful in login
					$db->connection->exec("UPDATE `users` SET  `attempts` = 0 WHERE `username`= ?", array(1=>$username));
					$this->setupSession($user);
					return $this->forceLogin($user);
				}



			}
			return false;
		}

		/** Log user out of system */
		public function logout() {
			$f3=Base::instance();

			//Kill the session
			session_destroy();

			//Kill the cookie token
			$cookieToken = $f3->get('COOKIE.RobPress_User');
			$this->controller->db->connection->exec("DELETE FROM `cookies` WHERE `token` = ?", array(1=>$cookieToken));

			//Kill the cookie
			setcookie('RobPress_User', '', time() - 3600, '/');

		}

		/** Set up the session for the current user */
		public function setupSession($user) {

			//Remove previous session
			session_destroy();

			//Setup new session
			session_id(md5($user['id']) . rand(10,99));  //add random bits to increase entropy, reducing chances of cookie getting guessed

			//random number as cookie token
			$cookieToken = uniqid('',true);
			//expires after 1 month
			$expiryDateTime = time()+3600*24*30;
			$this->controller->db->connection->exec("INSERT INTO `cookies` VALUES (?,?,?)", array(1=>$cookieToken,2=>$user['id'],3=>$expiryDateTime));

			//Setup cookie for storing user details and for relogging in
			setcookie('RobPress_User',$cookieToken,$expiryDateTime,'/');

			//And begin!
			new Session();
		}

		/** Not used anywhere in the code, for debugging only */
		public function specialLogin($username) {
			//YOU ARE NOT ALLOWED TO CHANGE THIS FUNCTION
			$f3 = Base::instance();
			$user = $this->controller->Model->Users->fetch(array('username' => $username));
			$array = $user->cast();
			return $this->forceLogin($array);
		}

		/** Not used anywhere in the code, for debugging only */
		public function debugLogin($username,$password='admin',$admin=true) {
			//YOU ARE NOT ALLOWED TO CHANGE THIS FUNCTION
			$user = $this->controller->Model->Users->fetch(array('username' => $username));

			//Create a new user if the user does not exist
			if(!$user) {
				$user = $this->controller->Model->Users;
				$user->username = $user->displayname = $username;
				$user->email = "$username@robpress.org";
				$user->setPassword($password);
				$user->created = mydate();
				$user->bio = '';
				if($admin) {
					$user->level = 2;
				} else {
					$user->level = 1;
				}
				$user->save();
			}

			//Update user password
			$user->setPassword($password);

			//Move user up to administrator
			if($admin && $user->level < 2) {
				$user->level = 2;
				$user->save();
			}

			//Log in as new user
			return $this->forceLogin($user);
		}

		/** Force a user to log in and set up their details */
		public function forceLogin($user) {
			//YOU ARE NOT ALLOWED TO CHANGE THIS FUNCTION
			$f3=Base::instance();

			if(is_object($user)) { $user = $user->cast(); }

			$f3->set('SESSION.user',$user);
			return $user;
		}

		/** Get information about the current user */
		public function user($element=null) {
			$f3=Base::instance();
			if(!$f3->exists('SESSION.user')) { return false; }
			if(empty($element)) { return $f3->get('SESSION.user'); }
			else { return $f3->get('SESSION.user.'.$element); }
		}

		//This is where the CSRF tokens are validated
		public function validate($token1,$token2){
			$f3=Base::instance();
			if($f3['site']['debug'] == 0) {
				return (!empty($token1) and !empty($token2) and $token1 == $token2);
			}else{ //disable for debug mode
				return true;
			}
		}
	}

?>
