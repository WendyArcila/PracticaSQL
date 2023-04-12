
-- -----------------------------------------------------
-- 1. CONSULTA SQL DONDE PUEDA OBTENER LOS PRODUCTOS VENDIDOS DIGITANDO TIPO DE DOCUMENTO Y NÚMERO DE DOCUMENTO.
-- -----------------------------------------------------

SELECT product.pro_name FROM product, sale, client
WHERE product.pro_id = sale.product_pro_id
AND client.cli_id = sale.client_cli_id
AND client.card_type = 'CC'
AND client.card_number = '456456';

-- -----------------------------------------------------
-- 2. CONSULTAR PRODUCTOS POR MEDIO DEL NOMBRE, EL CUAL DEBE MOSTRAR QUIEN O QUIENES HAN SIDO SUS PROVEEDORES.
-- -----------------------------------------------------
SELECT product.pro_name, supplier.sup_name
FROM supplier
INNER JOIN product
ON supplier.sup_id = product.supplier_sup_id
WHERE pro_name = 'Arroz';