R_SCRIPT=Rscript

.PHONY: install prepare analyze clean

install:
	$(R_SCRIPT) scripts/install_packages.R

prepare:
	$(R_SCRIPT) scripts/prepare_data.R

analyze: prepare
	$(R_SCRIPT) scripts/run_analysis.R

clean:
	rm -f data/processed/heart_disease_processed.csv
	rm -f report/results_summary.csv
