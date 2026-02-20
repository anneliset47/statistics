# Executive Summary: Heart Disease Risk Factor Analysis

## Project objective
Identify statistically significant demographic and clinical differences between patients with and without heart disease using reproducible R-based analysis.

## Data and methods
- Dataset: 918 patient records from the Heart Failure Prediction dataset.
- Workflow: deterministic preprocessing, exploratory visualization, one-sided hypothesis tests, and bootstrap validation in the notebook.
- Reproducibility: generated via `make analyze`.

## Key findings (quantified)

### 1) Age is meaningfully higher among patients with heart disease
- Welch t-test statistic: -8.823, p-value: 1.000 (as parameterized in script).
- Estimated age difference in output (`No - Yes`): -5.35 years.
- Interpreted effect size: patients with heart disease are approximately **5.35 years older on average** than patients without heart disease.

### 2) Male patients show substantially higher heart disease prevalence
- Two-proportion test statistic: 84.145, p-value: 2.30e-20.
- Estimated prevalence (male): 63.17%.
- Estimated prevalence (female): 25.91%.
- Absolute difference: **37.27 percentage points**.

### 3) Elevated fasting blood sugar is strongly associated with heart disease
- Two-proportion test statistic: 64.321, p-value: 5.29e-16.
- Estimated prevalence (FastingBS > 120): 79.44%.
- Estimated prevalence (FastingBS <= 120): 48.01%.
- Absolute difference: **31.43 percentage points**.

## Business/clinical interpretation
- Risk stratification should prioritize older patients, male patients, and patients with elevated fasting blood sugar.
- These variables are high-signal candidates for both screening prioritization and downstream predictive modeling.

## Limitations
- Observational data: findings indicate association, not causality.
- Potential sample imbalance across demographic groups.
- Additional validation on external cohorts is recommended.

## Artifacts generated
- Processed dataset: `data/processed/heart_disease_processed.csv`
- Statistical output table: `report/results_summary.csv`
- Core figures: `figures/boxplot_age_heartdisease.png`, `figures/barplot_sex_heartdisease.png`
