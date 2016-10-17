<?php
class ModelFidoFaq extends Model {
	public function getTopic($faq_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "faq f LEFT JOIN " . DB_PREFIX . "faq_description fd ON (f.faq_id = fd.faq_id) LEFT JOIN " . DB_PREFIX . "faq_to_store f2s ON (f.faq_id = f2s.faq_id) WHERE f.faq_id = '" . (int)$faq_id . "' AND fd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND f2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND f.status = '1'");
		return $query->row;
	}

	public function getTopics($topic_id = 0) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "faq f LEFT JOIN " . DB_PREFIX . "faq_description fd ON (f.faq_id = fd.faq_id) LEFT JOIN " . DB_PREFIX . "faq_to_store f2s ON (f.faq_id = f2s.faq_id) WHERE f.topic_id = '" . (int)$topic_id . "' AND fd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND f2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND f.status = '1' ORDER BY f.sort_order");
		return $query->rows;
	}

	public function getTotalFaqsByTopicId($topic_id = 0) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "faq f LEFT JOIN " . DB_PREFIX . "faq_to_store f2s ON (f.faq_id = f2s.faq_id) WHERE f.topic_id = '" . (int)$topic_id . "' AND f2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND f.status = '1'");
		return $query->row['total'];
	}
}
?>
