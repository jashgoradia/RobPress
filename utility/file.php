<?php

class File {

	public static function Upload($array,$local=false) {
		$f3 = Base::instance();
		extract($array);
		$directory = getcwd() . '/uploads';
		$webdest = '/uploads/' . $name;
		$destination = $directory . '/' . $name;

		//create arrays containing valid exts and mime types
		$acceptedMime = array('image/jpeg','image/png','image/gif','image/bmp','image/tiff');
		$acceptedExt = array('jpg','jpeg','jpe','png','gif','bmp','tiff','tif');

		$ext = strtolower(end(explode('.',$name)));
		$newName = uniqid('',true). '.' .$ext;
		//$newDestination = $directory. '/' . $newName;
		//$webdest = '/uploads/' . $newName;

		if(in_array($type,$acceptedMime) and in_array($ext,$acceptedExt) and getimagesize($tmp_name)!=0 and $size < 1000000){
			//Local files get moved
				if($local) {
					if (copy($tmp_name,$destination)) {
						chmod($destination,0666);
						return $webdest;
					} else {
						return false;
					}
				//POSTed files are done with move_uploaded_file
				} else {
					if (move_uploaded_file($tmp_name,$destination)) {
						chmod($destination,0666);
						//var_dump($webdest);
						//qdie();
						return $webdest;
					} else {
						return false;
					}
				}
		}else {
			\StatusMessage::add('Avatar file not accepted','danger');
			return false;
		}
	}
}

?>
