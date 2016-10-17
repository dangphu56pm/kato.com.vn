<?php   
class ControllerCommonHeader extends Controller { 
	protected function index() {            
        $this->data['title'] =  $this->document->getTitle();
        
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		if (isset($this->session->data['error']) && !empty($this->session->data['error'])) {
			$this->data['error'] = $this->session->data['error'];

			unset($this->session->data['error']);
		} else {
			$this->data['error'] = '';
		}

		$this->data['base'] = $server;
		$this->data['description'] 		= $this->document->getDescription();
		$this->data['links'] = $this->document->getLinks();	 
		$this->data['metapros'] = $this->document->getMetapros();	 
		$this->data['metanames'] = $this->document->getMetanames();	 
		$this->data['styles'] = $this->document->getStyles();
		$this->data['scripts'] = $this->document->getScripts();
		$this->data['lang'] = $this->language->get('code');
		$this->data['direction'] = $this->language->get('direction');
		$this->data['name'] = $this->config->get('config_name');
		$this->data['hotline'] = $this->config->get('config_hotline');
		$this->data['store'] = $this->config->get('config_store');
		$this->data['telephone'] = $this->config->get('config_telephone');
		$this->data['google_verify'] = html_entity_decode($this->config->get('config_google_verify'), ENT_QUOTES, 'UTF-8');

		$this->data['fb'] = $this->config->get('config_facebook');
		$this->data['tw'] = $this->config->get('config_twitter');
		$this->data['pl'] = $this->config->get('config_plus');
		$this->data['hocngay'] = $this->config->get('config_hocngay');

        $this->load->model('menu/menuitems');
        $this->data['menu'] = $this->drawMenu($this->model_menu_menuitems->getMenuitems(0,null,'top_menu'));
		if(isset($this->request->get['route'])){
			$this->data['route'] = $this->request->get['route'];
		}else{
			$this->data['route'] = "common/home";
		}        
        if($this->data['route'] == "common/home") {
            $curent_language = (int)$this->config->get('config_language_id');
            $arraytitle = $this->config->get('config_title');
            $this->data['title'] = $arraytitle[$curent_language];  
        }
        
		if ($this->config->get('config_icon') && file_exists(DIR_IMAGE . $this->config->get('config_icon'))) {
			$this->data['icon'] = $server . 'image/' . $this->config->get('config_icon');
		} else {
			$this->data['icon'] = '';
		}

		if ($this->config->get('config_logo') && file_exists(DIR_IMAGE . $this->config->get('config_logo'))) {
			$this->data['logo'] = $server . 'image/' . $this->config->get('config_logo');
		} else {
			$this->data['logo'] = '';
		}

		$this->language->load('common/header');

		$this->data['text_home'] = $this->language->get('text_home');
		$this->data['text_search'] = $this->language->get('text_search');
		$this->data['text_contact'] = $this->language->get('text_contact');
		
		
		$this->data['home'] = $this->url->link('common/home');

		// Daniel's robot detector
		$status = true;

		if (isset($this->request->server['HTTP_USER_AGENT'])) {
			$robots = explode("\n", trim($this->config->get('config_robots')));

			foreach ($robots as $robot) {
				if ($robot && strpos($this->request->server['HTTP_USER_AGENT'], trim($robot)) !== false) {
					$status = false;

					break;
				}
			}
		}

		// A dirty hack to try to set a cookie for the multi-store feature
		$this->load->model('setting/store');

		$this->data['stores'] = array();

		if ($this->config->get('config_shared') && $status) {
			$this->data['stores'][] = $server . 'catalog/view/javascript/crossdomain.php?session_id=' . $this->session->getId();

			$stores = $this->model_setting_store->getStores();

			foreach ($stores as $store) {
				$this->data['stores'][] = $store['url'] . 'catalog/view/javascript/crossdomain.php?session_id=' . $this->session->getId();
			}
		}

		// Search		
		if (isset($this->request->get['search'])) {
			$this->data['search'] = $this->request->get['search'];
		} else {
			$this->data['search'] = '';
		}

		// Menu
		$this->load->model('catalog/category');

		$this->data['categories'] = array();

		$categories = $this->model_catalog_category->getCategories(0);

		foreach ($categories as $category) {
			if ($category['top']) {
				// Level 2
				$children_data = array();

				$children = $this->model_catalog_category->getCategories($category['category_id']);

				foreach ($children as $child) {
					$data = array(
						'filter_category_id'  => $child['category_id'],
						'filter_sub_category' => true
					);

					$children_data[] = array(
						'category_id' => $child['category_id'],
						'name'  => $child['name'],
						'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])
					);						
				}

				// Level 1
				$this->data['categories'][] = array(
					'name'     => $category['name'],
					'category_id' => $category['category_id'],
					'children' => $children_data,
					'column'   => $category['column'] ? $category['column'] : 1,
					'href'     => $this->url->link('product/category', 'path=' . $category['category_id'])
				);
			}
		}

		$this->children = array(
			'common/slideside',
			'common/top_menu'
		);

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/header.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/header.tpl';
		} else {
			$this->template = 'default/template/common/header.tpl';
		}

		$this->render();
	} 
        public function drawMenu($menuitems, $class=array('ulclass'=>'menu', 'liclass'=>'menu-li' )){
  		$toprint="";
  		foreach($menuitems as $menuitem){
  			$toprint.="<li class='".$class['liclass']." ".$menuitem['menu_class']."' ><a href='".$menuitem['menu_link']."'>".$menuitem['menu_name']."</a>";
  			if(count($menuitem['children'])){
  				$class['liclass'].="-sub";
  				$class['ulclass'].="-sub";
  				$subitem=$this->drawMenu($menuitem['children'], $class);
  				$toprint.="<div><ul class='".$class['ulclass']."'>".$subitem."</ul></div>";  				
  			}
  			$toprint.="</li>";
  		}
  		return $toprint;
  	}
}
?>
