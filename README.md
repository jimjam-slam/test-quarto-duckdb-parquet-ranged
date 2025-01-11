# test-quarto-duckdb-parquet-ranged
Quick test to see if Quarto can use ranged HTTP requests when querying a Parquet file. Compare the [Observable Framework](https://github.com/jimjam-slam/test-of-duckdb-parquet-ranged) test and the [Observable notebook](https://observablehq.com/@jimjamslam/ranged-parquet-duckdb-test) test — Observable Framework uses a newer version of DuckDB-WASM, so that might be why it's the one that seems to work!

[ACORN-SAT](http://www.bom.gov.au/climate/data/acorn-sat) data is from the [Bureau of Meteorology](http://www.bom.gov.au). It is not covered by this repo's MIT licence, but the BOM has a [Creative Commons Attribution](https://creativecommons.org/licenses/by/4.0/deed.en) notice on its [ACORN-SAT page](http://www.bom.gov.au/climate/data/acorn-sat/).

> [!IMPORTANT]
> Because this repo includes several Parquet files, you should consider only cloning the HEAD (latest state of the repo) unless you need older versions:
> 
> ```
> git clone --depth 1 https://github.com/jimjam-slam/test-quarto-duckdb-parquet-ranged.git
> ```

`acorn.r`: package ACORN-SAT files into Parquet files. Row-grouped versions are also available.

`index.qmd`: test to see if the Parquet file is accessed using HTTP ranged requests when accessed with the Observable DuckDB client, or with a newer version of the client using a newer version of DuckDB-WASM.

## Host tests:

**Host**         | **Works?** | **Comment**
-----------------|------------|--------------
GitHub raw URL   | ❌ No      | Works at `shell.duckdb.org`, so it's an Observable DuckDB-WASM problem
Cloudflare Pages | Testing    | 
