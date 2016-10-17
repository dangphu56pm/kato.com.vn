<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/information.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="location = '<?php echo $insert; ?>'" class="button"><span><?php echo $button_insert; ?></span></a><a onclick="$('#form').attr('action', '<?php echo $save_sort; ?>'); $('#form').submit();" class="button">Lưu sắp xếp</a><a onclick="$('#form').attr('action', '<?php echo $copy; ?>'); $('#form').submit();" class="button"><span><?php echo $button_copy; ?></span></a><a onclick="$('form').submit();" class="button"><span><?php echo $button_delete; ?></span></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="list">
          <thead>
            <tr>
              <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
              <td class="center"><?php echo $column_image; ?></td>
              <td class="left"><?php if ($sort == 'nd.name') { ?>
                <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
                <?php } ?></td>
              <td class="left"><?php echo $column_short_description; ?></td>
              <td class="center"><?php echo "Danh mục tin"; ?></td>              
              <td class="center"><?php if ($sort == 'n.status') { ?>
                <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
                <?php } ?></td>
              <td class="center" width="10px">
                    <?php if ($sort == 'n.sort_order') { ?>
                    <a href="<?php echo $sort_order; ?>" class="<?php echo strtolower($order); ?>"><?php echo "Thứ tự"; ?></a>
                <?php } else { ?>
                    <a href="<?php echo $sort_order; ?>"><?php echo "Thứ tự"; ?></a>
                 <?php } ?>
                    </td>  
              <td class="center"><?php echo $column_date_added; ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <tr class="filter">
           <td></td>
		   <td></td>
             
              <td><input type="text" name="filter_name" value="<?php echo $filter_name; ?>" /></td>
              <td><input type="text" name="filter_short_description" value="<?php echo $filter_short_description; ?>" style="width: 300px;" /></td>
			   	<td align="right"><select name="filter_category">
                  <option value=""></option>
                  <?php foreach($news_category as $rs) { ?>
				  <?php if(isset($filter_category) && $filter_category == $rs['news_category_id']){?>
                  <option value="<?php echo $filter_category?>" selected="selected"><?php echo $rs['name']; ?></option>
                  <?php }else{ ?>
				  <option value="<?php echo $rs['news_category_id']; ?>"><?php echo $rs['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
				  
                </select></td>
            
              <td align="right"><select name="filter_status">
                  <option value="*"></option>
                  <?php if ($filter_status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <?php } ?>
                  <?php if (!is_null($filter_status) && !$filter_status) { ?>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
              <td></td>
              <td></td>
              <td align="right"><a onclick="filter();" class="button"><span><?php echo $button_filter; ?></span></a></td>
            </tr>
            <?php if ($news) { ?>
            <?php foreach ($news as $news_item) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($news_item['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $news_item['news_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $news_item['news_id']; ?>" />
                <?php } ?></td>
              <td class="center"><img src="<?php echo $news_item['image']; ?>" alt="<?php echo $news_item['name']; ?>" style="padding: 1px; border: 1px solid #DDDDDD;" <?php echo $news_item['width']; ?> <?php echo $news_item['height']; ?> /></td>
              <td class="left"><a href="<?php echo $news_item['name_url']; ?>"><?php echo $news_item['name']; ?></a></td>
              <td class="left"><?php echo $news_item['short_description']; ?></td>
              <td class="left"><?php echo $news_item['name_category']; ?></td>
            
              <td class="right">
				<a class="columnstatus" id="status-<?php echo $news_item['news_id']; ?>"><?php echo $news_item['status']; ?></a>
			</td>
              <?php  $sort_order = "sort_order[". $news_item['news_id'] ."]"; ?>
              <td class="left"><input type="text" class="center" size="1" name="<?php echo  $sort_order ?>"  value="<?php echo $news_item['sort_order']; ?>" /></td>
              <td class="left"><?php echo $news_item['date_added']; ?></td>
              <td class="right"><?php foreach ($news_item['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="8"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
      <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
function filter() {
	url = 'index.php?route=catalog/news&token=<?php echo $token; ?>';
	
	var filter_category = $('select[name=\'filter_category\']').attr('value');
	
	if (filter_category) {
		url += '&filter_category=' + encodeURIComponent(filter_category);
	}
	var filter_name = $('input[name=\'filter_name\']').attr('value');
	
	if (filter_name) {
		url += '&filter_name=' + encodeURIComponent(filter_name);
	}
	
	var filter_short_description = $('input[name=\'filter_short_description\']').attr('value');
	
	if (filter_short_description) {
		url += '&filter_short_description=' + encodeURIComponent(filter_short_description);
	}
	
	
	
	var filter_status = $('select[name=\'filter_status\']').attr('value');
	
	if (filter_status != '*') {
		url += '&filter_status=' + encodeURIComponent(filter_status);
	}	

	location = url;
}
//--></script> 
<script type="text/javascript"><!--
$('#form input').keydown(function(e) {
	if (e.keyCode == 13) {
		filter();
	}
});
//--></script> 
<script type="text/javascript"><!--
$('input[name=\'filter_name\']').autocomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/news/autocomplete&token=<?php echo $token; ?>',
			type: 'POST',
			dataType: 'json',
			data: 'filter_name=' +  encodeURIComponent(request.term),
			success: function(data) {		
				response($.map(data, function(item) {
					return {
						label: item.name,
						value: item.name
					}
				}));
			}
		});
		
	}, 
//	select: function(event, ui) {
//		$('#news-related' + ui.item.value).remove();
//		
//		$('#news-related').append('<div id="news-related' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" /><input type="hidden" name="news_related[]" value="' + ui.item.value + '" /></div>');
//
//		$('#news-related div:odd').attr('class', 'odd');
//		$('#news-related div:even').attr('class', 'even');
//				
//		return false;
//	}
        select: function(item) {
		$('input[name=\'filter_name\']').val(item['label']);}
});

$('#news-related div img').live('click', function() {
	$(this).parent().remove();
	
	$('#news-related div:odd').attr('class', 'odd');
	$('#news-related div:even').attr('class', 'even');	
});
//--></script> 

				<script type="text/javascript"><!--
				$('.columnstatus').click(function() {
					var object_id=$(this).attr('id');
					$.ajax({
						url: 'index.php?route=catalog/news/updatestatus&token=<?php echo $token; ?>',
						type: 'get',
						data: {object_id:object_id},
						dataType: 'html',
						success: function(html) {
							if(html!=''){				
								$('#'+object_id).html(html);
							}
						}
					});
				});
				//--></script> 
			
<?php echo $footer; ?>