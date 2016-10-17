<?php
class ControllerGalleryVideo extends Controller {  
	public function index() {
		$this->language->load('gallery/video');

		$this->load->model('catalog/video');
		$this->load->model('tool/image'); 
		
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
					
		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
       		'separator' => false
   		);	
   		$this->data['breadcrumbs'][] = array(
				'text'      => $this->language->get('heading_title'),
				'href'      => $this->url->link('gallery/video'),
				'separator' => $this->language->get('text_separator')
		);
		$limit = 12;
		$data = array(
			'sort'  => 'v.date_add',
			'order' => 'DESC',	
			'start'              => ($page - 1) * $limit,
			'limit'              => $limit
		);
		if(isset($this->request->get['video_id']) && !empty($this->request->get['video_id'])){
			
			$video_id = $this->request->get['video_id'];
			
			$video_info = $this->model_catalog_video->getVideo($video_id);
			
			$this->data['url'] 				= $video_info['url'];
			$this->data['heading_title'] 	= $video_info['title'];
			$this->data['date_add'] 		= date($this->language->get('date_format_short'), strtotime($video_info['date_add']));
			$this->data['description'] 		= html_entity_decode($video_info['description'], ENT_QUOTES, 'UTF-8');
			
			$this->document->setTitle($video_info['title']);
			
			$this->data['breadcrumbs'][] = array(
				'text'      => $video_info['title'],
				'href'      => $this->url->link('gallery/video','&video_id='.$video_id),
				'separator' => $this->language->get('text_separator')
			);
			
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/gallery/video_details.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/gallery/video_details.tpl';
			} else {
				$this->template = 'default/template/gallery/video_details.tpl';
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
		} else {
		
			$this->data['heading_title'] = $this->language->get('heading_title');
			$this->document->addScript('static/mediabox.js');		
			$this->document->setTitle($this->language->get('heading_title'));
		
			$video_total = $this->model_catalog_video->getTotalVideos(); 
			$this->data['video_total'] = $video_total;
			
			$this->data['videos'] = $this->model_catalog_video->getVideos($data);
			
			$url = '';
	
			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}
			
			$url = '';		
			
			$this->data['limits'] = array();
			
			$this->data['limits'][] = array(
				'text'  => $this->config->get('config_catalog_limit'),
				'value' => $this->config->get('config_catalog_limit'),
				'href'  => $this->url->link('gallery/video', $url . '&limit=' . $this->config->get('config_catalog_limit'))
			);
	
			$this->data['limits'][] = array(
				'text'  => 25,
				'value' => 25,
				'href'  => $this->url->link('gallery/video', $url . '&limit=25')
			);
			
			$this->data['limits'][] = array(
				'text'  => 50,
				'value' => 50,
				'href'  => $this->url->link('gallery/video', $url . '&limit=50')
			);
	
			$this->data['limits'][] = array(
				'text'  => 75,
				'value' => 75,
				'href'  => $this->url->link('gallery/video', $url . '&limit=75')
			);
			
			$this->data['limits'][] = array(
				'text'  => 100,
				'value' => 100,
				'href'  => $this->url->link('gallery/video', $url . '&limit=100')
			);
						
			$url = '';			
	
			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}
					
			$pagination = new Pagination();
			$pagination->total = $video_total;
			$pagination->page = $page;
			$pagination->limit = $limit;
			$pagination->text = $this->language->get('text_pagination');
			$pagination->url = $this->url->link('gallery/video', $url . '&page={page}');
		
			$this->data['pagination'] = $pagination->render();		
			
			$this->data['limit'] = $limit;
		
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/gallery/video.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/gallery/video.tpl';
			} else {
				$this->template = 'default/template/gallery/video.tpl';
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
  
	function catchFirstImage($content) {
		$first_img = ''; 
		$output = preg_match_all('/<img.+src=[\'"]([^\'"]+)[\'"].*>/i', $content, $matches);
		if(isset($matches[1][0])){
			$first_img = $matches[1][0];
		}
		if(empty($first_img)){ //Defines a default image
			$first_img = "no_image.jpg";
		}
		return $first_img;
	}
}
?>