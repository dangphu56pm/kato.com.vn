<?php

class ControllerProductProduct extends Controller {

    private $error = array();

    public function index() {
//        print_r($this->session->data['sql']);
//            print_r(1);
        $this->language->load('product/product');
        $this->load->model('tool/image');
        $this->load->model('catalog/product');
        $this->data['rate'] = $this->model_catalog_product->getRate($this->request->get['product_id']);
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
        
        // OSD with love. Edit in front_end
        $this->load->library('user');
        $this->user = new User($this->registry);

        $this->data['admin_logged'] = false;
        if ($this->user->isLogged()) {
            $this->data['admin_logged'] = true;
            $this->data['edit'] = HTTP_SERVER . "admin/index.php?route=catalog/product/update&token=" . $this->session->data['token'] . "&product_id=" . $this->request->get['product_id'];
            $this->data['token'] = $this->session->data['token'];
        }
        // OSD with love. Edit in front_end

        $this->load->model('catalog/category');
        $this->data['hotline2'] = $this->config->get('config_hotline');
        // Tin lien quan

        $this->load->model('catalog/news');
        $this->load->model('catalog/product');

        $results_news = array();

        $results_news = $this->model_catalog_product->getProductNews($this->request->get['product_id']);

        foreach ($results_news as $result) {
            $width = '';
            $height = '';
            if ($result['image']) {
                $image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_news_width'), $this->config->get('config_image_news_height'));
            } else {
                $firstImgNews = $this->catchFirstImage(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8'));
                if ($firstImgNews == 'no_image.jpg') {
                    $image = $this->model_tool_image->resize('no_image.jpg', $this->config->get('config_image_news_width'), $this->config->get('config_image_news_height'));
                } else {
                    $image = $firstImgNews;
                    $width = 'width="' . $this->config->get('config_image_news_width') . '"';
                    $height = 'height="' . $this->config->get('config_image_news_height') . '"';
                }
            }


            $this->data['news_relateds'][] = array(
                'news_id' => $result['news_id'],
                'thumb' => $image,
                'name' => $result['name'],
                'width' => $width,
                'height' => $height,
                'href' => $this->url->link('news/news', '&news_id=' . $result['news_id'])
            );
        }

        if (isset($this->request->get['path'])) {
            $path = '';

            $parts = explode('_', (string) $this->request->get['path']);

            $category_id = (int) array_pop($parts);

            foreach ($parts as $path_id) {
                if (!$path) {
                    $path = $path_id;
                } else {
                    $path .= '_' . $path_id;
                }

                $category_info = $this->model_catalog_category->getCategory($path_id);

                if ($category_info) {
                    $this->data['breadcrumbs'][] = array(
                        'text' => $category_info['name'],
                        'href' => $this->url->link('product/category', 'path=' . $path),
                        'separator' => $this->language->get('text_separator')
                    );
                }
            }


            $category_info = $this->model_catalog_category->getCategory($category_id);

            if ($category_info) {
                $url = '';

                if (isset($this->request->get['sort'])) {
                    $url .= '&sort=' . $this->request->get['sort'];
                }

                if (isset($this->request->get['order'])) {
                    $url .= '&order=' . $this->request->get['order'];
                }

                if (isset($this->request->get['page'])) {
                    $url .= '&page=' . $this->request->get['page'];
                }

                if (isset($this->request->get['limit'])) {
                    $url .= '&limit=' . $this->request->get['limit'];
                }

                $this->data['breadcrumbs'][] = array(
                    'text' => $category_info['name'],
                    'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url),
                    'separator' => $this->language->get('text_separator')
                );
            }
        } elseif (isset($this->request->get['product_id'])) {

            $news_category = $this->model_catalog_product->getCategories($this->request->get['product_id']);
            $category_info = $this->model_catalog_category->getCategory($news_category[0]['category_id']);
            $this->data['breadcrumbs'][] = array(
                'text' => $category_info['name'],
                'href' => $this->url->link('product/category', 'path=' . $news_category[0]['category_id']),
                'separator' => $this->language->get('text_separator')
            );
        } else {
            $category_info = 0;
        }
//        print_r($category_info);

        $this->load->model('catalog/manufacturer');

        if (isset($this->request->get['manufacturer_id'])) {
            $this->data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_brand'),
                'href' => $this->url->link('product/manufacturer'),
                'separator' => $this->language->get('text_separator')
            );

            $url = '';

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }

            $manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($this->request->get['manufacturer_id']);

            if ($manufacturer_info) {
                $this->data['breadcrumbs'][] = array(
                    'text' => $manufacturer_info['name'],
                    'href' => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . $url),
                    'separator' => $this->language->get('text_separator')
                );
            }
        }

        if (isset($this->request->get['search']) || isset($this->request->get['tag'])) {
            $url = '';

            if (isset($this->request->get['search'])) {
                $url .= '&search=' . $this->request->get['search'];
            }

            if (isset($this->request->get['tag'])) {
                $url .= '&tag=' . $this->request->get['tag'];
            }

            if (isset($this->request->get['description'])) {
                $url .= '&description=' . $this->request->get['description'];
            }

            if (isset($this->request->get['category_id'])) {
                $url .= '&category_id=' . $this->request->get['category_id'];
            }

            if (isset($this->request->get['sub_category'])) {
                $url .= '&sub_category=' . $this->request->get['sub_category'];
            }

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }

            $this->data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_search'),
                'href' => $this->url->link('product/search', $url),
                'separator' => $this->language->get('text_separator')
            );
        }

        if (isset($this->request->get['product_id'])) {
            $product_id = (int) $this->request->get['product_id'];
        } else {
            $product_id = 0;
        }

        $this->load->model('catalog/product');

        $product_info = $this->model_catalog_product->getProduct($product_id);
