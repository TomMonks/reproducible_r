# Use publicly available rocker/rstudio image - rocker is the r docker project https://rocker-project.org
FROM rocker/tidyverse:latest

# set the working directory to the container make copy simpler
WORKDIR /home/rstudio

ENV RENV_VERSION 0.16.0
RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"

# Copy all files across to container
COPY renv.lock renv.lock

# renv autoloader tools
# approach one
ENV RENV_PATHS_LIBRARY renv/library

# copy over the r - script + readme + license
COPY LICENSE LICENSE
COPY README.md README.md
COPY test_script.R test_script.R
COPY deps.R deps.R

# restore the renv environment 
RUN R -e "renv::restore()"
