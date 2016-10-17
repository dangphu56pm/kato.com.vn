<div class="box">
<h3 class="box-heading"><?php echo $heading_title; ?><span></h3>
    <ul class="list-unstyled list-menu">
        <?php foreach ($categories as $category) { ?>
        <li>
          <?php if ($category['news_category_id'] == $news_category_id) { ?>
          <a href="<?php echo $category['href']; ?>" class="active"><i class="fa fa-arrow-circle-right" aria-hidden="true"></i> <?php echo $category['name']; ?></a>
          <?php } else { ?>
          <a href="<?php echo $category['href']; ?>"><i class="fa fa-arrow-circle-right" aria-hidden="true"></i> <?php echo $category['name']; ?></a>
          <?php } ?>
          <?php if ($category['children']) { ?>
          <ul>
            <?php foreach ($category['children'] as $child) { ?>
            <li>
              <?php if ($child['news_category_id'] == $child_id) { ?>
              <a href="<?php echo $child['href']; ?>" class="active"><?php echo $child['name']; ?></a>
              <?php } else { ?>
              <a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a>
              <?php } ?>
            </li>
            <?php } ?>
          </ul>
          <?php } ?>
        </li>
        <?php } ?>
      </ul>
</div>
