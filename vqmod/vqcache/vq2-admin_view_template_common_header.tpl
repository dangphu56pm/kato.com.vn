<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
<meta charset="UTF-8" />
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="view/stylesheet/stylesheet.css" />
<?php foreach ($styles as $style) { ?>
<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<script type="text/javascript" src="view/javascript/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js"></script>
<link type="text/css" href="view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
<script type="text/javascript" src="view/javascript/jquery/ui/external/jquery.bgiframe-2.1.2.js"></script>
<script type="text/javascript" src="view/javascript/jquery/tabs.js"></script>
<script type="text/javascript" src="view/javascript/jquery/superfish/js/superfish.js"></script>
<script type="text/javascript" src="view/javascript/common.js"></script>
<script type="text/javascript" src="view/javascript/jquery/dlgmax/dlgmax.js"></script>
<?php foreach ($scripts as $script) { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>
<script type="text/javascript">
//-----------------------------------------
// Confirm Actions (delete, uninstall)
//-----------------------------------------
$(document).ready(function(){
    // Confirm Delete
    $('#form').submit(function(){
        if ($(this).attr('action').indexOf('delete',1) != -1) {
            if (!confirm('<?php echo $text_confirm; ?>')) {
                return false;
            }
        }
    });
    // Confirm Uninstall
    $('a').click(function(){
        if ($(this).attr('href') != null && $(this).attr('href').indexOf('uninstall', 1) != -1) {
            if (!confirm('<?php echo $text_confirm; ?>')) {
                return false;
            }
        }
    });
        });
    </script>

        <script type="text/javascript">
          $(document).ready(function(){
          var keyword = $("input[name=keyword]");
          if(!keyword.val()){
            $("input[name^='product_description'],input[name^='category_description'],input[name^='news_category_description'],input[name^='news_description'],input[name^='information_description'],input[name^='model']").keyup(function(){
              var SEOlink = $("input[name^='product_description'],input[name^='category_description'],input[name^='news_category_description'],input[name^='news_description'],input[name^='information_description']").val();
              // var SEOlink = $(this).val();
                SEOlink = SEOlink.replace(/^\s+|\s+$/g, ''); // trim
                SEOlink = SEOlink.toLowerCase();
              // remove accents, swap, etc
              var from = "đĐÀàÁáẠạẢảÃãÂâẦầẤấẬậẨẩẪẫĂăẮắẴẵẶặẰằẲẳÈèÉéẸẹẺẻẼẽÊêỀềẾếỆệỂểỄễÌìÍíỊịỈỉĨĩÒòÓóỌọỎỏÕõÔôỘộỐốỖỗỒồỔổƠơỜờỚớỢợỞởỠỡỲỳÝýỴỵỶỷỸỹÙùÚúỤụỦủŨũƯưỪừỨứỰựỬửỮữnrrd·/_,:;";
              var to   = "ddaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeeeeeeeeeeeeeeeeeeeeeeiiiiiiiiiiooooooooooooooooooooooooooooooooooyyyyyyyyyyuuuuuuuuuuuuuuuuuuuuuunrrd------";
              for (var i=0, l=from.length ; i<l ; i++) {
                SEOlink = SEOlink.replace(new RegExp(from.charAt(i), 'g'), to.charAt(i));
              }
              SEOlink = SEOlink.replace(/[^a-z0-9 -]/g, '') // remove invalid chars
              .replace(/\s+/g, '-') // collapse whitespace and replace by -
              .replace(/-+/g, '-'); // collapse dashes
              // return SEOlink;
              /*
              // model
              if ($("input[name^='product_description'],input[name^='information_description'],input[name^='name']").length){
                var model = $("input[name^='model']").val();
                  model = model.replace(/^\s+|\s+$/g, ''); // trim
                  model = model.toLowerCase();

                for (var i=0, l=from.length ; i<l ; i++) {
                  model = model.replace(new RegExp(from.charAt(i), 'g'), to.charAt(i));
                }
                model = model.replace(/[^a-z0-9 -]/g, '') // remove invalid chars
                .replace(/\s+/g, '-') // collapse whitespace and replace by -
                .replace(/-+/g, '-'); // collapse dashes
                if (!$("input[name^='model']").val()=='') { model = model+'-'; }
                // return model;
              }
              // end model
              if (model) {
                keyword.val(model+SEOlink);
              } else {
              */
				// will fill .html if here is information page, news details page, productpage	
				if($("input[name^='product_description'],input[name^='information_description'],input[name^='news_description']").length){
					SEOlink += '.html';
				}
                keyword.val(SEOlink);
            });
          }
        });
          </script>
        
</head>
<body>
<div id="container">
    <div id="header">
  <div class="div1">
    <div class="div2"><img src="view/image/logo.png" title="<?php echo $heading_title; ?>" onclick="location = '<?php echo $home; ?>'" /></div>
    <?php if ($logged) { ?>
    <div class="div3"><img src="view/image/lock.png" alt="" style="position: relative; top: 3px;" />&nbsp;<?php echo $logged; ?></div>
    <?php } ?>
  </div>
  <?php if ($logged) { ?>
  <div id="menu">
    <ul class="left" style="display: none;">
      <li id="dashboard"><a href="<?php echo $home; ?>" class="top"><?php echo $text_dashboard; ?></a></li>
      <li id="catalog"><a class="top"><?php echo $text_catalog; ?></a>
        <ul>
          <li><a href="<?php echo $product; ?>"><?php echo $text_product; ?></a></li>
	      <li><a href="<?php echo $news; ?>"><?php echo $text_news; ?></a></li>

			<li style="display:none"><a href="<?php echo $gallimage; ?>">Thư viện hình ảnh</a></li>
			<li style="display:none"><a href="<?php echo $gallery_youtube; ?>">Thư viện video</a></li>
			
		  <li><a href="<?php echo $banner; ?>"><?php echo $text_banner; ?></a></li>		  
		  <li>
          		<a class="parent" href="<?php echo $category; ?>">Quản lý danh mục</a>
          		<ul>
	          		<li><a href="<?php echo $category; ?>"><?php echo $text_category; ?> sản phẩm</a></li>
	          		<li><a href="<?php echo $news_category; ?>"><?php echo $text_news_category; ?></a></li>
          		</ul>
          </li> 		  
          <li><a href="<?php echo $information; ?>"><?php echo $text_information; ?></a></li>
<li><a href="<?php echo $filemanager; ?>"><?php echo $text_filemanager; ?></a></li>
          <li><a href="<?php echo $faq; ?>">FAQs</a></li>
          <li style="display:none"><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>          
        </ul>
      </li>
      <li id="extension"><a class="top"><?php echo $text_extension; ?></a>
        <ul>
          <li><a href="<?php echo $module; ?>"><?php echo $text_module; ?></a></li>
          <li><a href="<?php echo $menu; ?>"><?php echo "Quản lý menu"; ?></a></li>
		  <li><a href="<?php echo $redirect; ?>">Redirect</a></li>
          <li><a href="<?php echo $feed; ?>"><?php echo $text_feed; ?></a></li>
        </ul>
      </li>
      <li  style="display:none" id="sale"><a class="top"><?php echo $text_sale; ?></a>
        <ul>
          <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
          <li><a href="<?php echo $recurring_profile; ?>"><?php echo $text_recurring_profile; ?></a></li>
          <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
          <li><a class="parent"><?php echo $text_customer; ?></a>
            <ul>
              <li><a href="<?php echo $customer; ?>"><?php echo $text_customer; ?></a></li>
              <li><a href="<?php echo $customer_group; ?>"><?php echo $text_customer_group; ?></a></li>
              <li><a href="<?php echo $customer_ban_ip; ?>"><?php echo $text_customer_ban_ip; ?></a></li>
            </ul>
          </li>
          <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
          <li><a href="<?php echo $coupon; ?>"><?php echo $text_coupon; ?></a></li>
          <li><a class="parent"><?php echo $text_voucher; ?></a>
            <ul>
              <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
              <li><a href="<?php echo $voucher_theme; ?>"><?php echo $text_voucher_theme; ?></a></li>
            </ul>
          </li>
          <!-- PAYPAL MANAGE NAVIGATION LINK -->
          <?php if ($pp_express_status) { ?>
           <li><a class="parent" href="<?php echo $paypal_express; ?>"><?php echo $text_paypal_express; ?></a>
             <ul>
               <li><a href="<?php echo $paypal_express_search; ?>"><?php echo $text_paypal_express_search; ?></a></li>
             </ul>
           </li>
          <?php } ?>
          <!-- PAYPAL MANAGE NAVIGATION LINK END -->
          <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
        </ul>
      </li>
      <li id="system"><a class="top"><?php echo $text_system; ?></a>
        <ul>
          <li><a href="<?php echo $setting; ?>"><?php echo $text_setting; ?></a></li>
          
          
          <li><a class="parent"><?php echo $text_users; ?></a>
            <ul>
              <li><a href="<?php echo $user; ?>"><?php echo $text_user; ?></a></li>
              <li><a href="<?php echo $user_group; ?>"><?php echo $text_user_group; ?></a></li>
            </ul>
          </li>
          <li><a class="parent"><?php echo $text_localisation; ?></a>
            <ul>
              <li><a href="<?php echo $language; ?>"><?php echo $text_language; ?></a></li>
              <li><a href="<?php echo $currency; ?>"><?php echo $text_currency; ?></a></li>
              <li style="display:none"><a href="<?php echo $stock_status; ?>"><?php echo $text_stock_status; ?></a></li>
              <li style="display:none"><a href="<?php echo $order_status; ?>"><?php echo $text_order_status; ?></a></li>
              <li style="display:none"><a class="parent"><?php echo $text_return; ?></a>
                <ul>
                  <li><a href="<?php echo $return_status; ?>"><?php echo $text_return_status; ?></a></li>
                  <li><a href="<?php echo $return_action; ?>"><?php echo $text_return_action; ?></a></li>
                  <li><a href="<?php echo $return_reason; ?>"><?php echo $text_return_reason; ?></a></li>
                </ul>
              </li>
              <li style="display:none"><a href="<?php echo $country; ?>"><?php echo $text_country; ?></a></li>
              <li style="display:none"><a href="<?php echo $zone; ?>"><?php echo $text_zone; ?></a></li>
              <li style="display:none"><a href="<?php echo $geo_zone; ?>"><?php echo $text_geo_zone; ?></a></li>
              <li style="display:none"><a class="parent"><?php echo $text_tax; ?></a>
                <ul>
                  <li><a href="<?php echo $tax_class; ?>"><?php echo $text_tax_class; ?></a></li>
                  <li><a href="<?php echo $tax_rate; ?>"><?php echo $text_tax_rate; ?></a></li>
                </ul>
              </li>
            </ul>
          </li>
          <li><a href="<?php echo $error_log; ?>"><?php echo $text_error_log; ?></a></li>
          <li><a href="<?php echo $backup; ?>"><?php echo $text_backup; ?></a></li>
        </ul>
      </li>

    </ul>
    <ul class="right" style="display: none;">
      <li id="store"><a href="<?php echo $store; ?>" target="_blank" class="top"><?php echo "Xem website";?></a>
        <ul>
          <?php foreach ($stores as $stores) { ?>
          <li><a href="<?php echo $stores['href']; ?>" target="_blank"><?php echo $stores['name']; ?></a></li>
          <?php } ?>
        </ul>
      </li>
      <li><a class="top" href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
    </ul>
    <script type="text/javascript"><!--
$(document).ready(function() {
	$('#menu > ul').superfish({
		hoverClass	 : 'sfHover',
		pathClass	 : 'overideThisToUse',
		delay		 : 0,
		animation	 : {height: 'show'},
		speed		 : 'normal',
		autoArrows   : false,
		dropShadows  : false, 
		disableHI	 : false, /* set to true to disable hoverIntent detection */
		onInit		 : function(){},
		onBeforeShow : function(){},
		onShow		 : function(){},
		onHide		 : function(){}
	});
	
	$('#menu > ul').css('display', 'block');
});
 
function getURLVar(urlVarName) {
	var urlHalves = String(document.location).toLowerCase().split('?');
	var urlVarValue = '';
	
	if (urlHalves[1]) {
		var urlVars = urlHalves[1].split('&');

		for (var i = 0; i <= (urlVars.length); i++) {
			if (urlVars[i]) {
				var urlVarPair = urlVars[i].split('=');
				
				if (urlVarPair[0] && urlVarPair[0] == urlVarName.toLowerCase()) {
					urlVarValue = urlVarPair[1];
				}
			}
		}
	}
	
	return urlVarValue;
} 

$(document).ready(function() {
	route = getURLVar('route');
	
	if (!route) {
		$('#dashboard').addClass('selected');
	} else {
		part = route.split('/');
		
		url = part[0];
		
		if (part[1]) {
			url += '/' + part[1];
		}
		
		$('a[href*=\'' + url + '\']').parents('li[id]').addClass('selected');
	}
});
//--></script> 
  </div>
  <?php } ?>
</div>
