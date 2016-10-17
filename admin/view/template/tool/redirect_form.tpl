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
      <h1><img src="view/image/information.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
            <table class="form">
              <tr>
                <td><span class="required">*</span> <?php echo $entry_old_url; ?></td>
                <td><input type="text" name="old_url" size="100" value="<?php echo $old_url; ?>" /></td>
              </tr>
              <tr>
                <td><span class="required">*</span> <?php echo $entry_new_url; ?></td>
                <td><input type="text" name="new_url" id="new_url" size="100" value="<?php echo $new_url; ?>" /></td>
              </tr>
            </table>
      </form>
    </div>
  </div>
</div>
<script text="text/javascript"><!--
$("#new_url").keypress(function(event) {
    if (event.which == 13) {
        event.preventDefault();
        $("form").submit();
    }
});
//--></script>
<?php echo $footer; ?>