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
<div class="col-12 col-desktop-9 col-tablet-9 left-col details">
  <h1 class="childMainHead"><?php echo $heading_title; ?><?php echo $search ? " - ".$search : "";?></h1>
  <select style="color:black" id="news_category_id" class="select left"> 
            <option value="0">Chọn danh mục tin tức</option>
            <?php foreach ($categories as $category_1) { ?>
            <?php if ($category_1['news_category_id'] == $news_category_id) { ?>
            <option value="<?php echo $category_1['news_category_id']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $category_1['news_category_id']; ?>"><?php echo $category_1['name']; ?></option>
            <?php } ?>
            <?php foreach ($category_1['children'] as $category_2) { ?>
            <?php if ($category_2['news_category_id'] == $news_category_id) { ?>
            <option value="<?php echo $category_2['news_category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $category_2['news_category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
            <?php } ?>
            <?php /*foreach ($category_2['children'] as $category_3) { ?>
            <?php if ($category_3['news_category_id'] == $news_category_id) { ?>
            <option value="<?php echo $category_3['news_category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $category_3['news_category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
            <?php } ?>
            <?php } */?>
            <?php } ?>
            <?php } ?>
          </select>
  <p>
      <?php if ($search) { ?>
      <input type="text" name="search" id="searchkeywordinput" onkeydown="search(event,'searchkeywordinput','news_category_id');" value="<?php echo $search; ?>" />
      <?php } else { ?>
      <input type="text" name="search" id="searchkeywordinput" onkeydown="search(event,'searchkeywordinput','news_category_id');" value="<?php echo $search; ?>" placeholder="nhập từ khóa cần tìm"  />
      <?php } ?>
    </p>
	
    <span onclick="searchDesk('searchkeywordinput','news_category_id');" class="button"><?php echo $button_search; ?></span>
  <?php if ($news) { ?>
		<div class="media-list">
		<?php foreach ($news as $news_item) { ?>
		<div class="media row clear">
		  
			  <div class="col-12">
			  <h3 class="h6 strong"><a href="<?php echo $news_item['href']; ?>"><?php echo $news_item['name']; ?></a></h3>
			  <span class="grey small"><?php echo $news_item['date_added']; ?> - <?php echo $text_viewed; ?> <?php echo $news_item['viewed']; ?></span>
			  <div class="description medium hide-mobile show-tablet show-desktop grey"><?php echo $news_item['short_description']; ?></div>
			  </div>
		</div>
		<?php } ?>
		</div>
		<div class="tool">
			<div class="pagination  pagination-small pagination-right">
				<?php echo $pagination; ?>
			</div>
		</div>
	<?php } ?>
	<?php if (!$news) { ?>
		<div class="content"><?php echo $text_empty; ?></div>
	<?php } ?>
  </div>
	<?php echo $column_right; ?>
</div>
<?php echo $content_bottom; ?>
</div>
</div>
<?php echo $footer; ?>