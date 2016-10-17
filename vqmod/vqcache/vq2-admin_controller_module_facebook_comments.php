<?php
class ControllerModuleFacebookComments extends Controller {
	private $error = array(); 
	private $version = '3.0';
	
	public function index() {   
		$this->load->language('module/facebook_comments');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('facebook_comments', $this->request->post);		
			
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$this->data['heading_title'] = $this->language->get('heading_title') . ' v' . $this->version;

		$this->data['text_enabled']        = $this->language->get('text_enabled');
		$this->data['text_disabled']       = $this->language->get('text_disabled');
		
		$this->data['text_content_top']    = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->data['text_column_left']    = $this->language->get('text_column_left');
		$this->data['text_column_right']   = $this->language->get('text_column_right');
		
		$this->data['text_light']          = $this->language->get('text_light');
		$this->data['text_dark']           = $this->language->get('text_dark');
		$this->data['text_social']         = $this->language->get('text_social');
		$this->data['text_time']           = $this->language->get('text_time');
		$this->data['text_reverse_time']   = $this->language->get('text_reverse_time');
		
		$this->data['entry_app_id']        = $this->language->get('entry_app_id');
		$this->data['entry_color_scheme']  = $this->language->get('entry_color_scheme');
		$this->data['entry_num_posts']     = $this->language->get('entry_num_posts');
		$this->data['entry_order_by']      = $this->language->get('entry_order_by');
		$this->data['entry_layout']        = $this->language->get('entry_layout');
		$this->data['entry_position']      = $this->language->get('entry_position');
		$this->data['entry_status']        = $this->language->get('entry_status');
		$this->data['entry_sort_order']    = $this->language->get('entry_sort_order');
		
		$this->data['help_app_id']         = $this->language->get('help_app_id');
		$this->data['help_color_scheme']   = $this->language->get('help_color_scheme');
		$this->data['help_num_posts']      = $this->language->get('help_num_posts');
		$this->data['help_order_by']       = $this->language->get('help_order_by');
		
		$this->data['button_save']         = $this->language->get('button_save');
		$this->data['button_cancel']       = $this->language->get('button_cancel');
		$this->data['button_add_module']   = $this->language->get('button_add_module');
		$this->data['button_remove']       = $this->language->get('button_remove');
		
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->error['app_id'])) {
			$this->data['error_app_id'] = $this->error['app_id'];
		} else {
			$this->data['error_app_id'] = '';
		}
		
		if (isset($this->error['num_posts'])) {
			$this->data['error_num_posts'] = $this->error['num_posts'];
		} else {
			$this->data['error_num_posts'] = '';
		}		
		
  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/facebook_comments', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/facebook_comments', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->update_check();
		
		if (isset($this->error['update'])) {
			$this->data['update'] = $this->error['update'];
		} else {
			$this->data['update'] = '';
		}
		
		if (isset($this->request->post['facebook_comments_app_id'])){
			$this->data['facebook_comments_app_id'] = $this->request->post['facebook_comments_app_id'];
		} elseif ($this->config->get('facebook_comments_app_id')) {
			$this->data['facebook_comments_app_id'] = $this->config->get('facebook_comments_app_id');
		} else {
			$this->data['facebook_comments_app_id'] = '';
		}
		
		if (isset($this->request->post['facebook_comments_color_scheme'])){
			$this->data['facebook_comments_color_scheme'] = $this->request->post['facebook_comments_color_scheme'];
		} elseif ($this->config->get('facebook_comments_color_scheme')) {
			$this->data['facebook_comments_color_scheme'] = $this->config->get('facebook_comments_color_scheme');
		} else {
			$this->data['facebook_comments_color_scheme'] = '';
		}		
		
		if (isset($this->request->post['facebook_comments_num_posts'])){
			$this->data['facebook_comments_num_posts'] = $this->request->post['facebook_comments_num_posts'];
		} elseif ($this->config->get('facebook_comments_num_posts')) {
			$this->data['facebook_comments_num_posts'] = $this->config->get('facebook_comments_num_posts');
		} else {
			$this->data['facebook_comments_num_posts'] = '';
		}
		
		if (isset($this->request->post['facebook_comments_order_by'])){
			$this->data['facebook_comments_order_by'] = $this->request->post['facebook_comments_order_by'];
		} elseif ($this->config->get('facebook_comments_order_by')) {
			$this->data['facebook_comments_order_by'] = $this->config->get('facebook_comments_order_by');
		} else {
			$this->data['facebook_comments_order_by'] = '';
		}		
		
		$this->data['modules'] = array();
		
		if (isset($this->request->post['facebook_comments_module'])) {
			$this->data['modules'] = $this->request->post['facebook_comments_module'];
		} elseif ($this->config->get('facebook_comments_module')) { 
			$this->data['modules'] = $this->config->get('facebook_comments_module');
		}				
				
		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();

 $this->data['layouts'][] = array('layout_id'=>0, 'name' => 'All Pages' ); 

		$this->template = 'module/facebook_comments.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/facebook_comments')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (strlen($this->request->post['facebook_comments_app_id']) < 3){
			$this->error['app_id'] = $this->language->get('error_app_id');
		}
		
		if (strlen($this->request->post['facebook_comments_num_posts']) < 1 || !is_numeric($this->request->post['facebook_comments_num_posts'])){
			$this->error['num_posts'] = $this->language->get('error_num_posts');
		}		
				
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
	
	private function update_check() {
		$data = 'v=' . $this->version . '&ex=2&e=' . $this->config->get('config_email') . '&ocv=' . VERSION;
        $curl = false;
        
        if (extension_loaded('curl')) {
			$ch = curl_init();
			
            curl_setopt($ch, CURLOPT_TIMEOUT, 30);
			curl_setopt($ch, CURLOPT_URL, 'https://www.oc-extensions.com/api/v1/update_check');
			curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
			curl_setopt($ch, CURLOPT_POST, 1);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
            curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
            curl_setopt($ch, CURLOPT_FRESH_CONNECT, 1);
            curl_setopt($ch, CURLOPT_FORBID_REUSE, 1);
			curl_setopt($ch, CURLOPT_HTTPHEADER, array('Accept: application/json', 'OCX-Adaptor: curl'));
			curl_setopt($ch, CURLOPT_REFERER, HTTP_CATALOG);
			
			if (function_exists('gzinflate')) {
				curl_setopt($ch, CURLOPT_ENCODING, 'gzip');
			}
            
			$result = curl_exec($ch);
			$http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
			curl_close($ch);
			
			if ($http_code == 200) {
				$result = json_decode($result);
				
                if ($result) {
                    $curl = true;
                }
                
                if ( isset($result->version) && ($result->version > $this->version) ) {
				    $this->error['update'] = 'A new version of this extension is available. <a target="_blank" href="' . $result->url . '">Click here</a> to see the Changelog.';
				}
			}
		}
        
        if (!$curl) {
			if (!$fp = @fsockopen('ssl://www.oc-extensions.com', 443, $errno, $errstr, 20)) {
				return false;
			}

			socket_set_timeout($fp, 20);
			
			$headers = array();
			$headers[] = "POST /api/v1/update_check HTTP/1.0";
			$headers[] = "Host: www.oc-extensions.com";
			$headers[] = "Referer: " . HTTP_CATALOG;
			$headers[] = "OCX-Adaptor: socket";
			if (function_exists('gzinflate')) {
				$headers[] = "Accept-encoding: gzip";
			}	
			$headers[] = "Content-Type: application/x-www-form-urlencoded";
			$headers[] = "Accept: application/json";
			$headers[] = 'Content-Length: '.strlen($data);
			$request = implode("\r\n", $headers)."\r\n\r\n".$data;
			fwrite($fp, $request);
			$response = $http_code = null;
			$in_headers = $at_start = true;
			$gzip = false;
			
			while (!feof($fp)) {
				$line = fgets($fp, 4096);
				
				if ($at_start) {
					$at_start = false;
					
					if (!preg_match('/HTTP\/(\\d\\.\\d)\\s*(\\d+)\\s*(.*)/', $line, $m)) {
						return false;
					}
					
					$http_code = $m[2];
					continue;
				}
				
				if ($in_headers) {

					if (trim($line) == '') {
						$in_headers = false;
						continue;
					}

					if (!preg_match('/([^:]+):\\s*(.*)/', $line, $m)) {
						continue;
					}
					
					if ( strtolower(trim($m[1])) == 'content-encoding' && trim($m[2]) == 'gzip') {
						$gzip = true;
					}
					
					continue;
				}
				
                $response .= $line;
			}
					
			fclose($fp);
			
			if ($http_code == 200) {
				if ($gzip && function_exists('gzinflate')) {
					$response = substr($response, 10);
					$response = gzinflate($response);
				}
				
				$result = json_decode($response);
				
                if ( isset($result->version) && ($result->version > $this->version) ) {
				    $this->error['update'] = 'A new version of this extension is available. <a target="_blank" href="' . $result->url . '">Click here</a> to see the Changelog.';
				}
			}
		}
	}
}
?>