---
output: html_document
editor_options: 
  chunk_output_type: console
---


```r
source("_common.R")
```

```
## ── [1mAttaching packages[22m ─────────────────────────────────────── tidyverse 1.3.1 ──
```

```
## [32m✔[39m [34mggplot2[39m 3.3.6     [32m✔[39m [34mpurrr  [39m 0.3.4
## [32m✔[39m [34mtibble [39m 3.1.7     [32m✔[39m [34mdplyr  [39m 1.0.9
## [32m✔[39m [34mtidyr  [39m 1.2.0     [32m✔[39m [34mstringr[39m 1.4.0
## [32m✔[39m [34mreadr  [39m 2.1.2     [32m✔[39m [34mforcats[39m 0.5.1
```

```
## ── [1mConflicts[22m ────────────────────────────────────────── tidyverse_conflicts() ──
## [31m✖[39m [34mggplot2[39m::[32m%+%()[39m  masks [34mcrayon[39m::%+%()
## [31m✖[39m [34mdplyr[39m::[32mfilter()[39m masks [34mstats[39m::filter()
## [31m✖[39m [34mdplyr[39m::[32mlag()[39m    masks [34mstats[39m::lag()
```

```r
knitr::knit_hooks$set(output = function(x, options){
  paste0(
    '<pre class="r-output"><code>',
    fansi::sgr_to_html(x = htmltools::htmlEscape(x), warn = FALSE),
    '</code></pre>'
  )
})
```

# 설치 및 환경설정 {#install-setup}

즐거운 텍스트 마이닝(Text Mining) 작업환경을 구축하기 위해서는 몇가지 
환경이 구비되어야만 한다. 먼저 작업할 데이터가 텍스트이기 때문에 텍스트에서 
특정 단어 색상을 달리하는 것은 추후 딥러닝 질의응답 인공지능 시스템을 구축할 때
딥러닝 시스템이 질의에 대한 답변을 전체 텍스트의 일부를 색상을 달리하여 
시각적으로 표현하게 되면 사용자 편의성이 크게 개선시킬 수 있다.

텍스트 색상을 달리할 경우 크게 두가지 부분이 이슈가 된다. 첫번째는 텍스트 마이닝
콘솔 작업할 때 코드와 R 코드로 작업한 결과물을 출력할 때 색상을 차별화하는 것이고,
다른 하나는 텍스트 마이닝 결과를 데이터 과학 제품으로 출력할 때 색상을 달리하여
웹상으로 표현하는 것이다.

## 콘솔 색상 {#console-colors}

