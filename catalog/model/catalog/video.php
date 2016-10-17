<?php
class ModelCatalogVideo extends Model{
    public function getVideo($video_id) {
		$query = $this->db->query("SELECT * FROM ". DB_PREFIX . "video v LEFT JOIN " . DB_PREFIX . "video_description vd ON (v.video_id = vd.video_id) WHERE v.video_id = '" . (int)$video_id . "' AND vd.language_id = '" . (int)$this->config->get('config_language_id') . "'");
		return $query->row;
	}
	
	public function getVideos($data){
		$sql = "SELECT * FROM ". DB_PREFIX . "video v LEFT JOIN " . DB_PREFIX . "video_description vd ON (v.video_id = vd.video_id) WHERE v.video_id > 0 AND v.status = '1' AND vd.language_id = '" . (int)$this->config->get('config_language_id') . "' ";
		
		
		$sort_data = array(
			'v.date_add',		
			'vd.title',
			'v.quantity',
			'v.sort_order'
		);
		
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			if ($data['sort'] == 'vd.title') {
				$sql .= " ORDER BY v.sort_order, LCASE(" . $data['sort'] . ")";
			} else {
				$sql .= " ORDER BY v.sort_order, " . $data['sort'];
			}
		} else {
			$sql .= " ORDER BY v.sort_order";	
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
	public function getTotalVideos(){
		$sql = "SELECT COUNT(*) AS total FROM ". DB_PREFIX . "video v LEFT JOIN " . DB_PREFIX . "video_description vd ON (v.video_id = vd.video_id) WHERE 1  AND v.status = '1' AND vd.language_id = '" . (int)$this->config->get('config_language_id') . "' ";
		$query = $this->db->query($sql);
		return $query->row['total'];
	}
}

?>