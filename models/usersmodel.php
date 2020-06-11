<?php

class UsersModel extends GenericModel {

	/** Update the password for a user account */
	public function setPassword($password) {
		$hashedPassword = password_hash($password,PASSWORD_DEFAULT); //hash the password sent by the user
		$this->password = $hashedPassword; //set the hash as the user's password
	}

	public function validateUsername($username) {
		if(empty($username)){
			//StatusMessage::add('Username cannot be left blank','danger');
			array_push($error, 'Username cannot be left blank');
		} else if(!ctype_alnum($username)) {
			StatusMessage::add('Username must contain only alphanumeric characters', 'danger');
			//array_push($error, 'Username must contain only alphanumeric characters');
		}
	}
	public function validatePassword($password) {
		if(empty($password)){
			StatusMessage::add('Password cannot be left blank','danger');
			//array_push($error, 'Password cannot be left blank');
		}
	}
	public function validateEmail($email) {
		if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
			StatusMessage::add("Please enter a valid email address", "danger");
			//array_push($error, 'Please enter a valid email address');
		}
	}

	public function validateText($text) {
		if (empty($text)) {
			StatusMessage::add('Field cannot be left blank', 'danger');
			//array_push($error, 'Field cannot be left blank');
		}
	}

	public $validationRules = [
		'id' => ['type' => 'numeric', 'required' => false],
		'username' => ['type' => 'text', 'required' => true, 'max_length' => 255],
		'bio' => ['type' => 'html', 'required' => false]
	];

	public function validate($data) {
		/*foreach ($this->validationRules as $key=>$rule) {
			if ($rule['type'] == 'numeric' && !is_numeric($this->key)) {
				$valid = false;
			}

		}
		if ($valid) {
			return true;
		}
		return false;*/

		$error = array();
		extract($data);
		$this->validateUsername($data['username']);
		$this->validatePassword($data['password']);
		//$this->validateEmail($data['email']);
		return $this->$error;


	}

	/*} else if($password != $password2 || empty($password)) {
        StatusMessage::add('Passwords must match','danger');
    }*/

}

?>
