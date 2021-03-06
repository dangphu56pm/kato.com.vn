<?php 
class ControllerProductOrder extends Controller {
	private $error = array(); 

	public function index() {
		$this->language->load('information/contact');
		$this->load->model('catalog/product');
		$this->document->setTitle("Biểu mẫu đặt mua hàng");
		
		$product_name = "Các sản phẩm: \n";
		
		$product_url = explode("_",$this->request->get['pd_id']);
		foreach ($product_url as $rs) {
			$result = $this->model_catalog_product->getProduct($rs);
			$product_name .= "\r".$result['name']."\n";
			if ($result['image']) {
				$image = 'image/'.$result['image'];
			} else {
				$image = false;
			}

			$this->data['products_url'][] = array(
				'product_id'  => $result['product_id'],
				'thumb'       => $image,
				'name'        => $result['name'],
				'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 100) . '..',
				'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
			);
		}

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_catalog_product->addOrder($this->request->get['pd_id'],$this->request->post);
			$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->hostname = $this->config->get('config_smtp_host');
			$mail->username = $this->config->get('config_smtp_username');
			$mail->password = $this->config->get('config_smtp_password');
			$mail->port = $this->config->get('config_smtp_port');
			$mail->timeout = $this->config->get('config_smtp_timeout');				
			$mail->setTo($this->config->get('config_email'));
			$mail->setFrom($this->request->post['email']);
			$mail->setSender($this->request->post['name']);
			$mail->setSubject(html_entity_decode(sprintf($this->language->get('email_subject'), $this->request->post['name']), ENT_QUOTES, 'UTF-8'));
			$mail->setText(strip_tags(html_entity_decode("Địa chỉ: ". $this->request->post['address2'] . "\r\nĐiện thoại: " . $this->request->post['phone2'] ."\r\n \r\nNội dung: " . $this->request->post['enquiry'] . "\r\n" .$product_name, ENT_QUOTES, 'UTF-8')));
			$mail->send();
			$this->redirect($this->url->link('product/order/success'));
		}
		$products = $this->model_catalog_product->getProducts();
		foreach($products as $result){
			if(!in_array($result['product_id'], $product_url)){
			$this->data['products'][] = array(
				'product_id' => $result['product_id'],
				'name' => $result['name']
			);
			}
		} 

		/* $data = array();
		$results = $this->model_catalog_product->getProducts($data); */
		
