---
output: html_document
editor_options: 
  chunk_output_type: console
---



# (PART\*) 환경설정 {#tm-setup .unnumbered}


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

## 색상 {#tm-colors}

### 콘솔 색상 {#console-colors}

[`glue`](https://glue.tidyverse.org/) 패키지 `glue_col()` 함수를 사용하게 되면 
텍스트에 색상을 입히는 작업을 간단하게 실행에 옮길 수 있다.


```r
library(glue)
library(crayon)

glue_col("{blue 1 + 2 = {red 1 + 2}}")
```

<pre class="r-output"><code>## <span style='color: #0000BB;'>1 + 2 = </span><span style='color: #BB0000;'>1 + 2</span>
</code></pre>


### R마크다운 색상 {#rmarkdown-colors}

`.Rmd` R마크다운 파일 작업결과에 색상을 입히기 위해서는 
[`fansi`](https://cran.r-project.org/web/packages/fansi/index.html) 패키지가 필요하다.
R마크다운 코드 덩어리에 다음 사항을 추가하고 R마크다운 작업을 수행하면
자동으로 해당 색상을 `.html`, `.pdf`, `shiny` 결과물에 반영할 수 있다.


<pre>

```r
knitr::knit_hooks$set(output = function(x, options){
  paste0(
    '<pre class="r-output"><code>',
    fansi::sgr_to_html(x = htmltools::htmlEscape(x), warn = FALSE),
    '</code></pre>'
  )
})
```
</pre>

R마크다운 색상 적용에 대한 자세한 사항은 [rmarkdown and terminal colors](https://logfc.wordpress.com/2020/07/20/rmarkdown-and-terminal-colors/)를
참조한다.


### 데이터프레임 {#dataframe-color}

이를 확장하여 콘솔, R마크다운, 그리고 데이터프레임에도 색상을 적용하여
반영시킬 수 있다.


## 메카브(MeCab) 설치 {#install-stacks}

빠르면서 성능이 좋다고 알려진 메카드(MeCab) 형태소 분석기를 설치한다.

![MeCab 설치과정](images/install-mecab.png){width=100%}

### 맥 {#install-mecab-mac}

MeCab 설치과정은 가장먼저 MeCab 설치부터 시작한다. 일본에서 제작했기 때문에 
RMeCaB 패키지를 설치하면 일본어 형태소 분석 작업을 바로 시작할 수 있다.
한글을 형태소 분석하기 위해서는 은전한닢(mecab-ko)를 설치한 후에 R에서 사용할 수 있도록
개발중인 bitTA 패키지를 설치하면 된다.

#### MeCab 설치 {#install-mecab-mac-mecab}

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

#### RMeCab 설치 (생략) {#install-mecab-mac-rmecab}

[RMeCab](https://github.com/IshidaMotohiro/RMeCab) GitHub 저장소에 설치사항을
정리하여 보면 MeCab와 사전을 설치한 후에 `install.packages()` 에 RMeCab 패키지
저장소를 달리 지정하여 설치하면 된다.


```r
install.packages("RMeCab", repos = "https://rmecab.jp/R", type = "source") 

library(RMeCab)
res <- RMeCabC("すもももももももものうち")
unlist (res)
## 名詞     助詞     名詞     助詞     名詞     助詞     名詞 
## "すもも"     "も"   "もも"     "も"   "もも"     "の"   "うち" 
```

#### MeCab-ko 설치 {#install-mecab-mac-mecab-ko}

일본어 `MeCab` 설치과정과 동일하게 한국어 `MeCab-ko`를 설치한다. 

- Bitbucket [eunjeon/mecab-ko](https://bitbucket.org/eunjeon/mecab-ko/downloads/) 저장소에서 `mecab-ko` 최신버전을 다운로드 한다.
- Bitbucket [eunjeon/mecab-ko-dic](https://bitbucket.org/eunjeon/mecab-ko-dic/downloads/) 저장소에서 `mecab-ko-dic` 사전 최신버전을 다운로드 한다.


```bash
## MeCab-ko 설치 ------------
$ cd ~/Downloads
$ curl -fsSL 'https://bitbucket.org/eunjeon/mecab-ko/downloads/mecab-0.996-ko-0.9.2.tar.gz' -o mecab-0.996-ko-0.9.2.tar.gz
$ tar xzvf mecab-0.996-ko-0.9.2.tar.gz
$ cd mecab-0.996-ko-0.9.2
$ ./configure --with-charset=utf-8
$ make
$ sudo make install

## MeCab-ko-dic 사전 설치 ------------
$ cd ~/Downloads
$ curl -fsSL 'https://bitbucket.org/eunjeon/mecab-ko-dic/downloads/mecab-ko-dic-2.1.1-20180720.tar.gz' -o mecab-ko-dic-2.1.1-20180720.tar.gz
$ cd mecab-ko-dic-2.1.1-20180720
$ ./configure --with-charset=utf-8
$ make
$ sudo make install
```


### bitTA 설치 {#install-mecab-bitTA}



```r
## remotes::install_github("bit2r/bitTA")
## 
## library(bitTA)
## 
## morpho_mecab("아버지가 방에 들어가신다.")
## #>      NNG      NNG 
## #> "아버지"     "방"
```

### 리눅스

### 윈도우

[MeCab 설치 이슈](https://github.com/bit2r/bitTA/issues/5) 참조



```r
## library(bitTA)
## 
## morpho_mecab("아버지가 방에 들어가신다.")
```

## `ggplot` 글꼴 {#ggplot-font}

단어구름(worldcloud)를 사용해서 텍스트 시각화를 많이 한다.
[`ggwordcloud`](https://lepennec.github.io/ggwordcloud/index.html) 패키지는
`ggplot`에서 텍스트 단어구름을 자연스럽게 구현했다.
`ggwordcloud`에 내장된 전세계 **사랑** 이라는 단어가 `love_words_small` 데이터프레임으로 내장되어 있다. 이를 기본 글꼴을 사용해서 단어구름 시각화를 구현해보자.


```r
library(ggwordcloud)
library(tidyverse)

data("love_words_small")

love_words_small %>% 
  mutate(color = ifelse(word == "사랑", "blue", "gray50")) %>% 
  ggplot(aes(label = word, size = speakers, color = color)) +
    geom_text_wordcloud() +
    scale_size_area(max_size = 40) +
    theme_minimal() +
    scale_color_manual(values = c("blue", "gray50"))
```

<img src="01-setup_files/figure-html/wordcloud-sample-1.png" width="576" style="display: block; margin: auto;" />

글꼴을 다양한 방식으로 구현하면 좀더 미려한 워드 클라우드를 뽑아낼 수 있다. 가장 최근에 네이버에서 공개한 마루부리 글꼴을 워드 클라우드에 반영해보자.


1. [마루 부리 글꼴](https://hangeul.naver.com/maru) 다운로드
2. 압축을 풀어 해당 글꼴을 운영체제에 설치
3. `sysfonts` 패키지를 사용해서 R 글꼴로 등록
4. `showtext` 패키지 `showtext_auto()` 함수로 `ggplot`에 사용할 수 있도록 설정

다음 워드 클라우드를 통해 마루부리 글꼴이 잘 반영된 것이 확인되지만 다른 언어로 
표현된 글꼴을 마루부리 글꼴이 적절히 반영하지 않는 것도 확인된다.


```r
library(systemfonts)
library(sysfonts)
library(showtext)

# 글꼴이 설치된 경로 표시
font_paths() 
```

<pre class="r-output"><code>## [1] "C:\\Windows\\Fonts"
</code></pre>

```r
# 운영체제 등록된 글꼴을 R 글꼴로 등록
sysfonts::font_add(family = "MaruBuri", regular = 'MaruBuri-Regular.ttf')

# 마루부리 글꼴이 설치되었는지 확인
font_files() %>% tibble() %>% filter(str_detect(family, "Maru"))
```

<pre class="r-output"><code>## <span style='color: #555555;'># A tibble: 4 × 6</span>
##   path             file         family face  version ps_name
##   <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>            <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>        <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>  <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span> <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>   <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>  
## <span style='color: #555555;'>1</span> C:/Windows/Fonts MaruBuri-Bo… MaruB… Regu… Versio… MaruBu…
## <span style='color: #555555;'>2</span> C:/Windows/Fonts MaruBuri-Li… MaruB… Regu… Versio… MaruBu…
## <span style='color: #555555;'>3</span> C:/Windows/Fonts MaruBuri-Re… MaruB… Regu… Versio… MaruBu…
## <span style='color: #555555;'>4</span> C:/Windows/Fonts MaruBuri-Se… MaruB… Regu… Versio… MaruBu…
</code></pre>

```r
# ggplot에서 사용할 수 있도록 설정
showtext::showtext_auto()

love_words_small %>% 
  mutate(color = ifelse(word == "사랑", "blue", "gray50")) %>% 
  ggplot(aes(label = word, size = speakers, color = color)) +
    geom_text_wordcloud(family = "MaruBuri") +
    scale_size_area(max_size = 40) +
    theme_minimal() +
    scale_color_manual(values = c("blue", "gray50"))
```

<img src="01-setup_files/figure-html/wordcloud-sample-font-1.png" width="576" style="display: block; margin: auto;" />

상기 문제를 풀고자 글꼴이 필요한데 [구글 폰트](https://fonts.google.com/)에서 웹폰트를 가져와서 이를 워드 클라우드 작성에 활용해보자. `sysfonts` 패키지 `font_add_google()` 함수를 사용하면 R에서 바로 사용할 수 있는 글꼴을 바로 설치해주기 때문에 매우 편리하다.
다만, `Noto Serif KR` 글꼴은 한글과 한자, 영어는 문제가 없어 보이지만 다른 언어를 표현하는데 문제가 있음을 알 수 있다.


```r
sysfonts::font_add_google(name = "Noto Serif KR", family = "noto_serif")

showtext::showtext_auto()

love_words_small %>% 
  mutate(color = ifelse(word == "사랑", "blue", "gray50")) %>% 
  ggplot(aes(label = word, size = speakers, color = color)) +
    geom_text_wordcloud(family = "noto_serif") +
    scale_size_area(max_size = 40) +
    theme_minimal() +
    scale_color_manual(values = c("blue", "gray50"))
```

<img src="01-setup_files/figure-html/google-fonts-all-1.png" width="576" style="display: block; margin: auto;" />


