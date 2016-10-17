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
    <div class="box">
        <div class="heading">
            <h1><img src="view/image/product.png" alt="" /> <?php echo $heading_title; ?></h1>
            <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
        </div>
        <div class="content">
            <div id="tabs" class="htabs"><a href="#tab-general"><?php echo $tab_general; ?></a><a href="#tab-data"><?php echo $tab_data; ?></a><a href="#tab-image"><?php echo $tab_image; ?></a></div>
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
                <div id="tab-general">
                    <div id="languages" class="htabs">
                        <?php foreach ($languages as $language) { ?>
                            <a href="#language<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                        <?php } ?>
                    </div>
                    <?php foreach ($languages as $language) { ?>
                        <div id="language<?php echo $language['language_id']; ?>">
                            <table class="form">
                                <tr>
                                    <td><span class="required">*</span> <?php echo $entry_name; ?></td>
                                    <td><input type="text" name="product_description[<?php echo $language['language_id']; ?>][name]" size="100" value="<?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['name'] : ''; ?>" />
                                        <?php if (isset($error_name[$language['language_id']])) { ?>
                                            <span class="error"><?php echo $error_name[$language['language_id']]; ?></span>
                                        <?php } ?></td>
                                </tr>
                                <tr>
                                    <td><span class="required">*</span> <?php echo "SEO Title:"; ?></td>
                                    <td><input type="text" name="product_description[<?php echo $language['language_id']; ?>][meta_title]" value="<?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['meta_title'] : ''; ?>" size="100" onKeyDown="textCounter(this, 70);"
                                               onKeyUp="textCounter(this, 'titleseo', 70)"/> <span class="small">Còn lại <input style="font-weight:bold;border:none" disabled size="2" id="titleseo" value="70" /> ký tự</span>
                                        <br />

                                    </td>
                                </tr>
                                <tr>
                                    <td><?php echo "Mô tả ngắn về sản phẩm"; ?></td>
                                    <td><textarea name="product_description[<?php echo $language['language_id']; ?>][short_description]" cols="120" rows="5"><?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['short_description'] : ''; ?></textarea></td>
                                </tr>
                                <tr>
                                    <td><?php echo $entry_description; ?></td>
                                    <td><textarea name="product_description[<?php echo $language['language_id']; ?>][description]" id="description<?php echo $language['language_id']; ?>"><?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['description'] : ''; ?></textarea></td>
                                </tr>
                                <tr>
                                    <td><span class="required">*</span> <?php echo "Meta Description:"; ?></td>
                                    <td >
                                        <textarea onKeyDown="textCounter(this, 160);"
                                                  onKeyUp="textCounter(this, 'descseo', 160)" size="100" name="product_description[<?php echo $language['language_id']; ?>][meta_description]" cols="45" rows="5"><?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['meta_description'] : ''; ?></textarea>
                                        <br /><span class="small">Còn lại <input style="font-weight:bold;border:none" disabled size="3" id="descseo" value="160" /> ký tự</span>
                                    </td>
                                </tr>              
                                <tr style="display:none">
                                    <td><?php echo $entry_tag; ?></td>
                                    <td><input type="text" name="product_description[<?php echo $language['language_id']; ?>][tag]" value="<?php echo isset($product_description[$language['language_id']]) ? $product_description[$language['language_id']]['tag'] : ''; ?>" size="80" /></td>
                                </tr>
                            </table>
                        </div>
                    <?php } ?>
                </div>
                <div id="tab-data">
                    <table class="form">
                        <tr>
                            <td>Danh mục</td>
                            <td><input type="text" name="category" value="" /></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td><div id="product-category" class="scrollbox">
                                    <?php $class = 'odd'; ?>
                                    <?php foreach ($product_categories as $product_category) { ?>
                                        <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                        <div id="product-category<?php echo $product_category['category_id']; ?>" class="<?php echo $class; ?>"><?php echo $product_category['name']; ?><img src="view/image/delete.png" alt="" />
                                            <input type="hidden" name="product_category[]" value="<?php echo $product_category['category_id']; ?>" />
                                        </div>
                                    <?php } ?>
                                </div></td>
                        </tr>
                        <tr>
                            <td>Bài viết liên quan từ blog <span class="help">Autocomplete</span></td>
                            <td><input type="text" name="news" value="" /></td>
                        </tr>
                        <?php if (!isset($product_newss)) { ?>
                            <?php $product_newss = array(); ?>
                        <?php } ?>
                        <tr>
                            <td>&nbsp;</td>
                            <td><div id="product-news" class="scrollbox">
                                    <?php $class = 'odd'; ?>
                                    <?php foreach ($product_newss as $product_news) { ?>
                                        <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                        <div id="product-news<?php echo $product_news['news_id']; ?>" class="<?php echo $class; ?>"><?php echo $product_news['name']; ?><img src="view/image/delete.png" alt="" />
                                            <input type="hidden" name="product_news[]" value="<?php echo $product_news['news_id']; ?>" />
                                        </div>
                                    <?php } ?>
                                </div></td>
                        </tr>

                        <tr>
                            <td><span class="required">*</span>Mã sản phẩm</td>
                            <td><input type="text" name="model" value="<?php echo $model; ?>" />
                                <?php if ($error_model) { ?>
                                    <span class="error"><?php echo $error_model; ?></span>
                                <?php } ?></td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_price; ?></td>
                            <td><input type="text" name="price" value="<?php echo $price; ?>" /></td>
                        </tr>
                        <tr>
                            <td>Ảnh đại diện</td>
                            <td><div class="image"><img src="<?php echo $thumb; ?>" alt="" id="thumb" /><br />
                                    <input type="hidden" name="image" value="<?php echo $image; ?>" id="image" />
                                    <a onclick="image_upload('image', 'thumb');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb').attr('src', '<?php echo $no_image; ?>');
                          $('#image').attr('value', '');"><?php echo $text_clear; ?></a></div></td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_date_available; ?></td>
                            <td><input type="text" name="date_available" value="<?php echo $date_available; ?>" size="12" class="date" /></td>
                        </tr>
                        <tr>
                            <td>SEO URL</td>
                            <td>
                                <input size="60" type="text" name="keyword" value="<?php echo $keyword; ?>" id="seo_keyword" />
                                <div id="seo_keyword_msg" style="margin-top: 12px;"></div>                                
                                <?php if ($error_seo) { ?>
                                	<span class="error"><?php echo $error_seo; ?></span>
                                <?php } ?>
                            </td>
                        </tr>
                        </tr>
                        <tr>
                            <td><?php echo $entry_status; ?></td>
                            <td><select name="status">
                                    <?php if ($status) { ?>
                                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                        <option value="0"><?php echo $text_disabled; ?></option>
                                    <?php } else { ?>
                                        <option value="1"><?php echo $text_enabled; ?></option>
                                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                    <?php } ?>
                                </select></td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_sort_order; ?></td>
                            <td><input type="text" name="sort_order" value="<?php echo $sort_order; ?>" size="2" /></td>
                        </tr>			  
                    </table>
                </div>
                <div id="tab-image">
                    <table id="images" class="list">
                        <thead>
                            <tr>
                                <td class="left"><?php echo $entry_image; ?></td>
                                <td class="right"><?php echo $entry_sort_order; ?></td>
                                <td></td>
                            </tr>
                        </thead>
                        <?php $image_row = 0; ?>
                        <?php foreach ($product_images as $product_image) { ?>
                            <tbody id="image-row<?php echo $image_row; ?>">
                                <tr>
                                    <td class="left"><div class="image"><img src="<?php echo $product_image['thumb']; ?>" alt="" id="thumb<?php echo $image_row; ?>" />
                                            <input type="hidden" name="product_image[<?php echo $image_row; ?>][image]" value="<?php echo $product_image['image']; ?>" id="image<?php echo $image_row; ?>" />
                                            <br />
                                            <a onclick="image_upload('image<?php echo $image_row; ?>', 'thumb<?php echo $image_row; ?>');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb<?php echo $image_row; ?>').attr('src', '<?php echo $no_image; ?>'); $('#image<?php echo $image_row; ?>').attr('value', '');"><?php echo $text_clear; ?></a></div></td>
                                    <td class="right"><input type="text" name="product_image[<?php echo $image_row; ?>][sort_order]" value="<?php echo $product_image['sort_order']; ?>" size="2" /></td>
                                    <td class="left"><a onclick="$('#image-row<?php echo $image_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
                                </tr>
                            </tbody>
                            <?php $image_row++; ?>
                        <?php } ?>
                        <tfoot>
                            <tr>
                                <td colspan="2"></td>
                                <td class="left"><a onclick="addImage();" class="button"><?php echo $button_add_image; ?></a></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>

            </form>
        </div>
    </div>
</div>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<script type="text/javascript"><!--
<?php foreach ($languages as $language) { ?>
                        CKEDITOR.replace('description<?php echo $language['language_id']; ?>', {
                            filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                            filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                            filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                            filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                            filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
                            filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
                        });
<?php } ?>
//--></script> 
<script type="text/javascript"><!--
                    $.widget('custom.catcomplete', $.ui.autocomplete, {
        _renderMenu: function (ul, items) {
            var self = this, currentCategory = '';

            $.each(items, function (index, item) {
                if (item.category != currentCategory) {
                    ul.append('<li class="ui-autocomplete-category">' + item.category + '</li>');

                    currentCategory = item.category;
                }

                self._renderItem(ul, item);
            });
        }
    });

// Category
    $('input[name=\'category\']').autocomplete({
        delay: 500,
        source: function (request, response) {
            $.ajax({
                url: 'index.php?route=catalog/category/autocomplete&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request.term),
                dataType: 'json',
                success: function (json) {
                    response($.map(json, function (item) {
                        return {
                            label: item.name,
                            value: item.category_id
                        }
                    }));
                }
            });
        },
        select: function (event, ui) {
            $('#product-category' + ui.item.value).remove();

            $('#product-category').append('<div id="product-category' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" alt="" /><input type="hidden" name="product_category[]" value="' + ui.item.value + '" /></div>');

            $('#product-category div:odd').attr('class', 'odd');
            $('#product-category div:even').attr('class', 'even');

            return false;
        },
        focus: function (event, ui) {
            return false;
        }
    });

    $('#product-category div img').live('click', function () {
        $(this).parent().remove();

        $('#product-category div:odd').attr('class', 'odd');
        $('#product-category div:even').attr('class', 'even');
    });

// Related
    $('input[name=\'related\']').autocomplete({
        delay: 500,
        source: function (request, response) {
            $.ajax({
                url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request.term),
                dataType: 'json',
                success: function (json) {
                    response($.map(json, function (item) {
                        return {
                            label: item.name,
                            value: item.product_id
                        }
                    }));
                }
            });
        },
        select: function (event, ui) {
            $('#product-related' + ui.item.value).remove();

            $('#product-related').append('<div id="product-related' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" alt="" /><input type="hidden" name="product_related[]" value="' + ui.item.value + '" /></div>');

            $('#product-related div:odd').attr('class', 'odd');
            $('#product-related div:even').attr('class', 'even');

            return false;
        },
        focus: function (event, ui) {
            return false;
        }
    });

    $('#product-related div img').live('click', function () {
        $(this).parent().remove();

        $('#product-related div:odd').attr('class', 'odd');
        $('#product-related div:even').attr('class', 'even');
    });
//--></script> 
<script type="text/javascript"><!--
    $('#tabs a').tabs();
    $('#languages a').tabs();
    $('#vtab-option a').tabs();
//--></script> 



<script type="text/javascript"><!--
    function image_upload(field, thumb) {
        $('#dialog').remove();

        $('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');

        $('#dialog').dialog({
            title: '<?php echo $text_image_manager; ?>',
            close: function (event, ui) {
                if ($('#' + field).attr('value')) {
                    $.ajax({
                        url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).attr('value')),
                        dataType: 'text',
                        success: function (text) {
                            $('#' + thumb).replaceWith('<img src="' + text + '" alt="" id="' + thumb + '" />');
                        }
                    });
                }
            },
            bgiframe: false,
            width: 960,
            height: 550,
            resizable: false,
            modal: false,
            dialogClass: 'dlg'
        });
    };
