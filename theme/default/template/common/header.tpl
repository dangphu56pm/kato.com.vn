<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" prefix="og:http://ogp.me/ns#" class="no-js">
<head>
<meta charset="UTF-8" />
<title><?php echo $title; ?></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<base href="<?php echo $base; ?>" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<?php if ($icon) { ?>
	<link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>
<?php if (isset($google_verify)) { ?>
	<?php echo $google_verify; ?>
<?php } ?>
<?php foreach ($metanames as $metaname) { ?>
	<meta name="<?php echo $metaname['name']; ?>" content="<?php echo $metaname['content']; ?>" />
<?php } ?>
<?php foreach ($metapros as $metapro) { ?>
	<meta property="<?php echo $metapro['property']; ?>" content="<?php echo $metapro['content']; ?>" />
<?php } ?>
<?php foreach ($links as $link) { ?>
	<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="static/css2.css?v211" media="screen" />
<link rel="stylesheet" type="text/css" href="static/swiper.css?v211" media="screen" />
<link href="https://fonts.googleapis.com/css?family=Roboto+Slab:100,300,400,700&subset=vietnamese" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="static/print.css" media="print" />
<?php foreach ($styles as $style) { ?>
	<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>
<body itemscope="itemscope" itemtype="http://schema.org/WebPage">
<div class="hide" id="fakeheader"></div>
<div id="header">
<div id="tophead">
<div class="container">
	<div class="row clear">
		<div class="col-12">
			<span class="inline-block left hotline">Hotline: 18001226</span>
			<a href="<?php echo $hocngay; ?>" class="inline-block right bgdv">Báo giá dịch vụ</a>
			<a class="tw right icon-social" href="<?php echo $tw; ?>" target="_blank"></a>
			<a class="fb right icon-social" href="<?php echo $fb; ?>" target="_blank"></a>
			<a class="gl right icon-social" href="<?php echo $gl; ?>" target="_blank"></a>
		</div>
	</div>
</div>
</div>
	
	<div class="container">
<div class="row clear">
	<div class="col-12 col-desktop-2 col-tablet-4">
		<span class="show-mobile hide-desktop hide-tablet right" onclick="showMenu();" id="menu-button">Menu</span>	
		<?php if ($logo) { ?>
				<a class="logo block" href="<?php echo $home; ?>"><img class="block" src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a>
		<?php } ?>
	</div>
	<div class="show-desktop show-tablet hide-mobile" id="top-menu">
		<div class="inline-block relative right" id="search">
			<div class="button-search absolute" onclick="searchDesk('inputDesk','');"></div>
			<input type="text" name="search" id="inputDesk" onkeydown="search(event,'inputDesk','');" placeholder="Nhập từ khóa" value="<?php echo $search; ?>" />
		</div>
		<?php echo $top_menu; ?>
	</div>
</div>
</div>
</div>

<?php if($route =='common/home') { ?>
	<div class="slideshow relative">
		<?php echo $slideside; ?>
	</div>
<?php } ?>

<div class="container">
<div class="row clear">
<div id="notification">
<?php if ($error) { ?>
	<div class="warning"><?php echo $error ?><img src="static/close.png" alt="" class="close" /></div>
<?php } ?>	
</div>

  	<div class="hide fixed" id="mobile-menu">
  		<div id="search-mobile" class="relative">
		    <div class="button-search" onclick="searchDesk('input-mobile');"></div>
		  	<input type="text" id="input-mobile" name="search" placeholder="<?php echo $text_search; ?>" value="<?php echo $search; ?>" />
	  	</div>
		<ul>
			<li><a href="<?php echo $home; ?>" class="block">Trang chủ</a></li>
			<?php foreach ($categories as $category) { ?>
		    	<li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
			<?php } ?>
		    <li><a href="news/all">Tin tức - Tư vấn</a></li>
		    <li><a rel="nofollow" href="<?php echo $home; ?>#gioi-thieu">Giới thiệu</a></li>		    
			<li><a rel="nofollow" href="contact.html"><?php echo $text_contact; ?></a></li>
		</ul>
  		<span class="fixed right inlineblock close-mobile" onclick="hideMenu();">Đóng</span>		
	</div>
</div>	
</div>	