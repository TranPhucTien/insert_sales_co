-- Insert VENDOR
INSERT INTO VENDOR(
        v_name,
        v_contact,
        v_areacode,
        v_phone,
        v_state,
        v_order
    )
VALUES (
        'Bryson, Inc.',
        'Smithson',
        '615',
        '223-3234',
        'TN',
        1
    ),
    (
        'SuperLoo, Inc.',
        'Flushing',
        '904',
        '215-8995',
        'FL',
        0
    ),
    (
        'D&E Supply',
        'Singh',
        '615',
        '228-3245',
        'TN',
        1
    ),
    (
        'Gomez Bros.',
        'Ortega',
        '615',
        '889-2546',
        'KY',
        0
    ),
    (
        'Dome Supply',
        'Smith',
        '901',
        '678-1419',
        'GA',
        0
    ),
    (
        'Randsets Ltd.',
        'Anderson',
        '901',
        '678-3998',
        'GA',
        1
    ),
    (
        'Brackman Bros.',
        'Browning',
        '615',
        '228-1410',
        'TN',
        0
    ),
    (
        'ORDVA, Inc.',
        'Hakford',
        '615',
        '898-1234',
        'TN',
        1
    ),
    ('B&K, Inc.', 'Smith', '904', '227-0093', 'FL', 0),
    (
        'Damal Supplies',
        'Smythe',
        '615',
        '890-3529',
        'TN',
        0
    ),
    (
        'Rubicon Systems',
        'Orton',
        '904',
        '456-0092',
        'FL',
        1
    ),
    ('Laptop', 'Valtteri', '624', '778-2336', 'FL', 1),
    (
        'Tablet',
        'Guadalupe',
        '123',
        '822-1484',
        'FL',
        1
    ),
    ('Vietnam', 'Eliza', '645', '999-9776', 'TN', 1),
    (
        'Mobile gaming',
        'Soeraya',
        '123',
        '618-1754',
        'GA',
        1
    ),
    ('Movie', 'Yasnozir', '364', '128-5438', 'TL', 1),
    ('kindle', 'Derrick', '274', '187-8536', 'KY', 1),
    ('design', 'Cecilia', '983', '649-9195', 'NY', 1),
    (
        'supperman',
        'Capheni',
        '123',
        '307-8213',
        'NY',
        1
    ),
    ('ps5', 'Wisp', '904', '975-7578', 'GA', 1);
-- Insert ACCT_TRANSACTION
INSERT INTO ACCT_TRANSACTION(
        acct_trans_date,
        acct_trans_type,
        cus_code,
        acct_trans_amount
    )
VALUES ('2018-01-17', '10014', 'charge', '329.66'),
    ('2018-01-17', '10011', 'charge', '615.73'),
    ('2018-01-29', '10014', 'payment', '329.66'),
    ('2018-01-18', '10016', 'charge', '277.55');