<?php

class ControllerNewsNews extends Controller {

    private $error = array();

    public function index() {
        $this->language->load('news/news');
        $this->load->model('catalog/news');
        $this->data['rate'] = $this->model_catalog_news->getRate($this->request->get['news_id']);
        if ($this->data['rate']['total_rate'] == 0) {
            $this->data['rate']['total_rate'] = 1;
            $this->data['rate']['total_point'] = 5;
        }
        $this->data['average'] = round($this->data['rate']['total_point'] / $this->data['rate']['total_rate']);

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home'),
            'separator' => false
        );

/*
        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_news'),
            'href' => $this->url->link('news/all', ''),
            'separator' => $this->language->get('text_separator')
        );
*/
        // OSD with love. Edit in front_end
        $this->load->library('user');
        $this->user = new User($this->registry);

        $this->data['admin_logged'] = false;
        if ($this->user->isLogged()) {
            $this->data['admin_logged'] = true;
            $this->data['edit'] = HTTP_SERVER . "admin/index.php?route=catalog/news/update&token=" . $this->session->data['token'] . "&news_id=" . $this->request->get['news_id'];
            $this->data['token'] = $this->session->data['token'];
        }
        // OSD with love. Edit in front_end

        $this->load->model('catalog/news_category');

        if (isset($this->request->get['cat_id'])) {
            $cat_id = '';

            foreach (explode('_', $this->request->get['cat_id']) as $cat_id_item) {
                if (!$cat_id) {
                    $cat_id = $cat_id_item;
                } else {
                    $cat_id .= '_' . $cat_id_item;
                }

                $news_category_info = $this->model_catalog_news_category->getNewsCategory($cat_id_item);

                if ($news_category_info) {
                    $this->data['breadcrumbs'][] = array(
                        'text' => $news_category_info['name'],
                        'href' => $this->url->link('news/news_category', 'cat_id=' . $cat_id),
                        'separator' => $this->language->get('text_separator')
                    );
                }
            }
        } elseif(isset($this->request->get['news_id'])) {
			
            $news_category = $this->model_catalog_news->getNewsCategories($this->request->get['news_id']);
			$news_category_info = $this->model_catalog_news_category->getNewsCategory($news_category[0]['news_category_id']);
			$this->data['breadcrumbs'][] = array(
				'text' => $news_category_info['name'],
				'href' => $this->url->link('news/news_category', 'cat_id=' . $news_category[0]['news_category_id']),
				'separator' => $this->language->get('text_separator')
			);
			
        } else {
            $news_category_info = 0;
        }

