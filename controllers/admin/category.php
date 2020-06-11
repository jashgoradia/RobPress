<?php

	namespace Admin;

	class Category extends AdminController {

		public function index($f3) {
			$categories = $this->Model->Categories->fetchAll();
			$counts = array();
			foreach($categories as $category) {
				$counts[$category->id] = $this->Model->Post_Categories->fetchCount(array('category_id' => $category->id));
			}
			$f3->set('categories',$categories);
			$f3->set('counts',$counts);
		}

		public function add($f3) {
			//validate CSRF token
			$res = $this->Auth->validate($_SESSION['token'],$f3->get('POST.token'));
			if($res) {
				if ($this->request->is('post')) {
					$category = $this->Model->Categories;
					$category->title = $this->request->data['title'];

					if (!empty($category->title)) {
						$category->save();
						\StatusMessage::add('Category added successfully', 'success');
						return $f3->reroute('/admin/category');
					} else {  //if category title is empty
						$this->Model->Users->validateText($category->title);
						return $f3->reroute('/admin/category');
					}
				}
			}else { //CSRF validation token
				\StatusMessage::add('Request not valid','danger');
				return $f3->reroute('/');
			}
		}

		public function delete($f3) {
			$res = $this->Auth->validate($_SESSION['token'],$f3->get('POST.token'));
			if($res == true) {
				$categoryid = $f3->get('PARAMS.3');
				$category = $this->Model->Categories->fetchById($categoryid);
				$category->erase();

				//Delete links
				$links = $this->Model->Post_Categories->fetchAll(array('category_id' => $categoryid));
				foreach ($links as $link) {
					$link->erase();
				}

				\StatusMessage::add('Category deleted successfully', 'success');
				return $f3->reroute('/admin/category');
			}else{
				\StatusMessage::add('Request not valid','danger');
				return $f3->reroute('/');
			}
		}

		public function edit($f3) {
			$categoryid = $f3->get('PARAMS.3');
			$category = $this->Model->Categories->fetchById($categoryid);
			if(!empty($category)) {
				if ($this->request->is('post')) {
					$category->title = $this->request->data['title'];
					$category->save();
					\StatusMessage::add('Category updated successfully', 'success');
					return $f3->reroute('/admin/category');
				}
			}else {
				\StatusMessage::add('Category not found','danger');
				return $f3->reroute('/admin/category');
			}
			$f3->set('category',$category);
		}


	}

?>
