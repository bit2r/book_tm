library(tidyverse)
library(tidytext)
# # remotes::install_github("IshidaMotohiro/RMeCab", force = TRUE)
library(RMeCab)
# remotes::install_github("bit2r/bitTA")
library(bitTA)

library(glue)
library(crayon)

yoon_txt <- read_lines("data/취임사_윤석열.txt")

crayon_words <- function(input_text, word = "자유") {

  replaced_text <- str_replace_all(input_text, word, "{red {word}}")

  for(i in 1:length(replaced_text)) {
    crayon_text <- glue::glue_col(deparse(replaced_text[[i]]))
    print(crayon_text)
  }
}

crayon_words(input_text = yoon_txt, "자유")
