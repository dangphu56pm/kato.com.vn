<?php echo $header; ?>
<div id="topcontent_sub" class="relative">
	<div class="container">
	<div class="row clear">
		<?php echo $content_top; ?>
	</div>
	</div>
</div>
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
	<div class="col-12 col-desktop-8 col-tablet-8">
	<h3 class="title_right"><?php echo $heading_title; ?></h3>
		<?php foreach($all_topics as $topic) { ?>
		<div class="accordionItem close">
			<h3 class="accordionItemHeading h6 strong"><?php echo $topic['title']; ?></h3>
			<div class="accordionItemContent">
				<?php echo html_entity_decode($topic['description'], ENT_QUOTES, 'UTF-8'); ?>
			</div>
		</div>
	<?php } ?>
   </div>
   <div class="col-4 show-tablet hide-mobile show-desktop">
	   	   <?php echo $column_right; ?>
   	</div>
</div>
<?php echo $content_bottom; ?>
</div>
</div>
<script>
var accItem = document.getElementsByClassName('accordionItem');
var accHD = document.getElementsByClassName('accordionItemHeading');
for (i = 0; i < accHD.length; i++) {
    accHD[i].addEventListener('click', toggleItem, false);
}
function toggleItem() {
    var itemClass = this.parentNode.className;
    for (i = 0; i < accItem.length; i++) {
        accItem[i].className = 'accordionItem close';
    }
    if (itemClass == 'accordionItem close') {
        this.parentNode.className = 'accordionItem open';
    }
}
</script>
<?php echo $footer; ?>