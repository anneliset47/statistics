FROM rocker/r-ver:4.4.1

WORKDIR /app

COPY . /app

RUN Rscript scripts/install_packages.R

CMD ["bash", "-lc", "make analyze"]