//--></script> 
<script type="text/javascript"><!--
    var image_row = <?php echo $image_row; ?>;

    function addImage() {
        html = '<tbody id="image-row' + image_row + '">';
        html += '  <tr>';
        html += '    <td class="left"><div class="image"><img src="<?php echo $no_image; ?>" alt="" id="thumb' + image_row + '" /><input type="hidden" name="product_image[' + image_row + '][image]" value="" id="image' + image_row + '" /><br /><a onclick="image_upload(\'image' + image_row + '\', \'thumb' + image_row + '\');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$(\'#thumb' + image_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#image' + image_row + '\').attr(\'value\', \'\');"><?php echo $text_clear; ?></a></div></td>';
        html += '    <td class="right"><input type="text" name="product_image[' + image_row + '][sort_order]" value="" size="2" /></td>';
        html += '    <td class="left"><a onclick="$(\'#image-row' + image_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
        html += '  </tr>';
        html += '</tbody>';

        $('#images tfoot').before(html);

        image_row++;
    }
//--></script> 
<script type="text/javascript" src="view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript"><!--
$('.date').datepicker({dateFormat: 'yy-mm-dd'});
    $('.datetime').datetimepicker({
        dateFormat: 'yy-mm-dd',
        timeFormat: 'h:m'
    });
    $('.time').timepicker({timeFormat: 'h:m'});
