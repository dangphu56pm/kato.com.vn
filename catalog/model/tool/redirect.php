<?php 
class ModelToolRedirect extends Model {
	public function getRedirect($redirect_text) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "redirect WHERE old_url LIKE '" . $this->db->escape($redirect_text) . "'");
	
		return $query->row;
	}

}
?>