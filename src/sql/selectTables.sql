-- Lấy ra 10 khách hàng nợ nhiều nhất
SELECT cus_lname,
    cus_fname,
    cus_balance
from CUSTOMER
ORDER BY CUSTOMER.cus_balance
limit 1, 10;
-- Lấy ra 10 khách hàng có số dư tài khoản lớn nhất
SELECT cus_lname,
    cus_fname,
    cus_balance
from CUSTOMER
ORDER BY CUSTOMER.cus_balance DESC
limit 1, 10;
-- Lấy ra các khách hàng có số dư lớn hơn 1000
SELECT cus_code,
    cus_lname,
    cus_fname,
    cus_balance
from CUSTOMER
WHERE CUSTOMER.cus_balance > 1000;
-- Lấy ra các khách hàng có số dư = 0
SELECT cus_code,
    cus_lname,
    cus_fname,
    cus_balance
from CUSTOMER
WHERE CUSTOMER.cus_balance = 0;
-- Lấy ra các khách hàng có tên bắt đầu bằng 'a'
SELECT cus_code,
    cus_lname,
    cus_fname,
    cus_balance
from CUSTOMER
WHERE CUSTOMER.cus_fname LIKE 'a%';
-- Lấy mã, số dư, tổng số tiền đã mua của khách hàng
SELECT CUSTOMER.cus_code,
    cus_balance,
    SUM(LINE.line_total) as total
FROM INVOICE
    INNER JOIN LINE ON LINE.inv_number = INVOICE.inv_number
    INNER JOIN PRODUCT ON PRODUCT.p_code = LINE.p_code
    INNER JOIN CUSTOMER ON CUSTOMER.cus_code = INVOICE.cus_code
GROUP BY cus_code;
-- Lấy ra 10 sản phẩm có giá thấp nhất
SELECT PRODUCT.p_code,
    PRODUCT.p_name,
    PRODUCT.p_price
FROM PRODUCT
ORDER BY PRODUCT.p_price ASC
LIMIT 10;
-- Lấy ra 10 sản phẩm có giá cao nhất
SELECT PRODUCT.p_code,
    PRODUCT.p_name,
    PRODUCT.p_price
FROM PRODUCT
ORDER BY PRODUCT.p_price DESC
LIMIT 10;
-- Lấy ra 10 sản phẩm được đặt lại nhiều nhất
SELECT PRODUCT.p_code,
    PRODUCT.p_name,
    PRODUCT.p_reorder
FROM PRODUCT
ORDER BY PRODUCT.p_reorder DESC
LIMIT 10;
-- Lấy ra 10 sản phầm được mua nhiều nhất
SELECT p_code,
    SUM(LINE.line_units) AS purchase_total
FROM INVOICE
    JOIN LINE ON LINE.inv_number = INVOICE.inv_number
GROUP BY p_code
ORDER BY purchase_total DESC
LIMIT 10;
-- Đếm số lần sản phẩm được order lại
SELECT p_code,
    COUNT(*) AS purchase_count
FROM INVOICE
    JOIN LINE ON LINE.inv_number = INVOICE.inv_number
GROUP BY p_code;
-- Đếm số lần sản phẩm được mua
SELECT p_code,
    SUM(LINE.line_units) AS purchase_total
FROM INVOICE
    JOIN LINE ON LINE.inv_number = INVOICE.inv_number
GROUP BY p_code;
-- Lấy ra 10 sản phẩm có giá cao nhất
SELECT p_name,
    p_price
FROM PRODUCT
ORDER BY p_price DESC
LIMIT 10;
-- Lấy 10 sản phẩm có giá thấp nhất
SELECT p_name,
    p_price
FROM PRODUCT
ORDER BY p_price ASC
LIMIT 10;
-- Lấy 10 sản phẩm được giảm giá nhiều nhất
SELECT p_name,
    p_price,
    p_discount
FROM PRODUCT
ORDER BY p_discount DESC
LIMIT 10;
-- Đếm số lượng hóa đơn
SELECT COUNT(INVOICE.inv_number) as invoice_count
from INVOICE;
-- Lấy thông tin của các sản phẩm theo hóa đơn
SELECT cus_code,
    INVOICE.inv_number,
    inv_date,
    p_desc,
    line_units,
    line_price
FROM INVOICE
    INNER JOIN LINE ON LINE.inv_number = INVOICE.inv_number
    INNER JOIN PRODUCT ON PRODUCT.p_code = LINE.p_code;
-- Lấy mã hóa đơn và tổng tiền của hóa đơn
SELECT INVOICE.inv_number,
    INVOICE.inv_total as total
from INVOICE;
-- Lấy ra 10 hóa đơn đắt nhất
SELECT i.inv_number,
    i.inv_total
FROM INVOICE i
ORDER BY i.inv_total DESC
LIMIT 10;
-- Lấy ra 10 hóa đơn rẻ nhất
SELECT i.inv_number,
    i.inv_total
FROM INVOICE i
ORDER BY i.inv_total DESC
LIMIT 10;
-- Lấy danh sách các nhà cung cấp
SELECT *
FROM VENDOR;
-- Số lượng sản phẩm được cung cấp bởi từng nhà cung cấp
SELECT VENDOR.v_code,
    v_name,
    COUNT(PRODUCT.p_code)
FROM VENDOR
    LEFT JOIN PRODUCT ON PRODUCT.v_code = VENDOR.v_code
GROUP BY VENDOR.v_code -- Lấy ra 10 nhà cung cấp, cung cấp nhiều sản phẩm nhất
SELECT VENDOR.v_code,
    v_name,
    COUNT(PRODUCT.p_code) as count
FROM VENDOR
    LEFT JOIN PRODUCT ON PRODUCT.v_code = VENDOR.v_code
GROUP BY VENDOR.v_code
ORDER BY count DESC
LIMIT 10;
-- Lấy ra 10 nhà cung cấp chưa cung cấp sản phẩm nào
SELECT VENDOR.v_code,
    v_name,
    COUNT(PRODUCT.p_code) as count
FROM VENDOR
    LEFT JOIN PRODUCT ON PRODUCT.v_code = VENDOR.v_code
GROUP BY VENDOR.v_code
HAVING count = 0;
-- Lấy ra hóa đơn có nhiều dòng nhất
SELECT LINE.inv_number,
    LINE.line_number
FROM `LINE`
GROUP BY line_number DESC
LIMIT 1;
-- Xem các dòng trong hóa đơn
SELECT INVOICE.inv_number,
    LINE.line_number,
    LINE.p_code,
    LINE.line_units,
    LINE.line_price,
    LINE.line_total
FROM INVOICE
    INNER JOIN LINE ON LINE.inv_number = INVOICE.inv_number
WHERE INVOICE.inv_number = '11cdb1f31f1e365'