<?php
class ModelCatalogGallimage extends Model {	
	public function getGallimage($gallimage_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "gallimage_image gi LEFT JOIN " . DB_PREFIX . "gallimage_image_description gid ON (gi.gallimage_image_id  = gid.gallimage_image_id) WHERE gi.gallimage_id = '" . (int)$gallimage_id . "' AND gid.language_id = '" . (int)$this->config->get('config_language_id') . "'");
		
		return $query->rows;
	}

	public function getGallimageName($gallimage_id) {
		if($this->config->get('config_language_id')==2){
			$query = $this->db->query("SELECT name FROM " . DB_PREFIX . "gallimage WHERE gallimage_id = '" . (int)$gallimage_id . "'");
			return $query->row['name'];
		}else{
			$query = $this->db->query("SELECT name_en FROM " . DB_PREFIX . "gallimage WHERE gallimage_id = '" . (int)$gallimage_id . "'");
			return $query->row['name_en'];
		}
		
	}
	
	public function getListImage($data){
		$sql = "SELECT * FROM " . DB_PREFIX . "gallimage WHERE 1 AND status = '1' ";
		
		$sort_data = array(
			'name',
			'name_en',
			'sort_order',
			'date_added'
		);
		
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			if ($data['sort'] == 'name' || $data['sort'] == 'name_en') {
				$sql .= " ORDER BY sort_order, LCASE(" . $data['sort'] . ")";
			} else {
				$sql .= " ORDER BY sort_order, " . $data['sort'];
			}
		} else {
			$sql .= " ORDER BY sort_order";	
		}
		
		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}
		
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
	}
	
	public function getFirstImages($gallimage_id){
		$sql = "SELECT * FROM " . DB_PREFIX . "gallimage g LEFT JOIN " . DB_PREFIX . "gallimage_image gi ON (g.gallimage_id=gi.gallimage_id) WHERE g.gallimage_id = '". $gallimage_id ."'";
		$query = $this->db->query($sql);
		return $query->row;	
	}
	
	public function getTotalImages(){
		$sql = "SELECT COUNT(*) as total FROM " . DB_PREFIX . "gallimage WHERE 1 ";
		$query = $this->db->query($sql);
		return $query->row['total'];	
	}
}
?>