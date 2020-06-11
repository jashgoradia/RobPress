<?php

class Contact extends Controller {

	public function index($f3) {
		if($this->request->is('post')) {
			extract($this->request->data);
			$email = $from;
			$from = "From: $from";
			//added validation of email
			if(!filter_var($email . '.com', FILTER_VALIDATE_EMAIL)) {
				//StatusMessage::add("Please enter a valid email address", "danger");
				$this->Model->Users->validateEmail($email . ".com");
				return $f3->reroute('/contact');
			} else if(empty($message) || empty($subject)) {
				//StatusMessage::add("Please enter the subject and your message", "danger");
				$this->Model->Users->validateText($message);
				$this->Model->Users->validateText($subject);
				return $f3->reroute('/contact');
			} else if($to != 'root@localhost') {  //hardcoded
				StatusMessage::add("Error contacting us, please try again", 'danger');
				return $f3->reroute('/contact');
			}

			else {mail($to,$subject,$message,$from);

			StatusMessage::add('Thank you for contacting us');
			return $f3->reroute('/');}
		}	
	}

}

?>
