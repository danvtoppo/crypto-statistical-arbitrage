# Crypto Statistical Arbitrage Pipeline

An ETL pipeline and analytical engine built to detect price divergence between BTC and ETH using rolling Z-Scores.

## The Stack
* Pipeline: Python (CCXT + Kraken API)
* Database: Neon (Serverless Postgres)
* Analytics: SQL

## The Logic
The system calculates a rolling Z-Score of the BTC/ETH ratio to identify mean-reversion opportunities:

* If Z > 2.0: BTC is Overvalued relative to ETH (Strategy: Short BTC / Long ETH)
* If Z < -2.0: BTC is Undervalued relative to ETH (Strategy: Long BTC / Short ETH)

## Architecture
* Ingestion: Python script streams live prices every 5 seconds into Neon.
* Processing: All statistical math is handled server-side via a Postgres View in Neon.
* Efficiency: Separation of concerns—Python handles I/O and API communication, while Neon handles the intensive statistical heavy lifting.

## Structure
* `trading_pipeline.jpynb`: Database insertion script.
* `schema.sql`: Database table definitions and Neon View logic.

----

### Professional Summary
> Real-Time Statistical Engine: Architected a data pipeline using Python and Neon Postgres to ingest live crypto data and generate trading signals via SQL Window Functions (Rolling Z-Scores).