//        print_r($product_info);


        if ($product_info) {
            $url = '';

            if (isset($this->request->get['path'])) {
                $url .= '&path=' . $this->request->get['path'];
            }

            if (isset($this->request->get['filter'])) {
                $url .= '&filter=' . $this->request->get['filter'];
            }

            if (isset($this->request->get['manufacturer_id'])) {
                $url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
            }

            if (isset($this->request->get['search'])) {
                $url .= '&search=' . $this->request->get['search'];
            }

            if (isset($this->request->get['tag'])) {
                $url .= '&tag=' . $this->request->get['tag'];
            }

            if (isset($this->request->get['description'])) {
                $url .= '&description=' . $this->request->get['description'];
            }

            if (isset($this->request->get['category_id'])) {
                $url .= '&category_id=' . $this->request->get['category_id'];
            }

            if (isset($this->request->get['sub_category'])) {
                $url .= '&sub_category=' . $this->request->get['sub_category'];
            }

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }

            $this->data['breadcrumbs'][] = array(
                'text' => $product_info['name'],
                'href' => $this->url->link('product/product', $url . '&product_id=' . $this->request->get['product_id']),
                'separator' => $this->language->get('text_separator')
            );

            if (strlen($product_info['meta_title']) > 1) {
                $title = $product_info['meta_title'];
            } else {
                $title= $product_info['name'];
            }
            
            if (strlen($product_info['meta_description']) > 1) {
                $meta_description = $product_info['meta_description'];
            } else {
                $meta_description = utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, 300) . '...';
            }
                        
            $this->document->setTitle($title);
            $this->document->setMetanames('description',$product_info['meta_description']);
            $current_url = $this->url->link('product/product', 'product_id=' . $this->request->get['product_id']);
            $sitename= $this->config->get('config_name');
            //open graph
            $this->document->setMetapros('og:locate',$this->language->get('locate'));            
            $this->document->setMetapros('og:type','article');
            $this->document->setMetapros('og:title',$title);
            $this->document->setMetapros('og:description',$meta_description);
            $this->document->setMetapros('og:url',$current_url);
            $this->document->setMetapros('og:image',HTTP_SERVER.'image/' . $product_info['image']);
            $this->document->setMetapros('og:site_name',$sitename);
            
            $this->document->setMetapros('article:published_time',date('c', strtotime($product_info['date_available'])));
            $this->document->setMetapros('article:modified_time',date('c', strtotime($product_info['date_modified'])));
            $this->document->setMetapros('article:section',$category_info['name']);


            $this->document->addLink($current_url, 'canonical');
            $this->data['url'] = $current_url;
            
            $this->data['heading_title'] = $product_info['name'];

            $this->data['button_continue'] = $this->language->get('button_continue');

            $this->load->model('catalog/review');

            $this->data['tab_description'] = $this->language->get('tab_description');
            $this->data['tab_related'] = $this->language->get('tab_related');

            $this->data['product_id'] = $this->request->get['product_id'];
            $this->data['manufacturer'] = $product_info['manufacturer'];
            $this->data['manufacturers'] = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $product_info['manufacturer_id']);
            $this->data['model'] = $product_info['model'];
            $this->data['short_description'] = $product_info['short_description'];


            if ($product_info['image']) {
                $this->data['popup'] = 'image/' . $product_info['image'];
            } else {
                $this->data['popup'] = '';
            }

            if ($product_info['image']) {
                $this->data['thumb'] = 'image/' . $product_info['image'];
            } else {
                $this->data['thumb'] = '';
            }

            $this->data['images'] = array();

            $results = $this->model_catalog_product->getProductImages($this->request->get['product_id']);

            foreach ($results as $result) {
                $this->data['images'][] = array(
                    'popup' => 'image/' . $result['image'],
                    'thumb' => 'image/' . $result['image']
                );
            }

            $this->data['description'] = html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8');

            $this->data['products'] = array();
            
            $results = $this->model_catalog_product->getOtherProduct($this->request->get['product_id']);

            foreach ($results as $result) {
                if ($result['image']) {
                    $image =  $this->model_tool_image->resize($result['image'], $this->config->get('config_image_related_width'), $this->config->get('config_image_related_height'));
                } else {
                    $image = false;
                }

                $this->data['products'][] = array(
                    'product_id' => $result['product_id'],
                    'thumb' => $image,
                    'name' => $result['name'],
                    'href' => $this->url->link('product/product', 'product_id=' . $result['product_id'])
                );
            }

            $this->data['tags'] = array();

            if ($product_info['tag']) {
                $tags = explode(',', $product_info['tag']);
                foreach ($tags as $tag) {
                    $this->data['tags'][] = array(
                        'tag' => trim($tag),
                        'href' => $this->url->link('product/search', 'tag=' . trim($tag))
                    );
                }
            }

            $this->model_catalog_product->updateViewed($this->request->get['product_id']);

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/product.tpl')) {
                $this->template = $this->config->get('config_template') . '/template/product/product.tpl';
            } else {
                $this->template = 'default/template/product/product.tpl';
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
            $url = '';

            if (isset($this->request->get['path'])) {
                $url .= '&path=' . $this->request->get['path'];
            }

            if (isset($this->request->get['filter'])) {
                $url .= '&filter=' . $this->request->get['filter'];
            }

            if (isset($this->request->get['manufacturer_id'])) {
                $url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
            }

            if (isset($this->request->get['search'])) {
                $url .= '&search=' . $this->request->get['search'];
            }

            if (isset($this->request->get['tag'])) {
                $url .= '&tag=' . $this->request->get['tag'];
            }

            if (isset($this->request->get['description'])) {
                $url .= '&description=' . $this->request->get['description'];
            }

            if (isset($this->request->get['category_id'])) {
                $url .= '&category_id=' . $this->request->get['category_id'];
            }

            if (isset($this->request->get['sub_category'])) {
                $url .= '&sub_category=' . $this->request->get['sub_category'];
            }

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }

            $this->data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_error'),
                'href' => $this->url->link('product/product', $url . '&product_id=' . $product_id),
                'separator' => $this->language->get('text_separator')
            );

            $this->document->setTitle($this->language->get('text_error'));

            $this->data['heading_title'] = $this->language->get('text_error');

            $this->data['text_error'] = $this->language->get('text_error');

            $this->data['button_continue'] = $this->language->get('button_continue');

            $this->data['continue'] = $this->url->link('common/home');

            $this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . '/1.1 404 Not Found');

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
                $this->template = $this->config->get('config_template') . '/template/error/not_found.tpl';
            } else {
                $this->template = 'default/template/error/not_found.tpl';
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

    function catchFirstImage($content) {
        $first_img = '';
        $output = preg_match_all('/<img.+src=[\'"]([^\'"]+)[\'"].*>/i', $content, $matches);
        if (isset($matches[1][0])) {
            $first_img = $matches[1][0];
        }
        if (empty($first_img)) {
            $first_img = "no_image.jpg";
        }
        return $first_img;
    }


    public function rate() {
        $this->load->model('catalog/product');
        $this->model_catalog_product->setRate($this->request->get['product_id'], $this->request->post, $this->request->get['point']);
        $rate = $this->model_catalog_product->getRate($this->request->get['product_id']);
        $json = '';
        $json = $rate['total_rate'];
        $json .= ',' . round($rate['total_point'] / $rate['total_rate'], 1);
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

}

?>