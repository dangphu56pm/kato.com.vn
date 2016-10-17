<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>

  <div class="box">
  <div class="heading">
  <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons">
        <a onclick="buttonSave();" class="button"><?php echo $button_save; ?></a>
        <a onclick="buttonApply();" class="button"><?php echo $button_apply; ?></a>
        <a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a>
      </div>
    </div>
  <div class="content">
       <?php if (!empty($error_warning)) { ?>
            <div class="warning"><?php foreach ($error_warning as $warning) { echo $warning.'<br>';} ?></div>
          <?php } ?>
          <?php if ($success) { ?>
            <div class="success notice"><?php echo $success; ?></div>
          <?php } ?>
 <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
    <div class="tv-content">

          <div class="tv-item">

              <h3><?php echo $entry_title; ?> </h3>
            <div class="option-item">
                  <span class="label"><b><?php echo $text_cus_title ?>:</b></span>
                    <?php foreach ($languages as $language) { ?>
                        <input type="text" name="refine_search_title<?php echo $language['language_id']; ?>" id="refine_search_title<?php echo $language['language_id']; ?>" size="30" value="<?php echo ${'refine_search_title' . $language['language_id']}; ?>" />
                        <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" style="vertical-align: top;" /><br />
                    <?php } ?>
                </div><!--End Title-->
                
            <div class="option-item">
                  <span class="label"><b><?php echo $text_cat; ?>:</b></span>
                    <input type="checkbox" id="cat_status" name="cat_status" <?php if($cat_status) echo 'checked';?> />
                    <input type="checkbox" id="cat_expand" name="cat_expand" <?php if($cat_expand) echo 'checked';?> data-on="Expand" data-off="Collapse" />
                    <input type="checkbox" id="only_sub_cate" name="only_sub_cate" <?php if($only_sub_cate) echo 'checked';?> data-on="Only sub categories" data-off="Show all categories" />
                    <input type="checkbox" id="hide_cate_empty" name="hide_cate_empty" <?php if($hide_cate_empty) echo 'checked';?> data-on="Hide categories empty" data-off="Show categories empty" />
                </div><!--End Category-->
                
            <div class="option-item">
                  <span class="label"><b><?php echo $text_brand; ?>:</b></span>
                    <input type="checkbox" id="brand_status" name="brand_status" <?php if($brand_status) echo 'checked';?> />
                    <input type="checkbox" id="brand_expand" name="brand_expand" <?php if($brand_expand) echo 'checked';?> data-on="Expand" data-off="Collapse" />
                </div><!--End Brand-->
                
            <div class="option-item">
                     <div class="tv-item">
                        <h3><?php echo $text_select_attr; ?> </h3>
                        <div class="option-item">
                            <span class="label"><?php echo $entry_status; ?></span>
                            <input type="checkbox" id="attr_status" name="attr_status" <?php if($attr_status) echo 'checked';?> />
                            <input type="checkbox" id="attr_expand" name="attr_expand" <?php if($attr_expand) echo 'checked';?> data-on="Expand" data-off="Collapse" />
                            <input type="checkbox" id="hide_attr_empty" name="hide_attr_empty" <?php if($hide_attr_empty) echo 'checked';?> data-on="Hide atrributes empty" data-off="Show atrributes empty" />
                        </div>
                        <div class="option-item">
                            <span class="label">
                                <?php echo $text_select_attr ?>
                                <span class="help"><?php echo $text_des_attr; ?></span>
                            </span>
                           <select multiple="multiple" id="refine_search_attr[]" name="refine_search_attr[]" style="min-width:150px">
                                <?php foreach ($listAttrGroup as $attr_group) { ?>
                                <option value="<?php echo $attr_group['attribute_group_id'] ?>" <?php if ( in_array( $attr_group['attribute_group_id'] , $attr_select ) ) { echo ' selected="selected"' ; } ?>><?php echo $attr_group['name']; ?></option>
                                <?php } ?>
                            </select>
                           
                        </div>
                    </div>
                </div><!--End Attribute-->
                
                <div class="option-item">
                    <div class="tv-item">
                        <h3><?php echo $text_op; ?> </h3>
                        <div class="option-item">
                            <span class="label"><?php echo $entry_status; ?></span>
                            <input type="checkbox" id="op_status" name="op_status" <?php if($op_status) echo 'checked';?> />
                            <input type="checkbox" id="op_expand" name="op_expand" <?php if($op_expand) echo 'checked';?> data-on="Expand" data-off="Collapse" />
                            <input type="checkbox" id="hide_op_empty" name="hide_op_empty" <?php if($hide_op_empty) echo 'checked';?> data-on="Hide options empty" data-off="Show options empty" />
                        </div>
                        <div class="option-item">
                            <span class="label">
                                <?php echo $entry_display; ?>
                                <span class="help"><?php echo $text_help_op; ?></span>
                            </span>
                            <input type="checkbox" id="op_display" name="op_display" <?php if($op_display) echo 'checked';?> data-on="Grid" data-off="List" />
                        </div>
                        <div class="option-item">
                            <span class="label">
                                <?php echo $text_select_option ?>
                                <span class="help"><?php echo $text_des_option; ?></span>
                            </span>
                            <select multiple="multiple" id="refine_search_option[]" name="refine_search_option[]" style="min-width:150px">
                                <?php foreach ($listOption as $option) { ?>
                                <option value="<?php echo $option['id'] ?>" <?php if ( in_array( $option['id'] , $option_select ) ) { echo ' selected="selected"' ; } ?>><?php echo $option['name']; ?></option>
                                <?php } ?>
                            </select>
                            
                        </div>
                    </div>
                </div><!--End Option-->
                
                <div class="option-item">
                    <div class="tv-item">
                        <h3><?php echo $text_price; ?> </h3>
                        <div class="option-item">
                            <span class="label"><?php echo $entry_status; ?></span>
                            <input type="checkbox" id="price_status" name="price_status" <?php if($price_status) echo 'checked';?> />
                        </div>
                        
                        <div class="option-item">
                            <span class="label"><?php echo $entry_step ?></span>
                            <input type="text" name="refine_search_step" value="<?php echo $step ?>" />
                        </div>

                        <div class="option-item">
                            <span class="label"><?php echo $text_select_option ?><span class="help"><?php echo $text_des_option; ?></span></span>
                            <?php echo $text_from ; ?> <input type="text" name="refine_search_min" value="<?php echo $min ?>" />
                            <?php echo $text_to; ?> <input name="refine_search_max" type="text" value="<?php echo $max ?>" />
                        </div>
                    </div>
                </div><!--End Price-->
                
                <div class="option-item">
                     <div class="tv-item">
                        <h3><?php echo $button_add_module; ?> </h3>
                        <div class="option-item">
                            <table id="module" class="list">
                              <thead>
                                <tr>
                                  <td class="left"><?php echo $entry_layout; ?></td>
                                  <td class="left"><?php echo $entry_position; ?></td>
                                  <td class="left"><?php echo $entry_options; ?></td>
                                  <td class="left"><?php echo $entry_status; ?></td>
                                  <td class="right"><?php echo $entry_sort_order; ?></td>
                                  <td></td>
                                </tr>
                              </thead>
                              <?php $module_row = 0; ?>
                              <?php foreach ($modules as $module) { ?>
                              <tbody id="module-row<?php echo $module_row; ?>">
                                <tr>
                                  <td class="left"><select name="refine_search_module[<?php echo $module_row; ?>][layout_id]">
                                      <?php foreach ($layouts as $layout) { ?>
                                      <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                                      <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                                      <?php } else { ?>
                                      <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                                      <?php } ?>
                                      <?php } ?>
                                    </select></td>
                                    <td class="left"><select name="refine_search_module[<?php echo $module_row; ?>][position]">   
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
                                    <td class="left"><select name="refine_search_module[<?php echo $module_row; ?>][options]">
                                    <?php if ($module['options']) { ?>
                                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                    <option value="0"><?php echo $text_disabled; ?></option>
                                    <?php } else { ?>
                                    <option value="1"><?php echo $text_enabled; ?></option>
                                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                    <?php } ?>
                                  </select></td>
                                    <td class="left"><select name="refine_search_module[<?php echo $module_row; ?>][status]">
                                    <?php if ($module['status']) { ?>
                                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                    <option value="0"><?php echo $text_disabled; ?></option>
                                    <?php } else { ?>
                                    <option value="1"><?php echo $text_enabled; ?></option>
                                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                    <?php } ?>
                                  </select></td>
                                  <td class="right"><input type="text" name="refine_search_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
                                  <td class="left"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="button"><span><?php echo $button_remove; ?></span></a></td>
                                </tr>
                              </tbody>
                              <?php $module_row++; ?>
                              <?php } ?>
                              <tfoot>
                                <tr>
                                  <td colspan="5"><a onclick="buttonApply();" class="button">Save changes</a></td>
                                  <td class="left"><a onclick="addModule();" class="button"><?php echo $button_add_module; ?></a></td>
                                </tr>
                              </tfoot>
                            </table>
                        </div>
                    </div>
                </div><!--End Add Module-->
            </div>
        </div>
        <input type="hidden" id="action" name="action" value="" />
      </form>
  </div>
  </div>
