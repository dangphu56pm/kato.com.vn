<div class="box news">
  <h2 class="heading uppercase">Bài viết hay nhất</h2>
    <ul class="dashedlist">
      <?php foreach ($products as $product) { ?>
        <li ><a class="medium grey block" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a><?php echo $product['total_rate']; ?> votes</li>
      <?php } ?>
	  </ul>
    </div>

  
