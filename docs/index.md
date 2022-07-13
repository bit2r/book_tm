--- 
title: "R 텍스트마이닝"
author: "한국 R 사용자회"
date: "2022-07-13"
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
github-repo: rstudio/bookdown-demo
description: "데이터 사이언스 언어 R 텍스트마이닝"
---

# 들어가며 {-}

## 머리말




## 구성

텍스트마이닝에 필요한 R의 기초, 분석의 전단계, 그리고 분석 등으로 구성돼 있다. R에 익숙하면 곧바로 분석 전단계인 "4. 틀잡기"부터 시작해도 된다. 


#### R기초

R의 설치, 데이터유형과 구조, 시각화의 기초적인 내용과 R과 RStudio를 이용하는 과정에서 겪을 수 있는 문제해결 방법에 대해 다뤘다. 

1. 도입
2. 준비1
3. 준비2

#### 분석 전단계

텍스트마이닝의 전반적인 구조와 자료 수집과 불러오기, 정제(전처리)에 필요한 다양한 도구(stringr, dplyr, tidyr, purrr, regex 등)의 학습 및 정제(전처리)하는 방법에 대해 학습한다.

4. 틀잡기
5. 수집: 불러오기
6. 정제도구
7. 정제(전처리)

#### 분석 I

단어의 빈도를 계산해 텍스트에서 의미를 추론하는 방식을 학습한다. 사전(감정사전)을 이용하는 방법, 상대적인 빈도(tf-idf, 가중로그승산비 등)를 계산하는 방법, 기계학습의 비지도학습(주제모형: topic models)으로 계산하는 방법 등을 학습한다. 

8. 분석1: 감정어 빈도
9. 분석2: 상대빈도
10. 분석3: 주제모형1
11. 분석4: 주제모형(공변인)


#### 분석 II (예정)

기계학습의 지도학습 방식에 대해 학습한다. 

12. 지도학습1
13. 지도학습2
14. 딥러닝1
15. 딥러닝2



## 도움받은 자료

[R for Data Science](https://r4ds.had.co.nz)  by Hadley Wickam and Garrett Grolermund

[Text Mining with R](https://www.tidytextmining.com)  by Julia Silge and David Robinson

[Supervised Machine Learning for Text Analysis in R](https://smltar.com/) by EMIL HVITFELDT AND JULIA SILGE

[Doit_textmining](https://youngwoos.github.io/Doit_textmining/) by 김영우 

[데이터과학입문](https://statkclee.github.io/ds-intro-2020/) by statkclee

[데이터사이언스 스쿨](https://datascienceschool.net) by ratsgo

[R을 이용한 퀀트 투자 포트폴리오 만들기](https://hyunyulhenry.github.io/quant_cookbook/) by 이현열 

[Speech and Language Processing (3rd ed. draft)](https://web.stanford.edu/~jurafsky/slp3/)

[QUANTEDA TUTORIALS]([https://tutorials.quanteda.io/)

[Bilogical Data Science Workshops](https://stephenturner.github.io/workshops/index.html)

[Jenny Bryan’s Stat 545 course](https://stat545.com)

[Carpentries](https://carpentries.org)
[Software Carpentry](https://software-carpentry.org)
[Data Carpentry](https://datacarpentry.org)








![](images/by-nc-sa.png)

The online version of this book is licensed under the [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International  License](http://creativecommons.org/licenses/by-nc-sa/4.0/).
