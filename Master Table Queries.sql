WITH gross_laba AS (
    SELECT
        price,
        CASE
            WHEN price <= 50000 THEN 0.1
            WHEN price <= 100000 THEN 0.15
            WHEN price <= 300000 THEN 0.2
            WHEN price <= 500000 THEN 0.25
            ELSE 0.3
        END AS persentase_gross_laba
    FROM `kimiafarma-421905.final_task_kf.kf_product`
)

SELECT
    DISTINCT(tr.transaction_id),
    tr.date,
    tr.branch_id,
    kc.branch_name,
    kc.kota,
    kc.provinsi,
    kc.rating AS rating_cabang,
    tr.customer_name,
    tr.product_id,
    prd.product_name,
    tr.price AS actual_price,
    tr.discount_percentage,
    gl.persentase_gross_laba,
    (tr.price - (tr.price * tr.discount_percentage)) AS nett_sales,
    (tr.price - (tr.price * tr.discount_percentage)) * gl.persentase_gross_laba AS nett_profit,
    tr.rating AS rating_transaksi
FROM
    `kimiafarma-421905.final_task_kf.kf_final_transaction` tr 
LEFT JOIN
    `kimiafarma-421905.final_task_kf.kf_kantor_cabang` kc ON kc.branch_id = tr.branch_id
LEFT JOIN 
    `kimiafarma-421905.final_task_kf.kf_product` prd ON prd.product_id = tr.product_id
LEFT JOIN
    gross_laba gl ON tr.price = gl.price