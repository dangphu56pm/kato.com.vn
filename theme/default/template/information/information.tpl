<?php echo $header; ?>
<div id="subheader">
<div class="container semirowgutter relative">
	<div class="small breadcrumbs" xmlns:v="http://rdf.data-vocabulary.org/#">
            <span itemprop="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>" rel="v:url" property="v:title"><?php echo $breadcrumb['text']; ?></a>
                <?php } ?>
            </span>
     </div>  
     <h1 class="h3"><?php echo $heading_title; ?></h1>
</div>
</div>

<div id="body">
<div class="container zonegutter">
<div class="row clear">
  	<div class="col-12 col-desktop-9 col-tablet-9 left-col">
		<div class="information-content">
			  <?php echo $description; ?>
		</div>
	</div>
	<div class="col-3 show-tablet hide-mobile show-desktop">
		<?php echo $column_right; ?>
	</div>
</div>
</div>
</div>
<?php echo $footer; ?>