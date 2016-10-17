<?php echo $header; ?>
<div id="subheader">
<div class="container rowgutter relative">
	<div class="small breadcrumbs" xmlns:v="http://rdf.data-vocabulary.org/#">
            <span itemprop="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>" rel="v:url" property="v:title"><?php echo $breadcrumb['text']; ?></a>
                <?php } ?>
            </span>
     </div>  
     <h1 class="h3"><?php echo $heading_title; ?></h1>
     <?php echo $avd_top; ?>
</div>
</div>

<div id="body">
<div class="container zonegutter">
	<div class="row clear">
	<div class="col-12 col-desktop-9 col-tablet-9">
		  <?php if ($thumb || $description) { ?>
		  <div class="category-info">
		    <?php if ($description) { ?>
			    <?php echo $description; ?>
		    <?php } ?>
		  </div>
		  <?php } ?>
		
	  <?php if ($products) { ?>
	  <div class="row clear">
	    <?php foreach ($products as $product) { ?>
	    <div class="productshow col-6 col-desktop-4 col-tablet-4 text-center products">
	      <?php if ($product['thumb']) { ?>
	      	<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>
	      	<?php } ?>
	      <h3 class="name medium"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>
	    </div>
	    <?php } ?>
	  </div>
	  <div class="pagination"><?php echo $pagination; ?></div>
	  <?php } ?>
	  <?php if (!$categories && !$products) { ?>
	
	  <?php } ?>
	  
	</div>
	<div class="col-3 show-tablet hide-mobile show-desktop">
	<?php echo $column_right; ?>
	</div>
</div>
<?php echo $content_bottom; ?>
</div>
</div>
<?php echo $footer; ?>