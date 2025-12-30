--1. Create assets table
CREATE TABLE assets (
  asset_id SERIAL PRIMARY KEY,
  ticker VARCHAR UNIQUE NOT NULL,
  asset_name VARCHAR 
);

-- 2. create price_logs table
CREATE TABLE price_logs (
  log_id BIGSERIAL PRIMARY KEY,
  asset_id INT REFERENCES assets(asset_id),
  price DECIMAL(18, 8) NOT NULL,
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. create an Index
CREATE INDEX idx_timestamp ON price_logs (timestamp);

-- 4. pre-populate assets
INSERT INTO assets (ticker, asset_name) VALUES 
('BTC', 'Bitcoin'),
('ETH', 'Ethereum');
