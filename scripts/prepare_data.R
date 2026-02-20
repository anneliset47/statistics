suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
})

raw_data_path <- file.path("data", "raw", "heart_disease_data.csv")
processed_data_path <- file.path("data", "processed", "heart_disease_processed.csv")

if (!file.exists(raw_data_path)) {
  stop(sprintf("Raw data not found: %s", raw_data_path))
}

heart <- readr::read_csv(raw_data_path, show_col_types = FALSE) %>%
  mutate(
    Sex = factor(Sex, levels = c("F", "M"), labels = c("Female", "Male")),
    ChestPainType = factor(ChestPainType),
    RestingECG = factor(RestingECG),
    ExerciseAngina = factor(ExerciseAngina, levels = c("N", "Y"), labels = c("No", "Yes")),
    ST_Slope = factor(ST_Slope),
    FastingBS = factor(FastingBS, levels = c(0, 1), labels = c("<=120", ">120")),
    HeartDisease = factor(HeartDisease, levels = c(0, 1), labels = c("No", "Yes"))
  )

numeric_cols <- c("Age", "RestingBP", "Cholesterol", "MaxHR", "Oldpeak")
heart <- heart %>%
  mutate(across(all_of(numeric_cols), ~ ifelse(.x == 0, NA_real_, .x))) %>%
  mutate(across(all_of(numeric_cols), ~ ifelse(is.na(.x), median(.x, na.rm = TRUE), .x)))

dir.create(dirname(processed_data_path), recursive = TRUE, showWarnings = FALSE)
readr::write_csv(heart, processed_data_path)

cat(sprintf("Processed data written to %s\n", processed_data_path))
