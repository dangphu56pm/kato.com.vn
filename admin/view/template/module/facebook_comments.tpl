<?php echo $header; ?>
<div id="content">
<div class="breadcrumb">
  <?php foreach ($breadcrumbs as $breadcrumb) { ?>
  <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
  <?php } ?>
</div>
<?php if ($update) { ?>
<div class="warning"><?php echo $update; ?></div>
<?php } ?>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<div class="box">
  <div class="heading">
    <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
    <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
  </div>
  <div class="content">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
	<table class="form">
		<tr>
			<td class="left"><span class="required">* </span><?php echo $entry_app_id; ?><span class="help"><?php echo $help_app_id; ?></span></td>
			<td class="left"><input type="text" name="facebook_comments_app_id" value="<?php echo $facebook_comments_app_id; ?>" />
			<?php if (isset($error_app_id)) { ?>
			  <span class="error"><?php echo $error_app_id; ?></span>
			<?php } ?>
			</td>
		</tr>
		<tr>
			<td class="left"><?php echo $entry_color_scheme; ?><span class="help"><?php echo $help_color_scheme; ?></span></td>
			<td class="left"><select name="facebook_comments_color_scheme">
			<?php if ($facebook_comments_color_scheme == 'dark') { ?>
			<option value="dark" selected="selected"><?php echo $text_dark; ?></option>
			<option value="light"><?php echo $text_light; ?></option>
			<?php } else { ?>
			<option value="dark"><?php echo $text_dark; ?></option>
			<option value="light" selected="selected"><?php echo $text_light; ?></option>			
			<?php } ?>
			</select></td>
		</tr>
		<tr>
			<td class="left"><span class="required">* </span><?php echo $entry_num_posts; ?><span class="help"><?php echo $help_num_posts; ?></span></td>
			<td class="left"><input type="text" name="facebook_comments_num_posts" value="<?php echo $facebook_comments_num_posts; ?>" />
			<?php if (isset($error_num_posts)) { ?>
			  <span class="error"><?php echo $error_num_posts; ?></span>
			<?php } ?>
			</td>
		</tr>
		<tr>
			<td class="left"><?php echo $entry_order_by; ?><span class="help"><?php echo $help_order_by; ?></span></td>
			<td class="left"><select name="facebook_comments_order_by">
			<?php if ($facebook_comments_order_by == 'reverse_time') { ?>
			<option value="reverse_time" selected="selected"><?php echo $text_reverse_time; ?></option>
			<option value="time"><?php echo $text_time; ?></option>
			<option value="social"><?php echo $text_social; ?></option>
			<?php } elseif ($facebook_comments_order_by == 'time') { ?>
			<option value="reverse_time"><?php echo $text_reverse_time; ?></option>
			<option value="time" selected="selected"><?php echo $text_time; ?></option>
			<option value="social"><?php echo $text_social; ?></option>			
			<?php } else { ?>
			<option value="reverse_time"><?php echo $text_reverse_time; ?></option>
			<option value="time"><?php echo $text_time; ?></option>
			<option value="social" selected="selected"><?php echo $text_social; ?></option>						
			<?php } ?>
			</select></td>
		</tr>		
	  </table>
      <table id="module" class="list">
        <thead>
          <tr>
            <td class="left"><?php echo $entry_layout; ?></td>
            <td class="left"><?php echo $entry_position; ?></td>
            <td class="left"><?php echo $entry_status; ?></td>
            <td class="right"><?php echo $entry_sort_order; ?></td>
            <td></td>
          </tr>
        </thead>
        <?php $module_row = 0; ?>
        <?php foreach ($modules as $module) { ?>
        <tbody id="module-row<?php echo $module_row; ?>">
            <td class="left"><select name="facebook_comments_module[<?php echo $module_row; ?>][layout_id]">
                <?php foreach ($layouts as $layout) { ?>
                <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
            <td class="left"><select name="facebook_comments_module[<?php echo $module_row; ?>][position]">
                <?php if ($module['position'] == 'content_top') { ?>
                <option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
                <?php } else { ?>
                <option value="content_top"><?php echo $text_content_top; ?></option>
                <?php } ?>
                <?php if ($module['position'] == 'content_bottom') { ?>
                <option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
                <?php } else { ?>
                <option value="content_bottom"><?php echo $text_content_bottom; ?></option>
                <?php } ?>
                <?php if ($module['position'] == 'column_left') { ?>
                <option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
                <?php } else { ?>
                <option value="column_left"><?php echo $text_column_left; ?></option>
                <?php } ?>
                <?php if ($module['position'] == 'column_right') { ?>
                <option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
                <?php } else { ?>
                <option value="column_right"><?php echo $text_column_right; ?></option>
                <?php } ?>
              </select></td>
            <td class="left"><select name="facebook_comments_module[<?php echo $module_row; ?>][status]">
                <?php if ($module['status']) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
            <td class="right"><input type="text" name="facebook_comments_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
            <td class="left"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
          </tr>
        </tbody>
        <?php $module_row++; ?>
        <?php } ?>
        <tfoot>
          <tr>
            <td colspan="4"></td>
            <td class="left"><a onclick="addModule();" class="button"><?php echo $button_add_module; ?></a></td>
          </tr>
        </tfoot>
      </table>
    </form>
  </div>
</div>
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {	
	html  = '<tbody id="module-row' + module_row + '">';
	html += '  <tr>';
	html += '    <td class="left"><select name="facebook_comments_module[' + module_row + '][layout_id]">';
	<?php foreach ($layouts as $layout) { ?>
	html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
	<?php } ?>
	html += '    </select></td>';
	html += '    <td class="left"><select name="facebook_comments_module[' + module_row + '][position]">';
	html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
	html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
	html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
	html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
	html += '    </select></td>';
	html += '    <td class="left"><select name="facebook_comments_module[' + module_row + '][status]">';
    html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    html += '    </select></td>';
	html += '    <td class="right"><input type="text" name="facebook_comments_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
	html += '    <td class="left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#module tfoot').before(html);
	
	module_row++;
}
//--></script>
<?php echo $footer; ?>