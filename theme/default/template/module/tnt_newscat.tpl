<?php if ($position == 'content_top') { ?>
<div class="box col-12 text-center rowgutter">
<div class="row clear">
  <?php foreach ($newss as $news) { ?>
  		<div class="col-2 productshow text-center">
		<?php if ($news['thumb']) { ?>
			<a href="<?php echo $news['href']; ?>"><img src="<?php echo $news['thumb']; ?>" alt="<?php echo $news['name']; ?>" /></a>
		<?php } ?>
		<h3 class="name medium"><a href="<?php echo $news['href']; ?>"><?php echo $news['name']; ?></a></h3>
		</div>
<?php } ?>
</div>
</div>
<?php } else if ($position == 'content_bottom' or $position == 'column_right') { ?>   
<h3 class="mlhd none">Mạng lưới hoạt động</h3>
<?php if($catid==70){ ?>
<h3 class="title strong">Mạng lưới hoạt động</h3>
<div class="row clear">
<div class="box col-12 text-center rowgutter no-padding">
<div class="swiper-container carousel-autoplay2">
<div class="swiper-wrapper">
  <?php foreach ($newss as $news) { ?>
  		<div class="newsshow col-12 text-center">
		<?php if ($news['thumb']) { ?>
			<a href="<?php echo $news['href']; ?>"><img src="<?php echo $news['thumb']; ?>" alt="<?php echo $news['name']; ?>" /></a>
		<?php } ?>
		<span class="sevice"><a href="<?php echo $news['href']; ?>"><?php echo $news['name']; ?></a></span>
		</div>
<?php } ?>
</div>
</div>
<div class="swiper-next button-ca nnext"></div>
<div class="swiper-prev button-ca nprev"></div>
</div>
</div>
<?php }elseif($catid==69){ ?>
<div class="box col-12 text-center rowgutter no-padding">
<div class="row clear">
  <?php foreach ($newss as $key=> $news) { ?>
	<?php if($key==0){echo '<div class="col-5 productshow text-left left">';} ?>
	<?php if($key==3){echo '<div class="col-2 inline-block map-bg"></div><div class="col-5 productshow text-left right">';} ?>
		<div class="office">
		<h3 class="office_title strong"><?php echo $news['name']; ?></h3>
		<?php echo $news['description']; ?>
		</div>
		<?php if($key==2 || $key==5){echo '</div>';} ?>
<?php } ?>
</div>
</div>
<?php } ?>
<?php } else if ($position == 'before_footer') {?>
<div class="box-news-cat">
  <h3 class="box-heading"><?php echo $cat_name; ?></h3>
  <div class="box-content">
    <div class="box-product-left">
      <?php foreach ($newss as $news) { ?>
      <div>
        <?php if ($news['thumb']) { ?>
        <div class="image"><a href="<?php echo $news['href']; ?>"><img src="<?php echo $news['thumb']; ?>" alt="<?php echo $news['name']; ?>" <?php echo $news['width']; ?> <?php echo $news['height']; ?> /></a></div>
        <?php } ?>
        <div class="name"><a href="<?php echo $news['href']; ?>"><?php echo $news['name']; ?></a></div>

         <?php echo $news['short_description'];?>
         <div class="clrfix"></div>
      </div>
      <?php } ?>
    </div>
    <a class="orther" href="<?php echo $cathref; ?>">Xem toàn bộ</a>
  </div>
</div>
<?php } ?>