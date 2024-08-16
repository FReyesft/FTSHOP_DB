ALTER TABLE orders
ADD CONSTRAINT fk_id_term_order_status
FOREIGN KEY (id_term_order_status)
REFERENCES terms(id)
ON DELETE CASCADE
ON UPDATE CASCADE;
