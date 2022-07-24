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


R문서/그래프/코딩 글꼴(font)을 바꾸고 싶을 때가 있다. 
자세한 사항은 [데이터 시각화 - R 문서/그래프/코딩 글꼴(font)](https://statkclee.github.io/viz/viz-r-font.html)
문서를 참조한다.


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


## `spacyr`

표제어 추출에 사용하는 패키지는 `spacyr`이다. [사용자설명서](https://cran.r-project.org/web/packages/spacyr/vignettes/using_spacyr.html)

### 미니콘다 설치

(아나콘다 혹은 미니콘다가 이미 컴퓨터에 설치돼 있으면 곧바로 `spacyr` 패키지 설치로 이동) 

`spacyr`은 파이썬 `spaCy`패키지를 R에서 사용할 수 있도록한 패키지이므로, `spacyr`을 이용하기 위해서는 컴퓨터에 파이썬과 필요한 패키지가 설치돼 있어야 한다. 파이썬과 자주사용하는 패키지를 한번에 설치할 수 있는 것이 아나콘다와 미니콘다이다. 

 - 아나콘다: 파이썬 + 자주 사용하는 패키지 1500여개 설치(3GB 이상 설치공간 필요)
 - 미니콘다: 파이썬 + 필수 패키지 700여개 설치(260MB 설치공간 필요)
 ([미니콘다 설치 안내](https://docs.conda.io/en/latest/miniconda.html))
 
미니콘다 설치 안내 페이지에서 본인의 운영체제에 맞는 파일을 선택해 컴퓨터에 설치한다. 관리자권한으로 설치한다 (다운로드받은 파일에 마우스커서 올려 놓고 오른쪽 버튼 클릭해 '관리자권한으로 실행' 선택)

설치후 Anaconda Prompt를 연다. 

 - 윈도화면 왼쪽 아래의 `시작`버튼을 클릭하면 윈도 시작 메뉴가 열린다. 상단 '최근에 추가한 앱'에서 Anaconda Prompt(Miniconda 3)을 클릭하면 Anaconda Prompt가 열린다. (Anaconda Powershell Prompt를 이용해도 된다) 

프롬프트가 열리면 `conda --version`을 입력한다. `conda 4.9.2`처럼 콘다의 버전 정보가 뜨면 설치에 성공. 

### `spacyr` 패키지 설치

`spacyr` 패키지를 설치하고 구동한다. (패키지 설치할 때는 R이나 RStudio를 관리자 권한으로 실행해 설치한다.)


```r
install.packages("spacyr")
library(spacyr)
```

패키지를 설치하고 구동했으면 `spacy_install()`을 실행한다. 콘솔에 Proceed여부를 묻는 화면이 나면 `2: Yes`를 선택해 진행한다. 


```r
spacy_install()
```

```
Proceed? 

1: No
2: Yes

Selection: 2
A new conda environment "spacy_condaenv" will be created and 
spaCy and language model(s): en_core_web_sm will be installed.  Creating spacy_condaenv conda environment for spaCy installation...
Collecting package metadata (current_repodata.json): ...working... done
Solving environment: ...working... done

...

✔ Download and installation successful
You can now load the package via spacy.load('en_core_web_sm')
Language model "en_core_web_sm" is successfully installed


Installation complete.
Condaenv: spacy_condaenv; Language model(s): en_core_web_sm

```

`spacy_install()`은 시스템 파이썬(또는 아나콘다 파이썬)과는 별개로 R환경에서 파이썬을 실행할 수 있는 콘다환경이 생성된다. 

### `reticulate` 패키지 설치

파이썬 모듈을 R환경에서 실행할 수 있도록 하는 파이썬-R 인터페이스 패키지다. 


```r
install.packages("reticulate")
```


### `spacy_initialize()`

`spacy_initialize()`로 R에서 `spaCy`를 초기화한다. 


```r
library(spacyr)
spacy_initialize(model = "en_core_web_sm")
```


### 파이썬 설정 오류

과거에 파이썬을 설치했었거나 혹은 파이썬에 의존하는 R패키지를 설치했었던 경우 오류가 발생할 수있다. 

`spacy_initialize()`를 실행하면 아래와 같은 파이썬 설정 오류가 발생할 수 있다. 

```
spacy python option is already set, spacyr will use:
	condaenv = "spacy_condaenv"
ERROR: The requested version of Python
('C:\Users\[사용자ID]\AppData\Local\r-miniconda\envs\spacy_condaenv\python.exe')
cannot be used, as another version of Python
('새로 설치한 미니콘다 경로') has
already been initialized . Please restart the R
session if you need to attach reticulate to a
different version of Python.
Error in use_python(python, required = required) : 
  failed to initialize requested version of Python
```

`spacy_initialize()`함수가 파이썬을  `C:\Users\[사용자ID]\AppData\Local\r-miniconda\envs\spacy_condaenv\python.exe`에서 찾는다는 의미다. 

이 곳으로 파이썬 환경을 설정한다. 세 가지 방법이 있다. (이 위치는 사용자별로 파이썬이 설치된 환경에 따라 다르다.) 

#### RStudio에서 설정

1. RStudio의 `Tools` 메뉴 선택. 
2. 드롭다운 메뉴가 열리면, `Global Options` 선택
3. `Options` 창이 뜨면 왼쪽 메뉴 하단의 `Python`선택
4. `Python interpreter:`의 `Select`버튼 클릭
5. `Python interpreter`를 선택할 수 있는 창이 열리면, `spacy_initialize()`함수가 찾는 파이썬 경로 선택(예: `C:\Users\[사용자ID]\AppData\Local\r-miniconda\envs\spacy_condaenv\python.exe`)


#### `Sys.setevn()` 함수 이용

```
Sys.setenv(RETICULATE_PYTHON = "`spacy_initialize()`함수가 찾는 파이썬 경로")

예:

Sys.setenv(RETICULATE_PYTHON = "C:\Users\[사용자ID]\AppData\Local\r-miniconda\envs\spacy_condaenv\python.exe")

```

#### `reticulate::use_python()` 함수 이용

```
reticulate::use_python("`spacy_initialize()`함수가 찾는 파이썬 경로")

예: 

reticulate::use_python("C:\Users\[사용자ID]\AppData\Local\r-miniconda\envs\spacy_condaenv\python.exe")

```

#### 설정 변경 확인

`reticulate::py_config()`를 실행하면 파이썬 설정 환경을 확인할 수 있다. 

```
python: C:\Users\[사용자ID]\AppData\Local\r-miniconda\envs\spacy_condaenv\python.exe
...

```

spacyr 패키지 소품문에 나와 있는 예제를 실행해본다.


```r
library("spacyr")

spacy_initialize(model = "en_core_web_sm")

txt <- c(d1 = "spaCy is great at fast natural language processing.",
         d2 = "Mr. Smith spent two years in North Carolina.")

parsedtxt <- spacy_parse(txt, tag = TRUE, entity = FALSE, lemma = FALSE)
parsedtxt
```

<pre class="r-output"><code>##    doc_id sentence_id token_id      token   pos tag
## 1      d1           1        1      spaCy  VERB VBN
## 2      d1           1        2         is   AUX VBZ
## 3      d1           1        3      great   ADJ  JJ
## 4      d1           1        4         at   ADP  IN
## 5      d1           1        5       fast   ADJ  JJ
## 6      d1           1        6    natural   ADJ  JJ
## 7      d1           1        7   language  NOUN  NN
## 8      d1           1        8 processing  NOUN  NN
## 9      d1           1        9          . PUNCT   .
## 10     d2           1        1        Mr. PROPN NNP
## 11     d2           1        2      Smith PROPN NNP
## 12     d2           1        3      spent  VERB VBD
## 13     d2           1        4        two   NUM  CD
## 14     d2           1        5      years  NOUN NNS
## 15     d2           1        6         in   ADP  IN
## 16     d2           1        7      North PROPN NNP
## 17     d2           1        8   Carolina PROPN NNP
## 18     d2           1        9          . PUNCT   .
</code></pre>


## `KoNLP`

형태소 분석기 한나눔(Hannanum)을 R에서 사용할 수 있도록한 패키지다. CRAN에서 내려져 있기 때문에 [개발자 깃헙](https://github.com/haven-jeon/KoNLP)에서 `remote`패키지의 `install_github()`함수를 이용해 설치한다. 

`KoNLP`를 설치하기 위해서는 자바와 `rtools`가 필요하다. 

### 자바JDK

1. [자바JDK](https://www.oracle.com/java/technologies/javase-downloads.html)를 다운로드받아 설치한다. 

`jdk`설치여부는 `C:\Program Files\Java\jdk-16`폴더에서 확인할 수 있다. Java SE 16보다 최신 버전이 있으면 최신버전으로 새로 설치한다. 

2. 윈도 `시스템 속성`창의 `환경변수`에서 `JAVA_HOME`을 설정한다. 

**`시스템 속성`창 여는 방법** 

- 간단한 방법: 

윈도 실행창 단축키인 `윈도키`와 키보드의 `R`을 함께 누르면 윈도 실행창이 열린다. 실행창이 뜨면 `sysdm.cpl ,3`을 입력하고 엔터키를 누르면 `시스템 속성` 창이 열린다. 

- 복잡한 방법 (윈도10 기준): 

1. 윈도탐색기에서 `내 PC`에 마우스 커서를 놓고 마우스 오른쪽 버튼 클릭 -> `속성(R)` 클릭해 윈도설정에서 `정보`창이 열린다. 

2. 윈도설정에서 `정보`창이 열리면 `관련설정` 항목에서 `고급 시스템 설정` 클릭하면  `시스템 속성` 창의 `고급` 탭이 열린다. 

**`환경변수` 설정하기**

1. `시스템 속성`창 하단의 `환경설정`버튼을 클릭한다. `환경변수`창이 열리면 `시스템변수(S)`아래의 `새로만들기(W)`버튼을 클릭한다. 

2. `새 시스템 변수` 창이 열리면 `변수 이름(N):`에 `JAVA_HOME`을 기입하고, `변수 값(V)`에서 JDK설치 경로 `C:\Program Files\Java\jdk-16\`를 기입하고 `확인`을 클릭한다.


### `rtools`

1. CRAN의 [`rtools`페이지](https://cran.r-project.org/bin/windows/Rtools/)에 접속한다.

2. 설치된 R버전과 일치하는 버전의 `rtools`를 다운로드받는다. R이 4.0대 버전이면 `rtools40`을 설치한다. 

- `rtools`는 다른 패키지와 달리 `install.packages()`함수로 설치하지 않고, 설치파일을 컴퓨터에서 직접 실행해 설치한다. 

3. 설치할때 경로변경하지 말고 `C:/Rtools`에 설치한다. 실치과정에서 `Add rtools to system PATH`가 체크돼 있는지 확인한다. 

- 기타 KoNLP 설치이슈에 대해서는 [이 문서](https://www.facebook.com/notes/r-korea-krugkorean-r-user-group/konlp-%EC%84%A4%EC%B9%98-%EC%9D%B4%EC%8A%88-%EA%B3%B5%EC%9C%A0/1847510068715020/) 참조

### 의존패키지

설치할 때 오류가 나는 경우가 있다. 의존패키지(패키지작동에 필요한 다른 패키지)가 설치돼 있지 않기 때문이다. 다음은 KoNLP의존 패키지다. 

- rJava (>= 0.9-8),
- utils (>= 3.3.1),
- stringr (>= 1.1.0),
- hash (>= 2.2.6),
- tau (>= 0.0-18),
- Sejong (>= 0.01),
- RSQLite (>= 1.0.0),
- devtools (>= 1.12.0)

아래 코드로 필요한 패키지가 이미 설치돼 있는지 확인할 수 있다. 


```r
package_list <- c("rJava", "utils", "stringr", "hash", "remote",
                  "tau", "Sejong", "RSQLite", "devtools")
( package_list_installed <- package_list %in% installed.packages()[,"Package"] )
```

<pre class="r-output"><code>## [1] FALSE  TRUE  TRUE FALSE FALSE FALSE FALSE  TRUE  TRUE
</code></pre>

```r
( new_pkg <- package_list[!package_list_installed] )
```

<pre class="r-output"><code>## [1] "rJava"  "hash"   "remote" "tau"    "Sejong"
</code></pre>

아래 코드로 미설치된 패키지를 한번에 설치할 수 있다. 만일 설치가 안되면 이 교재 [`2.4 오류`](https://bookdown.org/ahn_media/bookdown-demo/prep.html#%EC%98%A4%EB%A5%98error)를 참고해 개별적으로 설치한다. 


```r
if(length(new_pkg)) install.packages(new_pkg)
```

의존성 패키지가 의존하는 패키지가 있다. 만일 오류메시지가 나오면 메시지를 잘 읽어보고, 필요한 패키지를 추가로 설치한다. 

KoNLP설치 준비가 됐으면 아래 코드로 설치한다. 


```r
remotes::install_github('haven-jeon/KoNLP', 
                        upgrade = "never", 
                        INSTALL_opts=c("--no-multiarch"))
```

제대로 설치됐는지 확인해보자. 


```r
# library(KoNLP)
# extractNoun("한글테스트입니다.")
# SimplePos09("한글테스트입니다.")
```

`KoNLP`에서 사용할 사전을 설치하자. `NIADic`이 `SejongDic`보다 더 많은 형태소를 포함하고 있다. 설치과정에서 기 설치된 패키지 업데이트 여부를 묻는다. 모두 최신버전으로 업데이트한다. 


```r
useNIADic()
```

한글띄어쓰기가 안돼 있는 문서는  `autoSpacing = T`인자를 투입한다. 


```r
"아버지가가방에들어가신다" %>% SimplePos09()
"아버지가가방에들어가신다" %>% SimplePos09(autoSpacing = T)
```


띄어쓰기 안된 문서의 행태소 분석에는 `MeCab`이 유리하다. 


```r
"한글테스트입니다" %>% SimplePos09(autoSpacing = T)
"한글테스트입니다" %>% enc2utf8() %>% RcppMeCab::pos() 
"아버지가가방에들어가신다" %>% enc2utf8() %>% RcppMeCab::pos() 
```


`KoNLP`를 이용해 띄어쓰기가 잘 안된 문서를 분석할 때는 `KoSpacing`패키지로 띄어쓰기를 조절할 수 있다(설치과정이 복잡하므로 선택 사항.)


```r
# remotes::install_github("haven-jeon/KoSpacing")
# library(KoSpacing)
# set_env()
# 
# spacing("한글테스트입니다.")
```


`KoNLP`의 장점은 기존 사전에 사용자사전을 추가할 수 있다는데 있다. 


```r
"힣탈로미를 어떻게 할까요" %>% SimplePos09
```


```r
buildDictionary(ext_dic = c('sejong', 'woorimalsam'),
                user_dic = data.frame(term="전작권", tag='ncn'),
                category_dic_nms=c('political'))

buildDictionary(ext_dic = "woorimalsam", 
                user_dic=data.frame("힣탈로미", "ncn"),
                replace_usr_dic = T)
```


