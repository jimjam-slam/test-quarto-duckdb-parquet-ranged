# test-quarto-duckdb-parquet-ranged
Quick test to see if Quarto can use ranged HTTP requests when querying a Parquet file. Compare the [Observable Framework](https://github.com/jimjam-slam/test-of-duckdb-parquet-ranged) test and the [Observable notebook](https://observablehq.com/@jimjamslam/ranged-parquet-duckdb-test) test — Observable Framework uses a newer version of DuckDB-WASM, so that might be why it's the one that seems to work!

[ACORN-SAT](http://www.bom.gov.au/climate/data/acorn-sat) data is from the [Bureau of Meteorology](http://www.bom.gov.au). It is not covered by this repo's MIT licence. 

`acorn.r`: package ACORN-SAT 2.3 files into a Parquet file.

`index.qmd`: test to see if the Parquet file is accessed using HTTP ranged requests when accessed with the Observable DuckDB client.
  - The doc has been updated to pull the file directly from GitHub rather than locally, but it's still not working. It does look like DuckDB-WASM has the ability to do ranged requests, though, so this is likely a case of bad headers from the server. Will play around more!
  

## Host tests:

**Host**         | **Works?** | **Comment**
-----------------|------------|--------------
GitHub raw URL   | ❌ No      |
Cloudflare Pages | Testing    | 
