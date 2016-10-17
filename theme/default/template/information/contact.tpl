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
    <div class="col-12 col-desktop-6 col-tablet-6">
    <div id="intro" class="rowgutter">
	    <?php echo $content_top; ?>
    </div>
    <div class="linehr"></div>
    <h3>Liên hệ trực tuyến với chúng tôi</h3>
    <div class="rowgutter medium gray">
	    Cho chúng tối biết bạn muốn gì mọi thắc mắc hay thông tin sẽ được chúng tôi giải đáp...
    </div>
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">    
    <div class="contactpage row clear">
	    <div class="col-6 semirowgutter">
		    <label for="name"><?php echo $entry_name; ?> <em>*</em></label>
		    <input type="text" name="name" value="<?php echo $name; ?>" />
		    <?php if ($error_name) { ?>
		    	<span class="error"><?php echo $error_name; ?></span>
		    <?php } ?>		    
	    </div>
	    <div class="col-6 semirowgutter">
		    <label for="phone2">Điện thoại</label>
		    <input type="text" name="phone2" value="<?php echo $phone; ?>" />
	    </div>
	    <div class="col-6 semirowgutter">
		    <label for="email">Thư điện tử <em>*</em></label>
		    <input type="text" name="email" value="<?php echo $email; ?>" />
		    <?php if ($error_email) { ?>
			    <span class="error"><?php echo $error_email; ?></span>
		    <?php } ?>		    
	    </div>
	    <div class="col-6 semirowgutter">
		    <label for="address2"><?php echo $text_address2; ?></label>
		    <input type="text" name="address2" value="<?php echo $address2; ?>" />
	    </div>
	    <div class="col-12 semirowgutter">
		    <label for="enquiry"><?php echo $entry_enquiry; ?></label>
		    <textarea name="enquiry" cols="30" rows="4"><?php echo $enquiry; ?></textarea>
			<?php if ($error_enquiry) { ?>
		    <span class="error"><?php echo $error_enquiry; ?></span>
		    <?php } ?>
	    </div>
	    <div class="col-6 semirowgutter">
		     <input placeholder="<?php echo $entry_captcha; ?>" type="text" id="captcha" name="captcha" value="<?php echo $captcha; ?>" />
		     <img src="index.php?route=information/contact/captcha" alt="" />
		     <?php if ($error_captcha) { ?>
			    <span class="error"><?php echo $error_captcha; ?></span>
		    <?php } ?>
	     </div>
	     <div class="col-6 semirowgutter">
		    <input type="submit" value="<?php echo $entry_submit; ?>" class="button" />
	     </div>
      </form>
    </div>
    </div>
    <div class="col-12 col-desktop-6 col-tablet-6">
    <h3>Thông tin liên hệ</h3>
    <b><i class="fa fa-map-marker" aria-hidden="true"></i>  &nbsp; &nbsp;Địa chỉ:</b> <?php echo $address; ?><br />
       <strong><i class="fa fa-phone-square" aria-hidden="true"></i> &nbsp; Hotline:</strong> <?php echo $hotline; ?> |
        <?php if ($telephone) { ?>
	        <?php echo $telephone; ?>
        <?php } ?>
         <br />
        <?php if ($fax) { ?>
        <b><?php echo $text_fax; ?></b>
        <?php echo $fax; ?><br />
        <?php } ?>
        <b><i class="fa fa-envelope" aria-hidden="true"></i> &nbsp; Email</b>: <a href="mailto:<?php echo $email2;?>"><?php echo $email2 ?></a>
        <div id="map-contact" class="rowgutter">
        	<?php echo $content_bottom; ?>
        </div>
        </div>
    </div>
</div>
</div>
</div>
<?php echo $footer; ?>