        if (isset($this->request->get['filter_name_news']) || isset($this->request->get['filter_tag'])) {
            $url = '';

            if (isset($this->request->get['filter_name_news'])) {
                $url .= '&filter_name_news=' . $this->request->get['filter_name_news'];
            }

            if (isset($this->request->get['filter_tag'])) {
                $url .= '&filter_tag=' . $this->request->get['filter_tag'];
            }

            if (isset($this->request->get['filter_description'])) {
                $url .= '&filter_description=' . $this->request->get['filter_description'];
            }

            if (isset($this->request->get['filter_news_category_id'])) {
                $url .= '&filter_news_category_id=' . $this->request->get['filter_news_category_id'];
            }

            $this->data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_search'),
                'href' => $this->url->link('news/search', $url),
                'separator' => $this->language->get('text_separator')
            );
        }

        if (isset($this->request->get['news_id'])) {
            $news_id = $this->request->get['news_id'];
        } else {
            $news_id = 0;
        }

        $this->load->model('catalog/news');

        $news_info = $this->model_catalog_news->getNew($news_id);

        $this->data['news_info'] = $news_info;

        if ($news_info) {
	        $categories = $this->model_catalog_news->getNewsCategories($this->request->get['news_id']);
			$category_id = $categories[0]['news_category_id'];
			$this->data['cat_id'] = $categories[0]['news_category_id'];
			$this->load->model('catalog/news_category');
			$category_info = $this->model_catalog_news_category->getNewsCategory($category_id);		
			$catname = $category_info['name'];
			
			/*
			$this->data['breadcrumbs'][] = array(
                'text' => $catname,
                'href' => $this->url->link('news/news_category', 'cat_id=' . $category_id),
                'separator' => $this->language->get('text_separator')
            );
			*/
            $url = '';

            if (isset($this->request->get['cat_id'])) {
                $url .= '&cat_id=' . $this->request->get['cat_id'];
            }

            if (isset($this->request->get['filter_name_news'])) {
                $url .= '&filter_name_news=' . $this->request->get['filter_name_news'];
            }

            if (isset($this->request->get['filter_tag'])) {
                $url .= '&filter_tag=' . $this->request->get['filter_tag'];
            }

            if (isset($this->request->get['filter_description'])) {
                $url .= '&filter_description=' . $this->request->get['filter_description'];
            }

            if (isset($this->request->get['filter_news_category_id'])) {
                $url .= '&filter_news_category_id=' . $this->request->get['filter_news_category_id'];
            }

            $this->data['breadcrumbs'][] = array(
                'text' => $news_info['name'],
                'href' => $this->url->link('news/news', $url . '&news_id=' . $this->request->get['news_id']),
                'separator' => $this->language->get('text_separator')
            );

            if (strlen($news_info['meta_title']) > 1) {
                $title = $news_info['meta_title'];
            } else {
                $title = $news_info['name'];
            }
            
            $this->document->setTitle($title); 
            $this->document->setMetanames('description',$news_info['meta_description']);
            
            if (strlen($news_info['meta_description']) > 1) {
                $meta_description = $news_info['meta_description'];
            } else {
                $meta_description = $news_info['short_description'];
            }
            
            $sitename= $this->config->get('config_name');
            $current_url = $this->url->link('news/news', 'news_id=' . $this->request->get['news_id']);
            
            //open graph
            $this->document->setMetapros('og:type','article');
            $this->document->setMetapros('og:title',$title);
            $this->document->setMetapros('og:description',$meta_description);
            $this->document->setMetapros('og:url',$current_url);
            $this->document->setMetapros('og:image',HTTP_SERVER.'image/' . $news_info['image']);
            $this->document->setMetapros('og:site_name',$sitename);            
            //open graph            

            $this->document->setMetapros('article:published_time',date('c', strtotime($news_info['date_available'])));
            $this->document->setMetapros('article:modified_time',date('c', strtotime($news_info['date_modified'])));
            $this->document->setMetapros('article:section',$catname);
            
            $this->document->addLink($current_url, 'canonical');

            $this->data['heading_title'] = $news_info['name'];
            $this->data['url'] = $current_url;

            $this->data['text_select'] = $this->language->get('text_select');
            $this->data['text_share'] = $this->language->get('text_share');
            $this->data['text_wait'] = $this->language->get('text_wait');
            $this->data['text_tags'] = $this->language->get('text_tags');
            $this->data['text_write'] = $this->language->get('text_write');
            $this->data['text_post_on'] = $this->language->get('text_post_on');
            $this->data['text_viewed'] = $this->language->get('text_viewed');

            $this->data['entry_name'] = $this->language->get('entry_name');
            $this->data['entry_email'] = $this->language->get('entry_email');
            $this->data['entry_rating'] = $this->language->get('entry_rating');
            $this->data['entry_good'] = $this->language->get('entry_good');
            $this->data['entry_bad'] = $this->language->get('entry_bad');
            $this->data['entry_captcha'] = $this->language->get('entry_captcha');

            $this->data['button_send'] = $this->language->get('button_send');
            $this->data['button_continue'] = $this->language->get('button_continue');
            $this->data['continue'] = $this->url->link('news/all');

            $this->data['tab_description'] = $this->language->get('tab_description');
            $this->data['tab_related'] = $this->language->get('tab_related');
            $this->data['tab_others'] = $this->language->get('tab_others');

            $this->data['news_id'] = $this->request->get['news_id'];

            $this->load->model('tool/image');

            if ($news_info['image']) {
                $this->data['popup'] = $this->model_tool_image->resize($news_info['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));
            } else {
                $this->data['popup'] = '';
            }

            if ($news_info['image']) {
                $this->data['thumb'] = $this->model_tool_image->resize($news_info['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'));
            } else {
                $this->data['thumb'] = '';
            }
            $this->data['date_added'] = date($this->language->get('date_format_short'), strtotime($news_info['date_available']));
            $this->data['short_description'] = html_entity_decode($news_info['short_description'], ENT_QUOTES, 'UTF-8');
            $this->data['description'] = html_entity_decode($news_info['description'], ENT_QUOTES, 'UTF-8');
            $this->data['viewed'] = $news_info['viewed'];

            $this->data['current_url'] = $this->url->link('news/news', $url . '&news_id=' . $this->request->get['news_id']);


            $this->data['news'] = array();

            $results = $this->model_catalog_news->getNewsRelated($this->request->get['news_id']);

            foreach ($results as $result) {
                if ($result['image']) {
                    $image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_related_width'), $this->config->get('config_image_related_height'));
                } else {
                    $image = false;
                }

                $this->data['news'][] = array(
                    'news_id' => $result['news_id'],
                    'thumb' => $image,
                    'name' => $result['name'],
                    'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_available'])),
                    'href' => $this->url->link('news/news', $url . '&news_id=' . $result['news_id']),
                );
            }

            // other news
            $this->data['other_news'] = array();

            $results = $this->model_catalog_news->getOtherNews($news_category_info['news_category_id'], $this->request->get['news_id'], 5);

            foreach ($results as $result) {
                if ($result['image']) {
                    $image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_related_width'), $this->config->get('config_image_related_height'));
                } else {
                    $image = false;
                }

                $this->data['other_news'][] = array(
                    'news_id' => $result['news_id'],
                    'thumb' => $image,
                    'name' => $result['name'],
                    'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
                    'href' => $this->url->link('news/news', $url . '&news_id=' . $result['news_id']),
                );
            }

            $this->data['tags'] = array();

            $results = $this->model_catalog_news->getNewsTags($this->request->get['news_id']);

            foreach ($results as $result) {
                $this->data['tags'][] = array(
                    'tag' => $result['tag'],
                    'href' => $this->url->link('news/search', 'filter_tag=' . $result['tag'])
                );
            }

            $this->model_catalog_news->updateViewed($this->request->get['news_id']);

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/news/news.tpl')) {
                $this->template = $this->config->get('config_template') . '/template/news/news.tpl';
            } else {
                $this->template = 'default/template/news/news.tpl';
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
        } else {
            $url = '';

            if (isset($this->request->get['cat_id'])) {
                $url .= '&cat_id=' . $this->request->get['cat_id'];
            }

            if (isset($this->request->get['manufacturer_id'])) {
                $url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
            }

            if (isset($this->request->get['filter_name_news'])) {
                $url .= '&filter_name_news=' . $this->request->get['filter_name_news'];
            }

            if (isset($this->request->get['filter_tag'])) {
                $url .= '&filter_tag=' . $this->request->get['filter_tag'];
            }

            if (isset($this->request->get['filter_description'])) {
                $url .= '&filter_description=' . $this->request->get['filter_description'];
            }

            if (isset($this->request->get['filter_news_category_id'])) {
                $url .= '&filter_news_category_id=' . $this->request->get['filter_news_category_id'];
            }

            $this->data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_error'),
                'href' => $this->url->link('news/news', $url . '&news_id=' . $news_id),
                'separator' => $this->language->get('text_separator')
            );

            $this->document->setTitle($this->language->get('text_error'));

            $this->data['heading_title'] = $this->language->get('text_error');

            $this->data['text_error'] = $this->language->get('text_error');

            $this->data['button_continue'] = $this->language->get('button_continue');

            $this->data['continue'] = $this->url->link('common/home');

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
                $this->template = $this->config->get('config_template') . '/template/error/not_found.tpl';
            } else {
                $this->template = 'default/template/error/not_found.tpl';
            }

            $this->children = array(
				'common/adv_top',            
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

    public function rate() {
        $this->load->model('catalog/news');
//            if ($this->request->server['REQUEST_METHOD'] == 'POST') {
        $this->model_catalog_news->setRate($this->request->get['news_id'], $this->request->post, $this->request->get['point']);
//            }
        $rate = $this->model_catalog_news->getRate($this->request->get['news_id']);
        $json = ''; //array();
//          $this->session->data['sql'] = $rate['total_rate'];
//        $json['total_vote'] = 'Tổng số rate: ' . $rate['total_rate'];
        $json = $rate['total_rate'];
//            $json['total_point'] = $rate['total_point'];
//        $json['average'] = 'Trung bình: ' . round($rate['total_point'] / $rate['total_rate'], 1);
        $json .= ',' . round($rate['total_point'] / $rate['total_rate'], 1);
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

}

?>