## 기본설정 -----------------
set.seed(7654)
options(digits = 3)

knitr::opts_chunk$set(
  echo = TRUE,
  message = FALSE,
  warning = FALSE,
  cache = FALSE,
  #dpi = 105, # not sure why, but need to divide this by 2 to get 210 at 6in, which is 300 at 4.2in
  fig.align = 'center',
  fig.width = 6,
  fig.asp = 0.618,  # 1 / phi
  fig.show = "hold"
)

options(dplyr.print_min = 6, dplyr.print_max = 6)

## 색상 ----------------------
knitr::knit_hooks$set(output = function(x, options){
  paste0(
    '<pre class="r-output"><code>',
    fansi::sgr_to_html(x = htmltools::htmlEscape(x), warn = FALSE),
    '</code></pre>'
  )
})

library(crayon)
library(fansi)
options(crayon.enabled = TRUE)



################################################################################
# 데이터베이스
################################################################################

# 0. 환경설정 -----------------------

library(DBI)
library(tidyverse)
extrafont::loadfonts()
