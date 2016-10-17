<?php  
class ControllerCommonFooter extends Controller {
	protected function index() {
		$this->language->load('common/footer');

		$this->data['google_analytics'] = html_entity_decode($this->config->get('config_google_analytics'), ENT_QUOTES, 'UTF-8');
		$this->data['google_remark'] = html_entity_decode($this->config->get('config_google_remark'), ENT_QUOTES, 'UTF-8');

		
		
		$this->data['store'] = $this->config->get('config_owner');
        $current_lang = (int)$this->config->get('config_language_id');
        $arraytitle = $this->config->get('config_address');
		$this->data['address'] = nl2br($arraytitle[$current_lang]);
		
		
		$this->data['type_seo'] = $this->config->get('config_type_seo');
		$this->data['name_seo'] = $this->config->get('config_name_seo');
		$this->data['street_seo'] = $this->config->get('config_street_seo');
		$this->data['region_seo'] = $this->config->get('config_region_seo');
		$this->data['locality_seo'] = $this->config->get('config_locality_seo');
		$this->data['postalcode_seo'] = $this->config->get('config_postalcode_seo');
		$this->data['config_local'] = $this->config->get('config_local');
		$this->data['email'] = $this->config->get('config_email');				
		$this->data['telephone'] = $this->config->get('config_telephone');
		$this->data['email2'] = $this->config->get('config_email');
		$this->data['config_name'] = $this->config->get('config_name');	
		$this->data['hotline'] = $this->config->get('config_hotline');
		$this->data['fax'] = $this->config->get('config_fax');
		$this->data['scripts'] = $this->document->getScripts();
                
                $this->load->model('menu/menuitems');
                $this->data['menu'] = $this->drawMenu($this->model_menu_menuitems->getMenuitems(0,null,'footer_menu'));

		// Whos Online
		if ($this->config->get('config_customer_online')) {
			$this->load->model('tool/online');

			if (isset($this->request->server['REMOTE_ADDR'])) {
				$ip = $this->request->server['REMOTE_ADDR'];	
			} else {
				$ip = ''; 
			}

			if (isset($this->request->server['HTTP_HOST']) && isset($this->request->server['REQUEST_URI'])) {
				$url = 'http://' . $this->request->server['HTTP_HOST'] . $this->request->server['REQUEST_URI'];	
			} else {
				$url = '';
			}

			if (isset($this->request->server['HTTP_REFERER'])) {
				$referer = $this->request->server['HTTP_REFERER'];	
			} else {
				$referer = '';
			}

			$this->model_tool_online->whosonline($ip, $this->customer->getId(), $url, $referer);
		}		

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/footer.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/footer.tpl';
		} else {
			$this->template = 'default/template/common/footer.tpl';
		}
		$this->children = array(
		   'common/bottom',
		   'common/footer_menu'
		);
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