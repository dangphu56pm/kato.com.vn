<?php
class ControllerModuleProductCategory extends Controller {
	private $error = array(); 
	
	public function index() {   
		$this->load->language('module/product_category');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			//echo '<pre>';
			//print_r($this->request->post);die;

			$this->model_setting_setting->editSetting('product_category', $this->request->post);//insert setting table with value $post		
			
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['text_none'] = $this->language->get('text_none');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		
		$this->data['entry_title'] = $this->language->get('entry_title');	
		$this->data['entry_cat'] = $this->language->get('entry_cat');	
		$this->data['entry_limit'] = $this->language->get('entry_limit');
		$this->data['entry_image'] = $this->language->get('entry_image');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['entry_description'] = $this->language->get('entry_description');
		$this->data['entry_sort'] = $this->language->get('entry_sort');
		$this->data['entry_type'] = $this->language->get('entry_type');
		$this->data['entry_up'] = $this->language->get('entry_up');
		$this->data['entry_down'] = $this->language->get('entry_down');
		$this->data['entry_limitdescription'] = $this->language->get('entry_limitdescription');	
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->error['image'])) {
			$this->data['error_image'] = $this->error['image'];
		} else {
			$this->data['error_image'] = array();
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
			'href'      => $this->url->link('module/product_category', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/product_category', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['sorts'] = array();
		$value_sort = array(
						array(
								'value'=>'pd.name',
								'text'=>$this->language->get('entry_name')
						),
						array(
								'value'=>'p.price',
								'text'=>$this->language->get('entry_price')
						),
						array(
								'value'=>'rating',
								'text'=>$this->language->get('entry_rating')
						),
						array(
								'value'=>'p.date_added',
								'text'=>$this->language->get('entry_time')
						),
						array(
								'value'=>'p.model',
								'text'=>$this->language->get('entry_model')
						)
		);
		$this->data['sorts'] = $value_sort;
		$this->load->model('catalog/category');
		$this->data['categories'] = array();
		
		$results = $this->model_catalog_category->getCategories(0);

		foreach ($results as $result) {
			$action = array();
			
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('catalog/category/update', 'token=' . $this->session->data['token'] . '&category_id=' . $result['category_id'], 'SSL')
			);
					
			$this->data['categories'][] = array(
				'category_id' => $result['category_id'],
				'name'        => $result['name'],
				'sort_order'  => $result['sort_order'],
				'selected'    => isset($this->request->post['selected']) && in_array($result['category_id'], $this->request->post['selected']),
				'action'      => $action
			);
		}
		$this->load->model('localisation/language');
		
		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		$this->data['modules'] = array();
		if (isset($this->request->post['product_category_module'])) {
			$this->data['modules'] = $this->request->post['product_category_module'];
		} elseif ($this->config->get('product_category_module')) { 
			$this->data['modules'] = $this->config->get('product_category_module');
		}				
		//echo '<pre>';
		//print_r($this->data['modules']);die;
		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();

 $this->data['layouts'][] = array('layout_id'=>0, 'name' => 'All Pages' ); 

		$this->template = 'module/product_category.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/product_category')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (isset($this->request->post['product_category_module'])) {
			foreach ($this->request->post['product_category_module'] as $key => $value) {
				if (!$value['image_width'] || !$value['image_height']) {
					$this->error['image'][$key] = $this->language->get('error_image');
				}
			}
		}		
				
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>