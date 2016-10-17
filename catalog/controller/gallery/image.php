<?php
class ControllerGalleryImage extends Controller {
	private $error = array(); 
	
	public function index() {
		$this->language->load('gallery/gallery');
		$this->load->model('catalog/gallimage');
		$this->load->model('tool/image'); 
		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
			'separator' => false
		);
		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('gallery/image'),
			'separator' => $this->language->get('text_separator')
		);	
		
		if(isset($this->request->get['gallimage_id']) && !empty($this->request->get['gallimage_id'])){
			$images = $this->model_catalog_gallimage->getGallimage($this->request->get['gallimage_id']);
			
			$name =$this->model_catalog_gallimage->getGallimageName($this->request->get['gallimage_id']);
			$this->data['text_back_gall'] = $this->language->get('text_back_gall');
			$this->document->addScript('static/baguetteBox.js');
			$this->document->setTitle($name);
			$this->data['heading_title'] = $name;
		
			foreach($images as $image){
				$width = ''; $height = '';
				$result = $this->model_catalog_gallimage->getFirstImages($image['gallimage_id']);
				if ($image['image']) {
					$thumb = $this->model_tool_image->resize($image['image'],$this->config->get('config_image_news_width'), $this->config->get('config_image_news_height'));
					$full = 'image/'.$image['image'];
				} else {
					$thumb = $this->model_tool_image->resize('no-image.jpg',$this->config->get('config_image_news_width'), $this->config->get('config_image_news_height'));
					$full = $this->model_tool_image->resize('no-image.jpg',$this->config->get('config_image_news_width'), $this->config->get('config_image_news_height'));
				}
				$this->data['images'][] = array(
					'name'	=> $image['name'],
					'thumb'	=> $thumb,
					'full'	=> $full,
					'href'	=> $this->url->link('gallery/image', '&gallimage_id='. $image['gallimage_id'])
				);
			}
			
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/gallery/image_detail.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/gallery/image_detail.tpl';
			} else {
				$this->template = 'default/template/gallery/image_detail.tpl';
			}
			
			$this->children = array(
				'common/column_left',
				'common/adv_top',
				'common/column_right',
				'common/content_top',
				'common/content_bottom',
				'common/footer',
				'common/header'
			);
				
			$this->response->setOutput($this->render());
		}else {
			if (isset($this->request->get['page'])) {
				$page = $this->request->get['page'];
			} else { 
				$page = 1;
			}	
								
			if (isset($this->request->get['limit'])) {
				$limit = $this->request->get['limit'];
			} else {
				$limit = $this->config->get('config_catalog_limit');
			}
						
			
			$limit = 9;
			$data = array(
				'sort'  => 'date_added',
				'order' => 'DESC',	
				'start'              => ($page - 1) * $limit,
				'limit'              => $limit
			);
					
			$images_total = $this->model_catalog_gallimage->getTotalImages(); 
			$this->data['images_total'] = $images_total;
			$this->data['images'] = array();
			$images = $this->model_catalog_gallimage->getListImage($data);
			
			$this->document->setTitle($this->language->get('heading_title'));
			
			$this->data['heading_title'] = $this->language->get('heading_title');
			
			foreach($images as $image){
				$width = ''; $height = '';
				$result = $this->model_catalog_gallimage->getFirstImages($image['gallimage_id']);
				if ($result['image']) {
					$thumb = $this->model_tool_image->resize($result['image'],$this->config->get('config_image_news_width'), $this->config->get('config_image_news_height'));
				} else {
					$thumb = $this->model_tool_image->resize('no-image.jpg',$this->config->get('config_image_news_width'), $this->config->get('config_image_news_height'));				
				}
				$this->data['images'][] = array(
					'name'	=> $this->config->get('config_language_id') == 2 ? $image['name'] : $image['name_en'],
					'date_added'	=> $image['date_added'],
					'thumb'	=> $thumb,
					'href'	=> $this->url->link('gallery/image', '&gallimage_id='. $image['gallimage_id'])
				);
			}
			
			
			$url = '';

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}
			
			$url = '';		
			
			$this->data['limits'] = array();
			
			$this->data['limits'][] = array(
				'text'  => $this->config->get('config_catalog_limit'),
				'value' => $this->config->get('config_catalog_limit'),
				'href'  => $this->url->link('gallery/image', $url . '&limit=' . $this->config->get('config_catalog_limit'))
			);

			$this->data['limits'][] = array(
				'text'  => 25,
				'value' => 25,
				'href'  => $this->url->link('gallery/image', $url . '&limit=25')
			);
			
			$this->data['limits'][] = array(
				'text'  => 50,
				'value' => 50,
				'href'  => $this->url->link('gallery/image', $url . '&limit=50')
			);

			$this->data['limits'][] = array(
				'text'  => 75,
				'value' => 75,
				'href'  => $this->url->link('gallery/image', $url . '&limit=75')
			);
			
			$this->data['limits'][] = array(
				'text'  => 100,
				'value' => 100,
				'href'  => $this->url->link('gallery/image', $url . '&limit=100')
			);
						
			$url = '';			

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}
					
			$pagination = new Pagination();
			$pagination->total = $images_total;
			$pagination->page = $page;
			$pagination->limit = $limit;
			$pagination->text = $this->language->get('text_pagination');
			$pagination->url = $this->url->link('gallery/image', $url . '&page={page}');
		
			$this->data['pagination'] = $pagination->render();		
			
			$this->data['limit'] = $limit;
		
			$this->data['continue'] = $this->url->link('news/all');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/gallery/image.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/gallery/image.tpl';
			} else {
				$this->template = 'default/template/gallery/image.tpl';
			}
			
			$this->children = array(
				'common/column_left',
				'common/adv_top',				
				'common/column_right',
				'common/content_top',
				'common/content_bottom',
				'common/footer',
				'common/header'
			);
				
			$this->response->setOutput($this->render());	
			
		}
		
											
	}
	public function detail(){
		$this->load->model('catalog/gallimage');
		$images = $this->model_catalog_gallimage->getGallimage($this->request->get['gallimage_id']);
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/gallery/image.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/gallery/image.tpl';
		} else {
			$this->template = 'default/template/gallery/image.tpl';
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
  
}
?>