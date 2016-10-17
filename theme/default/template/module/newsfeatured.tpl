<?php if ($position == 'content_top'  or $position == 'content_bottom') { ?>
<div class="box">
<div class="row clear no-margin rowgutter">
	 <h3><a href="news/all" class="strong">Nổi bật</a></h3>
	  <?php foreach ($newss as $key=>$news) { ?>
		  <?php if($key==0){ ?>
			<div class="col-12 col-desktop-6 col-tablet-6">
				<?php if ($news['thumb']) { ?>
				<a href="<?php echo $news['href']; ?>"><img src="<?php echo $news['thumb']; ?>" alt="<?php echo $news['name']; ?>" /></a>
				<?php } ?>
				<h3 class="name1 medium  strong"><a href="<?php echo $news['href']; ?>"><?php echo $news['name']; ?></a></h3>
				<?php echo $news['short_description'];?>
			</div>
		  <?php }else {?>
		  <div class="col-12 col-desktop-6 col-tablet-6 secondpost ">
				<h3 class="name medium strong"><a href="<?php echo $news['href']; ?>"><?php echo $news['name']; ?></a></h3>
				<h3 class="name medium  strong"><?php echo $news['date_added']; ?></a></h3>
			</div>
	      <?php } ?>
	  <?php } ?>
</div>
</div>

<?php } else if ($position == 'column_left' or $position == 'column_right') { ?>                            
<div class="column_right">
<h3 class="title_right">Tin tức nổi bật</h3>
<ul>
  <?php foreach ($newss as $key=>$news) { ?>
	<li><a class="medium" href="<?php echo $news['href']; ?>"><?php echo $news['name']; ?></a></li>
  <?php } ?>
</ul>
</div>
<?php } ?>