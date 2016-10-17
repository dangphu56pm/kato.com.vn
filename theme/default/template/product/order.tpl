<?php echo $header; ?>
<div class="row clear no-margin clearfix">
  <div class="col-12 col-desktop-8 col-tablet-8 left-col">
  <div class="small breadcrumbs">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>  
  <h1>Đặt hàng trực tuyến</h1>
  <?php if($products){ ?>
	   <span>Thêm sản phẩm:</span>
  <select id="select">
  <option>---Chọn sản phẩm---</option>
  <?php foreach($products as $rs){ ?>
	<option value="<?php echo $rs['product_id']?>"><?php echo $rs['name']?></option>
	<?php } ?>
  </select>
  <script type="">
	var select_element = document.getElementById("select");
	select_element.onchange = function(e){
    if (!e)
        var e = window.event;
    var svalue = this.options[this.selectedIndex].value;
	var url = '<?php echo $url_order?>_'+svalue;
	url = url.replace(/&amp;/gi,"&");
	window.location.href = url;
	}
	</script>
	<?php } ?>
  <?php if($products_url){ ?>
       <table class="table-list">
	    <?php foreach($products_url as $product) { ?>
	    <tr>
    	   <td class="thumb">
	      <?php if ($product['thumb']) { ?>
	      	<a target="_blank" href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>
	      	<?php } ?>
	      </td>
	      <td><h3 class="name medium"><a target="_blank" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3></td>
		  <td class="small text-center"><a onClick="remove_('<?php echo $product['product_id'];?>')">Xóa</a></td>
	    </tr>
	    <?php } ?>
	  </table>
	  <script>
	function remove_(product_id){
	var url = '<?php echo $url_order?>';
	url = url.replace('_'+product_id,"");
	url = url.replace(/&amp;/gi,"&");
	window.location.href = url;
	}
	</script>
	  <?php } ?>
	   
  
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
    <h2>Thông tin của bạn</h2>
    <div class="contactpage">
    <?php if ($error_name) { ?>
    <span class="error"><?php echo $error_name; ?></span>
    <?php } ?>
    <?php if ($error_email) { ?>
    <span class="error"><?php echo $error_email; ?></span>
    <?php } ?>
    <div class="row clear">
    	<div class="col-6">
    		<input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?> *" />
    	</div>
    	<div class="col-6">
	    	<input type="text" name="phone2" value="<?php echo $phone; ?>" placeholder="<?php echo $text_phone; ?>" />
    	</div>
    </div>
    <div class="row clear">
		<div class="col-6">
		    <input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?> *" />
		</div>
		<div class="col-6">		
			<input type="text" name="address2" value="<?php echo $address2; ?>" placeholder="<?php echo $text_address2; ?>" />
		</div>
    </div>
    <textarea name="enquiry" cols="30" rows="4" placeholder="<?php echo $entry_enquiry; ?>"><?php echo $enquiry; ?></textarea>
    <br />
    <?php if ($error_enquiry) { ?>
    <span class="error"><?php echo $error_enquiry; ?></span>
    <?php } ?>
    <?php if ($error_captcha) { ?>
    <span class="error"><?php echo $error_captcha; ?></span>
    <?php } ?>    
    
    <input placeholder="<?php echo $entry_captcha; ?>" type="text" id="captcha" name="captcha" value="<?php echo $captcha; ?>" />
    <img src="index.php?route=information/contact/captcha" alt="" />
    <br />
    <input type="submit" style="width:230px;text-transform:uppercasse" value="<?php echo "Đặt mua"; ?>" class="button" />
        <br />
            <br />
    </div>

  </form>
  </div>
  <?php echo $column_right; ?> 
</div>
<?php echo $footer; ?>