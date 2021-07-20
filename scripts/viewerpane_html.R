viewerpane_html <- function(xfile, vsize=NULL){
  # Function: viewerpane.html version 1.00 23July2018
  # Purpose: view RMarkdown Knit-generated html file in RStudio Viewer pane
  # Status: Dev/Test
  # Args:
  # xfile = quoted name of html file (and path if not located in current directory)
  # vsize = viewer arg height, default=NULL; alt values: "maximize", or numeric {3 to 8}
  # Example: x <- "RMD-Demo-Viridis-002x.html"
  # References:
  # 1. https://rstudio.github.io/rstudio-extensions/rstudio_viewer.html
  # 2. https://rstudio.github.io/rstudio-extensions/pkgdown/rstudioapi/reference/viewer.html
  # 3. https://rstudio.github.io/rstudio-extensions/rstudioapi.html
  #
  # library(rstudioapi)
  xfile.b <- basename(xfile)
  tempDir <- tempfile()
  dir.create(tempDir)
  htmlFile <- file.path(tempDir, xfile.b)
  # (code to write some content to the file) -- see next line
  file.copy(xfile, htmlFile)
  viewer <- getOption("viewer")
  viewer(htmlFile, height  = vsize)
}