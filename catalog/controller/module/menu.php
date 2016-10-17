<?php

class ControllerModuleMenu extends Controller {

    protected function index($setting) {
        static $module = 0;
        $this->load->model('menu/menus');
        $this->load->model('menu/menuitems');
        $menu_id = $setting['menu_id'];
        $this->data['position'] = $setting['position'];
        $menu_data = array();

        $this->data['class'] = $this->model_menu_menus->getMenuClass($setting['menu_id']);

        $menu_name = $this->model_menu_menus->getMenuName($setting['menu_id']);
        if ($this->config->get('config_language_id') == 2) {
            $this->data['menu_name'] = $menu_name['menu_name'];
        } else {
            $this->data['menu_name'] = $menu_name['menu_name_en'];
        }

        $menuitem_data = $this->cache->get('menuitems_front.' . (int) $this->config->get('config_language_id') . '.' . (int) $setting['menu_id']);
        if (!$menuitem_data) {
            $menuitem_data = $this->model_menu_menuitems->getMenuitems(0, $setting['menu_id']);
            $this->cache->set('menuitems_front.' . (int) $this->config->get('config_language_id') . '.' . (int) $setting['menu_id'], $menuitem_data);
        }
        $this->data['menuitems'] = $menuitem_data;
        $this->data['menu'] = $this->drawMenu($this->model_menu_menuitems->getMenuitems(0, $setting['menu_id']));
        $this->data['module'] = $module++;

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/menu.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/module/menu.tpl';
        } else {
            $this->template = 'default/template/module/menu.tpl';
        }

        $this->render();
    }

//  	public function drawMenu($menuitems, $class=array('ulclass'=>'menu', 'liclass'=>'menu-li' )){
//  		$toprint="";
//  		foreach($menuitems as $menuitem){
//  			$toprint.="<li class='".$class['liclass']." ".$menuitem['menu_class']."' ><a href='".$menuitem['menu_link']."'>".$menuitem['menu_name']."</a>";
//  			if(count($menuitem['children'])){
//  				$class['liclass'].="-sub";
//  				$class['ulclass'].="-sub";
//  				$subitem=$this->drawMenu($menuitem['children'], $class);
//  				$toprint.="<div><ul class='".$class['ulclass']."'>".$subitem."</ul></div>";  				
//  			}
//  			$toprint.="</li>";
//  		}
//  		return $toprint;
//  	}
    public function drawMenu($menuitems, $class = array('ulclass' => 'menu', 'liclass' => 'menu-li')) {
        $toprint = "";
        $count = 0;
        if (isset($this->request->get['product_id'])) {
            $this->request->get['route'] = 'product/product';
        } elseif (isset($this->request->get['path'])) {
            $this->request->get['route'] = 'product/category';
        } elseif (isset($this->request->get['news_id'])) {
            $this->request->get['route'] = 'news/news';
        } elseif (isset($this->request->get['cat_id'])) {
            $this->request->get['route'] = 'news/news_category';
        } elseif (isset($this->request->get['manufacturer_id'])) {
            $this->request->get['route'] = 'product/manufacturer/info';
        } elseif (isset($this->request->get['information_id'])) {
            $this->request->get['route'] = 'information/information';
        }
        if (isset($this->request->get['cat_id'])) {
            $cat_id = $this->request->get['cat_id'];
        } elseif (isset($this->request->get['news_id'])) {
            $news_category_id = $this->db->query("SELECT news_category_id FROM " . DB_PREFIX . "news_to_category WHERE news_id='" . $this->request->get['news_id'] . "'")->row['news_category_id'];
            $cat_id = $news_category_id;
        } else {
            $cat_id = 0;
        }

        if (isset($this->request->get['path'])) {
            $categories = explode('_', (string) $this->request->get['path']);
            $path = end($categories);
        } elseif (isset($this->request->get['product_id'])) {
            $category_id = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "product_to_category WHERE product_id='" . $this->request->get['product_id'] . "'")->row['category_id'];
            $path = $category_id;
        } else {
            $path = 0;
        }
        $f = 0;
        foreach ($menuitems as $key => $menuitem) {
            $query1 = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE keyword='" . $menuitem['menu_link'] . "'");
            if ($query1->num_rows) {
                $query = $query1->row['query'];
                $val = explode('=', $query);
                if (($cat_id != 0 && $cat_id == $val[1]) || ($path != 0 && $path == $val[1]) || (isset($this->request->get['information_id']) && $val[1] == $this->request->get['information_id']) || (isset($this->request->get['news_id']) && $val[1] == $this->request->get['news_id']) || (isset($this->request->get['product_id']) && $val[1] == $this->request->get['product_id'])) {
                    $f = $key;
                    $count ++;
                }
            } elseif (isset($this->request->get['route']) && ($this->request->get['route'] == 'information/contact' || $this->request->get['route'] == 'module/productquestion/questions')) {
                $f = $key;
                $count ++;
            }
        }
        foreach ($menuitems as $key => $menuitem) {
            if ($count == 0 && $menuitem['menu_class'] == 'home') {
                $toprint.="<li class='" . $class['liclass'] . " " . $menuitem['menu_class'] . " selected' ><a href='" . $menuitem['menu_link'] . "'>" . $menuitem['menu_name'] . "</a>";
            } else {
                if ($key == $f) {
                    $toprint.="<li class='" . $class['liclass'] . " " . $menuitem['menu_class'] . " selected' ><a href='" . $menuitem['menu_link'] . "'>" . $menuitem['menu_name'] . "</a>";
                } else {
                    $toprint.="<li class='" . $class['liclass'] . " " . $menuitem['menu_class'] . " ' ><a href='" . $menuitem['menu_link'] . "'>" . $menuitem['menu_name'] . "</a>";
                }
            }

            if (count($menuitem['children'])) {
                $class['liclass'].="-sub";
                $class['ulclass'].="-sub";
                $subitem = $this->drawMenu($menuitem['children'], $class);
                $toprint.="<div><ul class='" . $class['ulclass'] . "'>" . $subitem . "</ul></div>";
            }
            $toprint.="</li>";
        }

        return $toprint;
    }

}

?>