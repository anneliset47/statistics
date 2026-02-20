# Heart Disease Risk Factor Analysis (R)

Portfolio-ready statistical analysis project that investigates clinical and demographic drivers of heart disease using reproducible R workflows.

## Why this project matters

This repository demonstrates applied statistical analysis skills in a realistic healthcare context:
- end-to-end data preparation,
- exploratory analysis and visualization,
- formal hypothesis testing,
- reproducible project execution.

The core outcome is a transparent, recruiter-reviewable pipeline from raw data to interpretable statistical results.

## Dataset

- Source: [Kaggle – Heart Failure Prediction](https://www.kaggle.com/datasets/fedesoriano/heart-failure-prediction)
- Observations: 918 patients
- Target variable: `HeartDisease` (No/Yes)
- Key predictors: `Age`, `Sex`, `ChestPainType`, `RestingBP`, `Cholesterol`, `FastingBS`, `ExerciseAngina`, `MaxHR`

## Project structure

```
data/
	raw/heart_disease_data.csv
	processed/heart_disease_processed.csv
figures/
notebooks/
	heart_disease_analysis.ipynb
report/
	heart_disease_statistical_report.pdf
	analysis_summary.md
	results_summary.csv
scripts/
	install_packages.R
	prepare_data.R
	run_analysis.R
Makefile
Dockerfile
```

## Reproducibility quickstart

### Option 1: Local R (recommended)

Prerequisites:
- R 4.2+
- `Rscript` available in PATH

Run from repository root:

```bash
make install
make analyze
```

This will:
1. install required R packages,
2. create processed data,
3. generate key figures,
4. export statistical test results to `report/results_summary.csv`.

### Option 2: Containerized run

```bash
docker build -t heart-disease-risk .
docker run --rm -v "$PWD":/app heart-disease-risk
```

## Analysis approach

- Deterministic preprocessing with explicit factor encoding and median imputation for zero-coded physiologic values.
- Exploratory plots focused on disease prevalence and age distributions.
- Hypothesis tests:
	- One-sided two-sample t-test (Age by disease status)
	- One-sided two-proportion tests (Sex and FastingBS risk differences)
- Bootstrap confidence interval estimation in the notebook for robustness checks.

## Deliverables

- Main analysis notebook: `notebooks/heart_disease_analysis.ipynb`
- Processed dataset: `data/processed/heart_disease_processed.csv`
- Figure artifacts: `figures/`
- Statistical results table: `report/results_summary.csv`

## Professional highlights

- Clear project narrative and assumptions
- Scripted, repeatable pipeline (`make analyze`)
- Notebook + scripted execution path for reviewer convenience
- Container option for consistent execution across environments

## Notes and limitations

- Observational data supports association, not causation.
- Class and demographic imbalance may influence effect-size interpretation.
- Results should be treated as analytic evidence, not diagnostic guidance.

## License

This project is available under the terms in `LICENSE`.