		/* foreach($product_url as $result){
			$this->data['products'][] = array(
				'product_id' => $result['product_id'],
				'name' => $result['name']
			);
		} */ 

		
		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),        	
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => "Đặt mua hàng",
			'href'      => $this->url->link('product/order'),
			'separator' => $this->language->get('text_separator')
		);

		$this->data['heading_title'] = "Đặt mua hàng";

		$this->data['text_location'] = $this->language->get('text_location');
		$this->data['text_contact'] = $this->language->get('text_contact');
		$this->data['text_address'] = $this->language->get('text_address');
		$this->data['text_address2'] = $this->language->get('text_address2');
		$this->data['text_telephone'] = $this->language->get('text_telephone');
		$this->data['text_phone'] = $this->language->get('text_phone');
		$this->data['text_fax'] = $this->language->get('text_fax');
		$this->data['text_companyname'] = $this->language->get('text_companyname');

		$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_email'] = $this->language->get('entry_email');
		$this->data['entry_enquiry'] = $this->language->get('entry_enquiry');
		$this->data['entry_submit'] = $this->language->get('entry_submit');
		$this->data['entry_captcha'] = $this->language->get('entry_captcha');
		
		$this->data['url_order'] = $this->url->link('product/order', 'pd_id=' . $this->request->get['pd_id']);

		if (isset($this->error['name'])) {
			$this->data['error_name'] = $this->error['name'];
		} else {
			$this->data['error_name'] = '';
		}

		if (isset($this->error['email'])) {
			$this->data['error_email'] = $this->error['email'];
		} else {
			$this->data['error_email'] = '';
		}		

		if (isset($this->error['enquiry'])) {
			$this->data['error_enquiry'] = $this->error['enquiry'];
		} else {
			$this->data['error_enquiry'] = '';
		}		

		if (isset($this->error['captcha'])) {
			$this->data['error_captcha'] = $this->error['captcha'];
		} else {
			$this->data['error_captcha'] = '';
		}	

		$this->data['button_continue'] = $this->language->get('button_continue');

		$this->data['action'] = $this->url->link('product/order&pd_id='.$this->request->get['pd_id']);
		$this->data['store'] = $this->config->get('config_name');
        $current_lang = (int)$this->config->get('config_language_id');
        $arraytitle = $this->config->get('config_address');
		$this->data['address'] = nl2br($arraytitle[$current_lang]);
		$this->data['telephone'] = $this->config->get('config_telephone');
		$this->data['fax'] = $this->config->get('config_fax');
		$this->data['email2'] = $this->config->get('config_email');
		$this->data['hotline'] = $this->config->get('config_hotline');
		$this->data['config_name'] = $this->config->get('config_name');

		if (isset($this->request->post['name'])) {
			$this->data['name'] = $this->request->post['name'];
		} else {
			$this->data['name'] = '';
		}

		if (isset($this->request->post['email'])) {
			$this->data['email'] = $this->request->post['email'];
		} else {
			$this->data['email'] = '';
		}

		if (isset($this->request->post['enquiry'])) {
			$this->data['enquiry'] = $this->request->post['enquiry'];
		} else {
			$this->data['enquiry'] = '';
		}
		
		if (isset($this->request->post['address2'])) {
			$this->data['address2'] = $this->request->post['address2'];
		} else {
			$this->data['address2'] = '';
		}

		if (isset($this->request->post['phone'])) {
			$this->data['phone'] = $this->request->post['phone'];
		} else {
			$this->data['phone'] = '';
		}

		if (isset($this->request->post['captcha'])) {
			$this->data['captcha'] = $this->request->post['captcha'];
		} else {
			$this->data['captcha'] = '';
		}		

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/order.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/product/order.tpl';
		} else {
			$this->template = 'default/template/product/order.tpl';
		}

		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'
		);

		$this->response->setOutput($this->render());
	}

	public function success() {
		$this->language->load('information/contact');

		$this->document->setTitle("Đặt mua hàng"); 

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => "Đặt mua hàng",
			'href'      => $this->url->link('product/order'),
			'separator' => $this->language->get('text_separator')
		);

		$this->data['heading_title'] = "Đặt mua hàng";

		$this->data['text_message'] = "Bạn đã đặt mua hàng thành công!";

		$this->data['button_continue'] = $this->language->get('button_continue');

		$this->data['continue'] = $this->url->link('common/home');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/success.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/success.tpl';
		} else {
			$this->template = 'default/template/common/success.tpl';
		}

		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'
		);

		$this->response->setOutput($this->render());
	}

	protected function validate() {
		if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 32)) {
			$this->error['name'] = $this->language->get('error_name');
		}

		if (!preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $this->request->post['email'])) {
			$this->error['email'] = $this->language->get('error_email');
		}

		if ((utf8_strlen($this->request->post['enquiry']) < 10) || (utf8_strlen($this->request->post['enquiry']) > 3000)) {
			$this->error['enquiry'] = $this->language->get('error_enquiry');
		}

		if (empty($this->session->data['captcha']) || ($this->session->data['captcha'] != $this->request->post['captcha'])) {
			$this->error['captcha'] = $this->language->get('error_captcha');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}  	  
	}

	public function captcha() {
		$this->load->library('captcha');

		$captcha = new Captcha();

		$this->session->data['captcha'] = $captcha->getCode();

		$captcha->showImage();
	}	
}
?>