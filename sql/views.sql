WITH BTC AS (
    SELECT price AS btc_price, date_trunc('second', timestamp) as clean_time
    FROM price_logs WHERE asset_id = 1
),
ETH AS (
    SELECT price AS eth_price, date_trunc('second', timestamp) as clean_time
    FROM price_logs WHERE asset_id = 2
),
PREP AS (
    SELECT 
        COALESCE(btc.clean_time, eth.clean_time) AS ts,
        btc_price,
        eth_price,
        (btc_price / eth_price) AS ratio
    FROM BTC
    FULL OUTER JOIN ETH USING (clean_time)
),
STATS AS (
    SELECT 
        *,
        AVG(ratio) OVER (ORDER BY ts ASC ROWS BETWEEN 20 PRECEDING AND CURRENT ROW) as rolling_mean,
        STDDEV(ratio) OVER (ORDER BY ts ASC ROWS BETWEEN 20 PRECEDING AND CURRENT ROW) as rolling_std
    FROM PREP
)
SELECT 
    ts,
    btc_price,
    eth_price,
    ratio,
    (ratio - rolling_mean) / NULLIF(rolling_std, 0) as z_score
FROM STATS
ORDER BY ts DESC;
