<?php
class ControllerModuleVideo extends Controller {
	protected function index($setting) {
		$this->language->load('module/video'); 

		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['view_all'] = $this->language->get('view_all');
		
		$this->load->model('catalog/video'); 
		
		$this->data['videos'] = array();
		
		$data = array(
			'sort'  => 'v.date_add',
			'order' => 'DESC',
			'start' => 0,
			'limit' => $setting['limit']
		);

		$this->data['videos'][] = array();
		$results = $this->model_catalog_video->getVideos($data);
		
		foreach ($results as $video) {
			if(strlen($video['title'])>0){
				$this->data['videos'][] = array(
					'video_id' => $video['video_id'],
					'title'    	 => $video['title'],
					'href'    	 => $this->url->link('gallery/video', '&video_id=' . $video['video_id'])
				);
			}	
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/video.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/video.tpl';
		} else {
			$this->template = 'default/template/module/video.tpl';
		}

		$this->render();
	}
}
?>