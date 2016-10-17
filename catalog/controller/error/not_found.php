<?php

class ControllerErrorNotFound extends Controller {

    public function index() {

//        $current_url = explode('/', $_SERVER["REQUEST_URI"]);
//        $current_url = end($current_url);
        $current_url = substr($_SERVER["REQUEST_URI"], 1);
        $this->load->model('tool/redirect');
//        $redirect_info = $this->model_tool_redirect->getRedirect($current_url);
        $redirect_info = $this->model_tool_redirect->getRedirect(HTTP_SERVER . $current_url);
//        if (isset($redirect_info['new_url']) && ($current_url == isset($redirect_info['old_url']))) {
        if (isset($redirect_info) && (HTTP_SERVER . $current_url == isset($redirect_info['old_url']))) {
            header("HTTP/1.1 301 Moved Permanently");
//            header("Location: ". HTTP_SERVER . $redirect_info['new_url']);
            header("Location: " . HTTP_SERVER . substr($redirect_info['new_url'], strlen(HTTP_SERVER)));
        } else {

            $this->language->load('error/not_found');

            $this->document->settitle($this->language->get('heading_title'));

            $this->data['breadcrumbs'] = array();

            $this->data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_home'),
                'href' => $this->url->link('common/home'),
                'separator' => false
            );

            if (isset($this->request->get['route'])) {
                $data = $this->request->get;

                unset($data['_route_']);

                $route = $data['route'];

                unset($data['route']);

                $url = '';

                if ($data) {
                    $url = '&' . urldecode(http_build_query($data, '', '&'));
                }

                if (isset($this->request->server['https']) && (($this->request->server['https'] == 'on') || ($this->request->server['https'] == '1'))) {
                    $connection = 'ssl';
                } else {
                    $connection = 'nonssl';
                }

                $this->data['breadcrumbs'][] = array(
                    'text' => $this->language->get('heading_title'),
                    'href' => $this->url->link($route, $url, $connection),
                    'separator' => $this->language->get('text_separator')
                );
            }

            $this->data['heading_title'] = $this->language->get('heading_title');

            $this->data['text_error'] = $this->language->get('text_error');

            $this->data['button_continue'] = $this->language->get('button_continue');

            $this->response->addheader($this->request->server['SERVER_PROTOCOL'] . '/1.1 404 not found');

            $this->data['continue'] = $this->url->link('common/home');

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
                $this->template = $this->config->get('config_template') . '/template/error/not_found.tpl';
            } else {
                $this->template = 'default/template/error/not_found.tpl';
            }

            $this->children = array(
                'common/column_left',
                'common/column_right',
                'common/content_top',
                'common/adv_top',                
                'common/content_bottom',
                'common/footer',
                'common/header'
            );

            $this->response->setoutput($this->render());
        }
    }

}

?>