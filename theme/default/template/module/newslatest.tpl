<?php if ($position == 'content_top'  or $position == 'content_bottom') { ?>
<div class="box-news">
  <h3 class="box-heading"><?php echo $heading_title; ?></h3>
  <div class="box-content">
    <ul class="box-news">
      <?php foreach ($newss as $key=>$news) { ?>
      <li>
        <?php if ($news['thumb']) { ?>
        <div class="image"><a href="<?php echo $news['href']; ?>"><img src="<?php echo $news['thumb']; ?>" alt="<?php echo $news['name']; ?>" <?php echo $news['width']; ?> <?php echo $news['height']; ?> /></a></div>
        <?php } ?>
        <div class="name"><a href="<?php echo $news['href']; ?>"><?php echo $news['name']; ?></a></div>
         <?php echo $news['short_description'];?>
	     <div class="clrfix"></div>        
      </li>
      <?php } ?>
    </ul>
  </div>
</div>

<?php } else if ($position == 'column_left' or $position == 'column_right') { ?>                            
<div class="">
<h3 class="title_right">Tin tức mới nhất</h3>
      <?php foreach ($newss as $key=>$news) { ?>
  			<div class="row clear news-i">		      	
	      		<div class="col-5 no-padding thumb-i">
	      			<a href="<?php echo $news['href']; ?>"><img src="<?php echo $news['thumb']; ?>" alt="<?php echo $news['name']; ?>" /></a>
	      		</div>
	      		<div class="col-7">
	      			<a class="medium" href="<?php echo $news['href']; ?>"><?php echo $news['name']; ?></a>
	      			<span class="small grey block"><?php echo $news['date_added']; ?></span>
					<div class="linegrey"></div> 
	      		</div>
	      	</div>
      <?php } ?>
</div>
<?php }else if ($position == 'before_footer' or $position == 'column_right') { ?>
<div class="box-news">
  <h3 class="box-heading">Tin mới cập nhật</h3>
  <div class="box-content">
    <ul class="box-news">
      <?php foreach ($newss as $key=>$news) { ?>
      <li>
        <?php if ($news['thumb']) { ?>
        <div class="image"><a href="<?php echo $news['href']; ?>"><img src="<?php echo $news['thumb']; ?>" alt="<?php echo $news['name']; ?>" <?php echo $news['width']; ?> <?php echo $news['height']; ?> /></a></div>
        <?php } ?>
        <div class="name"><a href="<?php echo $news['href']; ?>"><?php echo $news['name']; ?></a></div>
         <?php echo $news['short_description'];?>
       <div class="clrfix"></div>        
      </li>
      <?php } ?>
    </ul>
  </div>
</div>

<?php } ?>