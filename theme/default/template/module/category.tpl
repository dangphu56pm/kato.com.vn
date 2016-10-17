<div class="box category">
  <div class="box-heading"><p>Tìm kiếm nhanh</p></div>
  <div class="box-content">
    <ul class="box-category">
      <?php foreach ($categories as $category) { ?>
      <li>
        <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a><div class="arrow-down"></div><div class="arrow-left"></div>
        <?php if ($category['children']) { ?>
        <ul>
          <?php foreach ($category['children'] as $child) { ?>
          <li>
            <a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a>
          </li>
          <?php } ?>
        </ul>
        <?php } ?>
      </li>
      <?php } ?>
    </ul>
  </div>
</div>
<script type="text/javascript">
  $(document).ready(function(){
  $(".arrow-down").show();
  $(".arrow-left").hide();
  $(".arrow-left").click(function(){
    $(this).parent().children("ul").show();
    $(this).css("display","none");
    $(this).parent().children(".arrow-down").css("display","block");
  });
  $(".arrow-down").click(function(){
    $(this).parent().children("ul").hide();
    $(this).css("display","none");
    $(this).parent().children(".arrow-left").css("display","block");
  });
});
</script>
