#!/usr/bin/Rscript --vanilla

library(curl)
library(jsonlite)

source("common.R")
source("config.R")

basedate <- args.basedate()
offset <- args.offset()

conf <- config()
tz.basedir <- job.tz.basedir(conf, basedate, offset)


task <- conf$job$tasks$pdist
args <- c(
  "--base-date",
  basedate,

  "--input",
  sprintf("%s/attributes/ATRISK-*", tz.basedir),

  "--output",
  sprintf("%s/EDA/pdist", tz.basedir)
)

if (task$overwrite) {
  args <- c(args, "--overwrite")
}


cat(print.timestamp(), "* Running EDA.pdist.\n")
con <- curl('https://apilayer.net/api/live?access_key=ad29873273955cd19f1cac6912c7ee7e&format=2')
cc <- stream_in(con)
quotes <- cc$quotes
names(quotes) <- substr(names(quotes), 4, 6)

exr <- as.character(toJSON(as.list(quotes), auto_unbox = TRUE))
task$properties$valuepotion.eda.exchange_rates <- exr

cat("properties:\n")
print(task$properties)

cat("args:\n")
print(args)


mr.run(
  fs = conf$fs,
  jt = conf$jt,
  jar = file.path(getwd(), "lib", conf$jar$mr),
  class = task$main,
  args = args,
  props = task$properties
)
~                                                                                                                                                                                                                    
~                                        