</div>
<script type="text/javascript">
$(document).ready(function(){    
    $('input[type=checkbox]').tvCheckbox({labels:['Enable','Disable']});
});
</script>
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {  
  html  = '<tbody id="module-row' + module_row + '">';
  html += '  <tr>';
  html += '    <td class="left"><select name="refine_search_module[' + module_row + '][layout_id]">';
  <?php foreach ($layouts as $layout) { ?>
  html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
  <?php } ?>
  html += '    </select></td>';
  html += '    <td class="left"><select name="refine_search_module[' + module_row + '][position]">';
  html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
  html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
  html += '    </select></td>';
  html += '    <td class="left"><select name="refine_search_module[' + module_row + '][options]">';
    html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    html += '    </select></td>';
  html += '    <td class="left"><select name="refine_search_module[' + module_row + '][status]">';
    html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    html += '    </select></td>';
  html += '    <td class="right"><input type="text" name="refine_search_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
  html += '    <td class="left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
  html += '  </tr>';
  html += '</tbody>';
  
  $('#module tfoot').before(html);
  
  module_row++;
}

//--></script>
<script type="text/javascript">
function buttonSave() {
  $('#action').val('save');
  $('#form').submit();
}
function buttonApply() {
  $('#action').val('apply');
  $('#form').submit();
}
</script>
<?php echo $footer; ?>