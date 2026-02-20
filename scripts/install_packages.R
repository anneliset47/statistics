required_packages <- c(
  "dplyr",
  "ggplot2",
  "readr",
  "broom",
  "purrr",
  "stringr",
  "tibble",
  "scales"
)

missing_packages <- setdiff(required_packages, rownames(installed.packages()))

if (length(missing_packages) > 0) {
  install.packages(missing_packages, repos = "https://cloud.r-project.org")
}

cat("Package installation complete.\n")
