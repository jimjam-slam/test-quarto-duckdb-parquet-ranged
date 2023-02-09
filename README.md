# test-quarto-duckdb-parquet-ranged
Quick test to see if Quarto can use ranged HTTP requests when querying a Parquet file.

[ACORN-SAT](http://www.bom.gov.au/climate/data/acorn-sat) data is from the [Bureau of Meteorology](http://www.bom.gov.au). It is not covered by this repo's MIT licence. 

`acorn.r`: package ACORN-SAT 2.3 files into a Parquet file.

`index.qmd`: test to see if the Parquet file is accessed using HTTP ranged requests when accessed with the Observervable DuckDB client.
