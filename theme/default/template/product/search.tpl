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
        <div class="content">
            <p>
                <?php if ($search) { ?>
                    <input type="text" name="search" id="searchkeywordinput" onkeydown="search(event, 'searchkeywordinput');" value="<?php echo $search; ?>" />
                <?php } else { ?>
                    <input type="text" name="search" id="searchkeywordinput" onkeydown="search(event, 'searchkeywordinput');" value="<?php echo $search; ?>" placeholder="nhập từ khóa cần tìm"  />
                <?php } ?>
            </p>
            <span onclick="searchDesk('searchkeywordinput');" class="button"><?php echo $button_search; ?></span>    
        </div>
        <h2><?php echo $text_search; ?></h2>
        <?php if ($products) { ?>
            <div class="row clear">
                <?php foreach ($products as $product) { ?>
                    <div class="productshow col-6 col-desktop-4 col-tablet-4 text-center">
                        <?php if ($product['thumb']) { ?>
                            <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>
                        <?php } ?>
                        <h3 class="name medium"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>
                    </div>
                <?php } ?>
            </div>
            <div class="pagination"><?php echo $pagination; ?></div>
        <?php } else { ?>
            <div class="content">Không tìm thấy kết quả phù hợp</div>
        <?php } ?>  

        <h2><?php echo "Tin tức thỏa mãn điều kiện tìm kiếm"; ?></h2>
        <?php if ($news) { ?>
            <div class="media-list">
                <?php foreach ($news as $news_item) { ?>
                    <div class="media row clear">

                        <div class="col-12">
                            <h3 class="h6 strong"><a href="<?php echo $news_item['href']; ?>"><?php echo $news_item['name']; ?></a></h3>
                            <span class="grey small"><?php echo $news_item['date_added']; ?> - Lượt xem <?php echo $news_item['viewed']; ?></span>
                            <div class="description medium hide-mobile show-tablet show-desktop grey"><?php echo $news_item['short_description']; ?></div>
                        </div>
                    </div>
                <?php } ?>
            </div>
            <div class="tool">
                <div class="pagination  pagination-small pagination-right">
                    <?php echo $pagination_news; ?>
                </div>
            </div>
        <?php } ?>
        <?php if (!$news) { ?>
            <div class="content"><?php echo $text_empty; ?></div>
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