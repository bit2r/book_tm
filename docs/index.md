--- 
title: "R 텍스트마이닝"
author: "한국 R 사용자회"
date: "2022-08-02"
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

---

사단법인 한국 알(R) 사용자회는 디지털 불평등 해소와 통계 대중화를 위해 
2022년 설립되었습니다. 오픈 통계 패키지 개발을 비롯하여
최근에 데이터 사이언스 관련 교재도 함께 제작하여 발간하는 작업을 수행하고 있습니다.
그 첫번째 결과물로 John Fox 교수님이 개발한 설치형 오픈 통계 패키지 `Rcmdr`[@fox2016using] [@rcmdr2022manual] [@rcmdr2005paper] 를 신종화 님께서 한글화 및 문서화에 10년 넘게 기여해주신 한국알사용자회 저작권을 흔쾌히 
허락해 주셔서 [설치형 오픈 통계 패키지 - `Rcmdr`](https://r2bit.com/Rcmdr/)로 세상에 나왔습니다.

두번째 활동을 여기저기 산재되어 있던 시각화 관련 자료를 묶어
**[데이터 시각화(Data Visualization)](https://r2bit.com/book_viz/)**를 전자책 형태로 공개하였고,
데이터 분석 관련 저술을 이어 진행하게 되었습니다.

세번째 활동으로 데이터 사이언스가 하나로 구성되지 않은 것을 간파하고
데이터 사이언스를 지탱하는 기본기술을 5가지로 정리한 
**[데이터 과학을 지탱하는 기본기](https://r2bit.com/book_analytics/)** 전자책을 
공개했습니다.

네번째 활동으로 데이터 과학이 이제는 R 혹은 파이썬 언어가 중요한 것이 아니라
데이터 과학 문제 해결에 집중한 **[데이터 과학 프로그래밍](https://r2bit.com/book_programming/)**
전자책을 공개했습니다. "데이터 과학 프로그래밍" 저작을 위해 ["Python for Everybody"](https://www.py4e.com/book)와 
[Python for Informatics: Exploring Information](http://www.py4inf.com/)에 기반하여
2015년부터 시작된 [모두를 위한 파이썬](http://aispiration.com/pythonlearn-kr/) 한글화
프로젝트가 밑바탕이 되었습니다.

데이터 분석 언어 R에 관한 지식을 신속히 습득하여 독자들이 갖고 있는 문제에 
접목시키고자 하시는 분은 한국 알(R) 사용자회에서 번역하여 공개한 
[R 신병훈련소(Bootcamp)](https://dl-dashboard.shinyapps.io/rbootcamp/) 과정을
추천드립니다.

---

"R 텍스트 마이닝" 전자책은 한국 R 사용자회와 제주대학교 제주대학교 언론홍보학과 
**안도현** 교수님이 공동 작업한 저작물로 건강한 R 생태계 확대에 크게 
기여할 것으로 기대됩니다. 안도현 교수님의 [R로 배우는 텍스트마이닝](http://text.minds.kr/) 
콘텐츠를 기반으로 한국 R 사용자회는 텍스트 분석/마이닝 전용
[bitTA](https://github.com/bit2r/bitTA) 패키지를 개발하여 
2022년 현재 시점 한국어 텍스트 분석의 새로운 여정을 시작하였습니다.

- [R로 배우는 텍스트마이닝 - 전자책](http://text.minds.kr/) 
- [R로 배우는 텍스트마이닝 - GitHub 저장소](https://github.com/dataminds/textminds)

"R 텍스트마이닝" 저작물을 포함한 한국 알(R) 사용자회 저작물은 크리에이티브 커먼즈 
[저작자표시-비영리-동일조건 변경 허락 (BY-NC-SA)](http://ccl.cckorea.org/about/)
라이선스를 준용하고 있습니다. 


The online version of this book is licensed under the [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International  License](http://creativecommons.org/licenses/by-nc-sa/4.0/).


<p align="center">
  <img src="images/by-nc-sa.png" alt="CC" width="25%" />
</p>

관련 문의와 연락이 필요한 경우 한국 알(R) 사용자회 admin@r2bit.com 대표전자우편으로 연락주세요.

---

::: {#book-sponsor .rmdtip}
**후원계좌**

디지털 불평등 해소를 위해 제작중인 오픈 통계패키지 개발과 고품질 콘텐츠 제작에 큰 힘이 됩니다.

  - 하나은행 448-910057-06204
  - 사단법인 한국알사용자회
:::


## 구성


텍스트 마이닝에 필요한 R의 기초, 분석의 전단계, 그리고 분석 등으로 구성돼 있다. 
R에 익숙하면 곧바로 텍스트 분석에 필수 기초지식인 "자료구조"부터 시작할 것을 권장한다.

### R기초

R의 설치, 데이터유형과 구조, 시각화의 기초적인 내용과 R과 RStudio를 이용하는 과정에서 겪을 수 있는 문제해결 방법에 대해 다뤘다. 

### 분석 전단계

텍스트마이닝의 전반적인 구조와 자료 수집과 불러오기, 정제(전처리)에 필요한 다양한 도구(stringr, dplyr, tidyr, purrr, regex 등)의 학습 및 정제(전처리)하는 방법에 대해 학습한다.

### 분석 I

단어의 빈도를 계산해 텍스트에서 의미를 추론하는 방식을 학습한다. 사전(감정사전)을 이용하는 방법, 상대적인 빈도(tf-idf, 가중로그승산비 등)를 계산하는 방법, 기계학습의 비지도학습(주제모형: topic models)으로 계산하는 방법 등을 학습한다. 

### 분석 II (예정)

기계학습의 지도학습 방식에 대해 학습한다. 

