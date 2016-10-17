<?php
class ModelToolRedirect extends Model {
	public function addRedirect($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "redirect SET old_url = '" . (isset($data['old_url']) ? $this->db->escape($data['old_url']) : '')  . "',new_url = '" . (isset($data['new_url']) ? $this->db->escape($data['new_url']) : '') . "'");

		$redirect_id = $this->db->getLastId();		
		$this->cache->delete('redirect');
	}
	
	public function editRedirect($redirect_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "redirect SET old_url = '" . (isset($data['old_url']) ? $this->db->escape($data['old_url']) : '')  . "', new_url = '" . (isset($data['new_url']) ? $this->db->escape($data['new_url']) : '') . "' WHERE redirect_id = '" .  $redirect_id ."'");
				
		$this->cache->delete('redirect');
	}
	
	public function deleteRedirect($redirect_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "redirect WHERE redirect_id = '" . (int)$redirect_id . "'");
		$this->cache->delete('redirect');
	}	

	public function getRedirect($redirect_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "redirect WHERE redirect_id = '" . (int)$redirect_id . "'");
		
		return $query->row;
	}
		
	public function getRedirects($data = array()) {
		if ($data) {
			$sql = "SELECT * FROM " . DB_PREFIX . "redirect";
				
			if (isset($data['start']) || isset($data['limit'])) {
				if ($data['start'] < 0) {
					$data['start'] = 0;
				}		

				if ($data['limit'] < 1) {
					$data['limit'] = 20;
				}	
			
				$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
			}	
			
			$query = $this->db->query($sql);
			
			return $query->rows;
		} else {
			$redirect_data = $this->cache->get('redirect.' . (int)$this->config->get('config_language_id'));
		
			if (!$redirect_data) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "redirect i LEFT JOIN " . DB_PREFIX . "redirect_description id ON (i.redirect_id = id.redirect_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY id.title");
	
				$redirect_data = $query->rows;
			
				$this->cache->set('redirect.' . (int)$this->config->get('config_language_id'), $redirect_data);
			}	
	
			return $redirect_data;			
		}
	}
	
			
	public function getTotalRedirects() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "redirect");
		
		return $query->row['total'];
	}	
	
}
?>