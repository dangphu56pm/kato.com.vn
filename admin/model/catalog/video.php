<?php
class ModelCatalogVideo extends Model {
    
    public function activeComment($comment_id){
        $sql = "SELECT status FROM " . DB_PREFIX . "video_comment WHERE comment_id = '".$comment_id."'";
        $query = $this->db->query($sql);
        if($query->row['status'] == '0')
        {
            $status = '1';
        }  elseif($query->row['status'] == '1') {
            $status = '0';
        }
        $query = $this->db->query("UPDATE " . DB_PREFIX . "video_comment SET status = '".$status."' WHERE comment_id='".$comment_id."'");
    }


    public function getComment($data){
        $sql = "SELECT vc.video_id, vc.comment_id, vd.title, vc.text, vc.date_added, vc.status FROM " . DB_PREFIX . "video_comment vc LEFT JOIN " . DB_PREFIX . "video_description vd ON (vc.video_id = vd.video_id) WHERE 1 AND vd.language_id = '" . (int)$this->config->get('config_language_id') . "'";
        $sort_data = array(
                'vd.title',
        );		

        if (isset($data['sort'])) {
                $sql .= " ORDER BY vd.title";	
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

        public function getVideoCategories(){
        $sql = "SELECT * FROM " . DB_PREFIX . "video_category i LEFT JOIN " . DB_PREFIX . "video_category_description id ON (i.video_category_id = id.video_category_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "'";
        $query = $this->db->query($sql);

	return $query->rows;
    }

        public function addVideo($data) {
            if(isset($data['date_add'])){
            $date_add = "'".$data['date_add']."'";
            }  else {
            $date_add = NOW();    
            }
		$this->db->query("INSERT INTO " . DB_PREFIX . "video SET sort_order = '" . (int)$data['sort_order'] . "', bottom = '" . (isset($data['bottom']) ? (int)$data['bottom'] : 0) . "', status = '" . (int)$data['status'] . "', video_category_id = '" . (int)$data['video_category_id'] . "', url = '" . $data['url'] . "', date_add = ". $date_add);

		$video_id = $this->db->getLastId(); 

		foreach ($data['video_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "video_description SET video_id = '" . (int)$video_id . "', language_id = '" . (int)$language_id . "', title = '" . $this->db->escape($value['title']) . "', description = '" . $this->db->escape($value['description']) . "'");
		}

		if (isset($data['video_store'])) {
			foreach ($data['video_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "video_to_store SET video_id = '" . (int)$video_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		if (isset($data['video_layout'])) {
			foreach ($data['video_layout'] as $store_id => $layout) {
				if ($layout) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "video_to_layout SET video_id = '" . (int)$video_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout['layout_id'] . "'");
				}
			}
		}

		if ($data['keyword']) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'video_id=" . (int)$video_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}

		$this->cache->delete('video');
	}

	public function editVideo($video_id, $data) {
            if(isset($data['date_add'])){
            $date_add = "'".$data['date_add']."'";
            }  else {
            $date_add = NOW();    
            }
		$this->db->query("UPDATE " . DB_PREFIX . "video SET sort_order = '" . (int)$data['sort_order'] . "', bottom = '" . (isset($data['bottom']) ? (int)$data['bottom'] : 0) . "', status = '" . (int)$data['status'] . "', video_category_id = '" . (int)$data['video_category_id'] . "', url = '" . $data['url'] . "', date_add = ". $date_add." WHERE video_id = '" . (int)$video_id . "'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "video_description WHERE video_id = '" . (int)$video_id . "'");

		foreach ($data['video_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "video_description SET video_id = '" . (int)$video_id . "', language_id = '" . (int)$language_id . "', title = '" . $this->db->escape($value['title']) . "', description = '" . $this->db->escape($value['description']) . "'");
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "video_to_store WHERE video_id = '" . (int)$video_id . "'");

		if (isset($data['video_store'])) {
			foreach ($data['video_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "video_to_store SET video_id = '" . (int)$video_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "video_to_layout WHERE video_id = '" . (int)$video_id . "'");

		if (isset($data['video_layout'])) {
			foreach ($data['video_layout'] as $store_id => $layout) {
				if ($layout['layout_id']) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "video_to_layout SET video_id = '" . (int)$video_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout['layout_id'] . "'");
				}
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'video_id=" . (int)$video_id. "'");

		if ($data['keyword']) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'video_id=" . (int)$video_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}

		$this->cache->delete('video');
	}

	public function deleteVideo($video_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "video WHERE video_id = '" . (int)$video_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "video_description WHERE video_id = '" . (int)$video_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "video_to_store WHERE video_id = '" . (int)$video_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "video_to_layout WHERE video_id = '" . (int)$video_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'video_id=" . (int)$video_id . "'");

		$this->cache->delete('video');
	}	

	public function getVideo($video_id) {
		$query = $this->db->query("SELECT DISTINCT *, (SELECT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'video_id=" . (int)$video_id . "') AS keyword FROM " . DB_PREFIX . "video WHERE video_id = '" . (int)$video_id . "'");

		return $query->row;
	}

	public function getVideos($data = array()) {
		if ($data) {
			$sql = "SELECT * FROM " . DB_PREFIX . "video i LEFT JOIN " . DB_PREFIX . "video_description id ON (i.video_id = id.video_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "'";

			$sort_data = array(
				'id.title',
				'i.sort_order'
			);		

			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY " . $data['sort'];	
			} else {
				$sql .= " ORDER BY id.title";	
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
		} else {
			$video_data = $this->cache->get('video.' . (int)$this->config->get('config_language_id'));

			if (!$video_data) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "video i LEFT JOIN " . DB_PREFIX . "video_description id ON (i.video_id = id.video_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY id.title");

				$video_data = $query->rows;

				$this->cache->set('video.' . (int)$this->config->get('config_language_id'), $video_data);
			}	

			return $video_data;			
		}
	}

	public function getVideoDescriptions($video_id) {
		$video_description_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "video_description WHERE video_id = '" . (int)$video_id . "'");

		foreach ($query->rows as $result) {
			$video_description_data[$result['language_id']] = array(
				'title'       => $result['title'],
				'description' => $result['description']
			);
		}

		return $video_description_data;
	}

	public function getVideoStores($video_id) {
		$video_store_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "video_to_store WHERE video_id = '" . (int)$video_id . "'");

		foreach ($query->rows as $result) {
			$video_store_data[] = $result['store_id'];
		}

		return $video_store_data;
	}

	public function getVideoLayouts($video_id) {
		$video_layout_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "video_to_layout WHERE video_id = '" . (int)$video_id . "'");

		foreach ($query->rows as $result) {
			$video_layout_data[$result['store_id']] = $result['layout_id'];
		}

		return $video_layout_data;
	}

	public function getTotalVideos() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "video");

		return $query->row['total'];
	}	

	public function getTotalVideosByLayoutId($layout_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "video_to_layout WHERE layout_id = '" . (int)$layout_id . "'");

		return $query->row['total'];
	}	
}
?>