[`glue`](https://glue.tidyverse.org/) 패키지 `glue_col()` 함수를 사용하게 되면 
텍스트에 색상을 입히는 작업을 간단하게 실행에 옮길 수 있다.


```r
library(glue)
library(crayon)

glue_col("{blue 1 + 2 = {red 1 + 2}}")
```

<pre class="r-output"><code>## <span style='color: #0000BB;'>1 + 2 = </span><span style='color: #BB0000;'>1 + 2</span>
</code></pre>


## R마크다운 색상 {#rmarkdown-colors}

`.Rmd` R마크다운 파일 작업결과에 색상을 입히기 위해서는 
[`fansi`](https://cran.r-project.org/web/packages/fansi/index.html) 패키지가 필요하다.
R마크다운 코드 덩어리에 다음 사항을 추가하고 R마크다운 작업을 수행하면
자동으로 해당 색상을 `.html`, `.pdf`, `shiny` 결과물에 반영할 수 있다.

<!-- ````markdown -->
<!-- ```{r setup} -->
<!-- knitr::knit_hooks$set(output = function(x, options){ -->
<!--   paste0( -->
<!--     '<pre class="r-output"><code>', -->
<!--     fansi::sgr_to_html(x = htmltools::htmlEscape(x), warn = FALSE), -->
<!--     '</code></pre>' -->
<!--   ) -->
<!-- }) -->
<!-- ``` -->
<!-- ```` -->

<!-- R마크다운 색상 적용에 대한 자세한 사항은 [rmarkdown and terminal colors](https://logfc.wordpress.com/2020/07/20/rmarkdown-and-terminal-colors/)를  -->
<!-- 참조한다. -->


<!-- ## 데이터프레임 {#dataframe-color} -->

<!-- 이를 확장하여 콘솔, R마크다운, 그리고 데이터프레임에도 색상을 적용하여  -->
<!-- 반영시킬 수 있다. -->


# 메카브(MeCab) 설치 {#install-stacks}

빠르면서 성능이 좋다고 알려진 메카드(MeCab) 형태소 분석기를 설치한다.

![MeCab 설치과정](images/install-mecab.png)

## 맥 {#install-mecab-mac}

MeCab 설치과정은 가장먼저 MeCab 설치부터 시작한다. 일본에서 제작했기 때문에 
RMeCaB 패키지를 설치하면 일본어 형태소 분석 작업을 바로 시작할 수 있다.
한글을 형태소 분석하기 위해서는 은전한닢(mecab-ko)를 설치한 후에 R에서 사용할 수 있도록
개발중인 bitTA 패키지를 설치하면 된다.

### MeCab 설치 {#install-mecab-mac-mecab}

GitHub [Installation of RMeCab 1.07 on M1 Mac #13](https://github.com/IshidaMotohiro/RMeCab/issues/13) 에 자세한 사항이 나와 있지만 간략하게 정리하면 다음과 같다.


```bash
## xcode 설치되면 생략 ----- 
$ xcode-select --install

## MeCab 설치 --------------
$ cd ~/Downloads
$ curl -fsSL 'https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7cENtOXlicTFaRUE'  -o mecab-0.996.tar.gz
$ tar xf mecab-0.996.tar.gz
$ cd mecab-0.996
$ ./configure --with-charset=utf8
$ make
$ sudo make install

## MeCab 사전 설치 --------------
$ cd ~/Downloads
$ curl -fsSL 'https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7MWVlSDBCSXZMTXM'  -o mecab-ipadic-2.7.0-20070801.tar.gz
$ tar zvxf mecab-ipadic-2.7.0-20070801.tar.gz
$ tar xf mecab-ipadic-2.7.0-20070801.tar.gz
$ cd mecab-ipadic-2.7.0-20070801
$ ./configure --with-charset=utf-8
$ make
$ sudo make install

## MeCab 설치 테스트 --------------
$ mecab
すもももももももものうち
```

### RMeCab 설치 (생략) {#install-mecab-mac-rmecab}

[RMeCab](https://github.com/IshidaMotohiro/RMeCab) GitHub 저장소에 설치사항을
정리하여 보면 MeCab와 사전을 설치한 후에 `install.packages()` 에 RMeCab 패키지
저장소를 달리 지정하여 설치하면 된다.


```r
install.packages("RMeCab", repos = "https://rmecab.jp/R", type = "source") 

library(RMeCab)
res <- RMeCabC("すもももももももものうち")
unlist (res)
# 名詞     助詞     名詞     助詞     名詞     助詞     名詞 
# "すもも"     "も"   "もも"     "も"   "もも"     "の"   "うち" 
```

### MeCab-ko 설치 {#install-mecab-mac-mecab-ko}

일본어 `MeCab` 설치과정과 동일하게 한국어 `MeCab-ko`를 설치한다. 

- Bitbucket [eunjeon/mecab-ko](https://bitbucket.org/eunjeon/mecab-ko/downloads/) 저장소에서 `mecab-ko` 최신버전을 다운로드 한다.
- Bitbucket [eunjeon/mecab-ko-dic](https://bitbucket.org/eunjeon/mecab-ko-dic/downloads/) 저장소에서 `mecab-ko-dic` 사전 최신버전을 다운로드 한다.


```bash
# MeCab-ko 설치 ------------
$ cd ~/Downloads
$ curl -fsSL 'https://bitbucket.org/eunjeon/mecab-ko/downloads/mecab-0.996-ko-0.9.2.tar.gz' -o mecab-0.996-ko-0.9.2.tar.gz
$ tar xzvf mecab-0.996-ko-0.9.2.tar.gz
$ cd mecab-0.996-ko-0.9.2
$ ./configure --with-charset=utf-8
$ make
$ sudo make install

# MeCab-ko-dic 사전 설치 ------------
$ cd ~/Downloads
$ curl -fsSL 'https://bitbucket.org/eunjeon/mecab-ko-dic/downloads/mecab-ko-dic-2.1.1-20180720.tar.gz' -o mecab-ko-dic-2.1.1-20180720.tar.gz
$ cd mecab-ko-dic-2.1.1-20180720
$ ./configure --with-charset=utf-8
$ make
$ sudo make install
```


### bitTA 설치 {#install-mecab-bitTA}



```r
remotes::install_github("bit2r/bitTA")

library(bitTA)

morpho_mecab("아버지가 방에 들어가신다.")
#>      NNG      NNG 
#> "아버지"     "방"
```



## 윈도우

[MeCab 설치 이슈](https://github.com/bit2r/bitTA/issues/5) 참조



```r
library(bitTA)

morpho_mecab("아버지가 방에 들어가신다.")
```


