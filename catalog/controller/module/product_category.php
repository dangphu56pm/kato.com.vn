<?php
class ControllerModuleProductCategory extends Controller {
	protected function index($setting) {
		$this->language->load('module/product_category');
 
      	$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['button_cart'] = $this->language->get('button_cart');
		
		$this->load->model('catalog/product');
		$this->load->model('catalog/category');
		$this->load->model('tool/image');
		$this->load->model('tool/t2vn');
		$this->data['position'] = $setting['position'];
		$this->data['products'] = array();
		
		$this->data['title'] = $setting[$this->config->get('config_language_id')]['title'];
		$this->data['link'] = $this->url->link('product/category', 'path=' . $setting['cat_p']);
		
		$info_category = $this->model_catalog_category->getCategory($setting['cat_p']);
		
		
		if(isset($info_category['name'])){
			$this->data['description'] = html_entity_decode($info_category['description'], ENT_QUOTES, 'UTF-8');
			$this->data['thumb'] = 'image/'.$info_category['image'];
			$data = array(
				'filter_category_id' =>$info_category['category_id'],
				'sort'  => $setting['sort'],
				'order' => $setting['type'],
				'start' => 0,
				'limit' => $setting['limit']
			);
		$results = $this->model_catalog_product->getProducts($data);
		
			foreach ($results as $result) {
				if ($result['image']) {
					$image = 'image/'.$result['image'];
				}else {
					$image = false;
				}	
				
				if ($result['description']) {
					$description = $this->model_tool_t2vn->cut_string(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8'), 150);
				} else {
					$description = false;
				}
				
							
			$this->data['products'][] = array(
				'product_id' => $result['product_id'],
				'description'   	 => $description,
				'thumb'   	 => $image,
				'name'    	 => $result['name'],
				'href'    	 => $this->url->link('product/product', 'product_id=' . $result['product_id']),
			);

			}

		}
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/product_category.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/product_category.tpl';
		} else {
			$this->template = 'default/template/module/product_category.tpl';
		}

		$this->render();
	}
}
?>