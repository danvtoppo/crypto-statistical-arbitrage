# crypto-statistical-arbitrage
An ETL pipeline and analytical engine built to detect price divergence between BTC and ETH using rolling Z-Scores.

The StackPipeline: 
Python (CCXT + Kraken API)
Database: Neon (Serverless Postgres)
Analytics: SQL 

The Logic
The system calculates a rolling Z-Score of the BTC/ETH ratio to identify mean-reversion opportunities:

If Z > 2.0: BTC Overvalued (Short BTC / Long ETH)
If Z < -2.0: BTC Undervalued (Long BTC / Short ETH)

Architecture
Ingestion: Python script streams live prices every 5s into Neon.
Processing: All math is handled server-side via a Postgres View in Neon.
Efficiency: Separation of concerns—Python handles I/O, while Neon handles the statistical heavy lifting.

Structure
ingestion.py: Live data streaming 
script.schema.sql: Database tables and Neon View 