//--></script> 

<script type="text/javascript"><!--
// News
    $('input[name=\'news\']').autocomplete({
        delay: 500,
        source: function (request, response) {
            $.ajax({
                url: 'index.php?route=catalog/news/autocomplete&token=<?php echo $token; ?>',
                type: 'post',
                dataType: 'json',
                data: 'filter_name=' + encodeURIComponent($('input[name=\'news\']').val()),
                success: function (json) {
                    response($.map(json, function (item) {
                        return {
                            label: item.name,
                            value: item.news_id
                        }
                    }));
                }
            });
        },
        select: function (event, ui) {
            $('#product-news' + ui.item.value).remove();

            $('#product-news').append('<div id="product-news' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" alt="" /><input type="hidden" name="product_news[]" value="' + ui.item.value + '" /></div>');

            $('#product-news div:odd').attr('class', 'odd');
            $('#product-news div:even').attr('class', 'even');

            return false;
        },
        focus: function (event, ui) {
            return false;
        }
    });

    $('#product-news div img').live('click', function () {
        $(this).parent().remove();

        $('#product-news div:odd').attr('class', 'odd');
        $('#product-news div:even').attr('class', 'even');
    });
//--></script>
<script type="text/javascript">
    $("#seo_keyword").keyup(function () {
        $.ajax({
            dataType: 'json',
            type: 'POST',
            url: 'index.php?route=catalog/product/checkKeyword&token=<?php echo $this->request->get['token']; ?>',
            data: 'product_id=<?php echo $this->request->get['product_id']; ?>&keyword=' + encodeURIComponent($('input[name=\'keyword\']').val()),
            success: function (result) {
                if (result.success) {
                    $('#seo_keyword_msg').html('<div class="success">' + result.success + '<input size="60" type="hidden" name="seo" value="1" id="seo_url" /></div>');
                }
                if (result.error) {
                    $('#seo_keyword_msg').html('<div class="warning">' + result.error + '</div><input size="60" type="hidden" name="seo" value="0" id="seo_url" />');
                }                
            }
        });
    });

</script>
<?php echo $footer; ?>