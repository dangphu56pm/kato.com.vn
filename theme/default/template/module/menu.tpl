<?php if ($position=='top_menu'){ ?>
	<ul class="list-inline" id="menu-topmenu"> 
		<?php echo $menu;?>
	</ul>
<?php } else if ($position =='column_right') { ?>
<div class="box">
	<h3 class="box-heading"><?php echo $menu_name; ?></h3>
	<ul class="list-unstyled list-menu list-menu-fake">
		<?php echo $menu;?>
	</ul>
</div>	
<?php } else if ($position =='footer_menu') { ?>
<div class="col-12 col-desktop-3 col-tablet-3">
	<span class="h3 uppercase font13 strong"><?php echo $menu_name; ?></span>
	<ul class="menu list-unstyled">
		<?php echo $menu;?>
	</ul>
</div>	
<?php } else { ?>
	<ul class="menu list-unstyled right">
		<?php echo $menu;?>
	</ul>
<?php }  ?>