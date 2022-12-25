-- Update v_order = 0 when vendor doesn't have any products
UPDATE VENDOR
SET v_order = (
        SELECT CASE
                WHEN COUNT(PRODUCT.v_code) = 0 THEN 0
                ELSE 1
            END
        FROM PRODUCT
        WHERE PRODUCT.v_code = VENDOR.v_code
    );
-- Update subtotal of INVOICE from LINE
UPDATE INVOICE i
    JOIN (
        SELECT inv_number,
            SUM(line_units * line_price) AS subtotal
        FROM LINE
        GROUP BY inv_number
    ) l ON i.inv_number = l.inv_number
SET i.inv_subtotal = l.subtotal,
    i.inv_subtotal = l.subtotal * (100 + i.inv_tax) / 100;
-- Update balance of CUSTOMER from ACCT_TRANSACTION and INVOICE
UPDATE CUSTOMER
SET CUSTOMER.cus_balance = (
        SELECT SUM(ACCT_TRANSACTION.acct_trans_amount)
        FROM ACCT_TRANSACTION
        WHERE ACCT_TRANSACTION.cus_code = CUSTOMER.cus_code
    ) - (
        SELECT SUM(INVOICE.inv_total)
        FROM INVOICE
        WHERE INVOICE.cus_code = CUSTOMER.cus_code
    )
WHERE EXISTS (
        SELECT 1
        FROM ACCT_TRANSACTION
        WHERE ACCT_TRANSACTION.cus_code = CUSTOMER.cus_code
    );
-- Update p_reorder of PRODUCT
UPDATE PRODUCT p
    INNER JOIN (
        SELECT p_code,
            COUNT(*) as count
        FROM INVOICE i
            INNER JOIN LINE l ON i.inv_number = l.inv_number
        GROUP BY p_code
    ) t ON p.p_code = t.p_code
SET p.p_reorder = t.count;