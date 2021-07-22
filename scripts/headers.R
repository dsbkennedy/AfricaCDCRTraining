source("scripts/viewerpane_html.R")
viewerpane_html("01-intro.html")
knitr::purl("01-intro.Rmd", "scripts/01-intro.R")
knitr::purl("02-management.Rmd", "scripts/02-management.R")
knitr::purl("03-analysis.Rmd", "scripts/03-analysis.R")
knitr::purl("04-visualisation.Rmd", "scripts/04-visualisation.R")

knitr::knit_global("./00-outline.Rmd")


rmd_files <- list.files(pattern=".Rmd", recursive=TRUE, full.names=TRUE)

source_fn <- function(x) {
  source(x, local = knitr::knit_global())
}
purrr::map(rmd_files,source_fn)

purrr::map(source_fn,rmd_files)
