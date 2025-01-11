library(tidyverse)
library(arrow)
library(here)

dir.create(here("data", "import"), showWarnings = FALSE, recursive = TRUE)

urls <- paste0(
  "ftp://ftp.bom.gov.au/anon/home/ncc/www/change/ACORN_SAT_daily/",
  "acorn_sat_v2.5.0_daily_t",
  c("max", "min"),
  ".tar.gz")

# download and extract files
urls |>
  walk(~ download.file(.x, destfile = here("data", "import", basename(.x)))) |>
  walk(~ untar(
    here("data", "import", basename(.x)),
    exdir = here("data", "import")))

# pull in all csv files extracted
list.files(here("data", "import"),
  pattern = glob2rx("*.csv"),
  full.names = TRUE) |>
  set_names() |>
  map(read_csv) |>
  bind_rows(.id = "path") ->
imported_data

# let's pull the site metadata rows out separately and reattach them later
imported_data |>
  select(starts_with("site")) |>
  set_names(c("site_num", "site_name")) |>
  filter(!is.na(site_num)) |>
  write_csv(here("data", "acorn-metadata.csv")) ->
site_metadata

# now let's tidy it up so that it's suitable for parquet export
imported_data |>
  # drop metadata rows (we'll take it from the filename)
  filter(is.na(`site number`)) |>
  select(-`site number`, -`site name`) |>
  # coalesce min and max temps (we'll extract which it is from filename)
  mutate(
    temperature = coalesce(
      `maximum temperature (degC)`,
      `minimum temperature (degC)`),
    filename = basename(path)) |>
  select(-ends_with("temperature (degC)"), -path) |>
  # now widen again
  separate(filename, into = c("var", "station_num"), sep = "\\.",
    extra = "drop") |>
  pivot_wider(
    names_from = var,
    values_from = temperature) ->
tidy_data

# now let's export to parquet!
tidy_data |>
  select(site_num = station_num, date, tmax, tmin) |>
  write_parquet(here("data", "acorn-sat.parquet"))
