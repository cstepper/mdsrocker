#!/bin/bash

set -e

# always set this for scripts but don't declare as ENV.
export DEBIAN_FRONTEND=noninteractive

# build ARGs
NCPUS=${NCPUS:--1}

# a function to install apt packages only if they are not installed
function apt_install() {
  if ! dpkg -s "$@" >/dev/null 2>&1; then
  if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
  apt-get -qq update
  fi
  apt-get install -y --no-install-recommends "$@"
  fi
}

# install system requirements
apt_install \
  git \
  libcurl4-openssl-dev \
  libfontconfig1-dev \
  libfreetype6-dev \
  libfribidi-dev \
  libharfbuzz-dev \
  libicu-dev \
  libjpeg-dev \
  libpng-dev \
  libssl-dev \
  libtiff-dev \
  libxml2-dev \
  make \
  pandoc

# install binary R packages
install2.r --error --skipinstalled -n $NCPUS \
  sys \
  askpass \
  R6 \
  mime \
  jsonlite \
  lazyeval \
  yaml \
  withr \
  crayon \
  rex \
  digest \
  magrittr \
  rlang \
  later \
  Rcpp \
  fastmap \
  base64enc \
  htmltools \
  promises \
  jquerylib \
  crosstalk \
  htmlwidgets \
  DT \
  glue \
  xfun \
  highr \
  evaluate \
  ps \
  rprojroot \
  cli \
  processx \
  desc \
  callr \
  xmlparsedata \
  backports \
  utf8 \
  vctrs \
  pkgconfig \
  pillar \
  lifecycle \
  fansi \
  rappdirs \
  memoise \
  cachem \
  tinytex \
  cpp11 \
  brio \
  whisker \
  tibble \
  purrr \
  downlit \
  prettyunits \
  xopen \
  sessioninfo \
  pkgbuild \
  tinytest

# install source R packages
install2.r --error --skipinstalled -n $NCPUS -r https://packagemanager.rstudio.com/cran/latest \
  openssl \
  curl \
  httr \
  covr \
  stringi \
  stringr \
  remotes \
  xml2 \
  knitr \
  cyclocomp \
  lintr \
  fs \
  sass \
  bslib \
  textshaping \
  systemfonts \
  rmarkdown \
  ragg \
  pkgdown \
  rcmdcheck

# clean up
rm -rf /var/lib/apt/lists/*
rm -r /tmp/downloaded_packages

## Strip binary installed lybraries from RSPM
## https://github.com/rocker-org/rocker-versioned2/issues/340
strip /usr/local/lib/R/site-library/*/libs/*.so
