suppressPackageStartupMessages({
  library(dplyr)
  library(ggplot2)
  library(readr)
  library(broom)
  library(scales)
  library(tibble)
})

processed_data_path <- file.path("data", "processed", "heart_disease_processed.csv")
figures_dir <- "figures"
results_path <- file.path("report", "results_summary.csv")

if (!file.exists(processed_data_path)) {
  stop("Processed data missing. Run scripts/prepare_data.R first.")
}

dir.create(figures_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(dirname(results_path), recursive = TRUE, showWarnings = FALSE)

heart <- readr::read_csv(processed_data_path, show_col_types = FALSE)

plot_age <- ggplot(heart, aes(x = HeartDisease, y = Age, fill = HeartDisease)) +
  geom_boxplot(alpha = 0.8, width = 0.6) +
  labs(title = "Age Distribution by Heart Disease Status", x = NULL, y = "Age (years)") +
  theme_minimal(base_size = 12) +
  theme(legend.position = "none")

plot_sex <- heart %>%
  count(Sex, HeartDisease) %>%
  group_by(Sex) %>%
  mutate(prop = n / sum(n)) %>%
  ggplot(aes(x = Sex, y = prop, fill = HeartDisease)) +
  geom_col(position = "fill") +
  scale_y_continuous(labels = scales::percent_format()) +
  labs(title = "Heart Disease Prevalence by Sex", y = "Proportion", x = NULL) +
  theme_minimal(base_size = 12)

ggsave(file.path(figures_dir, "boxplot_age_heartdisease.png"), plot_age, width = 7, height = 4, dpi = 300)
ggsave(file.path(figures_dir, "barplot_sex_heartdisease.png"), plot_sex, width = 7, height = 4, dpi = 300)

h1_age_ttest <- t.test(Age ~ HeartDisease, data = heart, alternative = "greater")
h2_sex_prop <- prop.test(
  x = c(sum(heart$Sex == "Male" & heart$HeartDisease == "Yes"), sum(heart$Sex == "Female" & heart$HeartDisease == "Yes")),
  n = c(sum(heart$Sex == "Male"), sum(heart$Sex == "Female")),
  alternative = "greater"
)
h3_fbs_prop <- prop.test(
  x = c(sum(heart$FastingBS == ">120" & heart$HeartDisease == "Yes"), sum(heart$FastingBS == "<=120" & heart$HeartDisease == "Yes")),
  n = c(sum(heart$FastingBS == ">120"), sum(heart$FastingBS == "<=120")),
  alternative = "greater"
)

results <- bind_rows(
  broom::tidy(h1_age_ttest) %>% mutate(test = "Age t-test"),
  broom::tidy(h2_sex_prop) %>% mutate(test = "Sex proportion test"),
  broom::tidy(h3_fbs_prop) %>% mutate(test = "FastingBS proportion test")
) %>%
  select(test, statistic, p.value, conf.low, conf.high, estimate, estimate1, estimate2, method, alternative)

readr::write_csv(results, results_path)
cat(sprintf("Analysis complete. Results written to %s\n", results_path))
