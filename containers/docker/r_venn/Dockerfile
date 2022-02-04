# Parent image (first layer)
FROM rocker/r-ver:3.6.3

# Install R/Bioconductor packages
RUN Rscript -e 'install.packages("VennDiagram", repos="http://cran.us.r-project.org")'

# Copy local script to image
RUN mkdir -p /scripts
COPY ./do_venn.R /scripts/do_venn.R

# Working directory
WORKDIR /scripts

# Output and Input volumes
VOLUME /output
VOLUME /input
