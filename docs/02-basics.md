

# 준비운동 {#prep}

## 패키지와 rtools

패키지(Package)는 R함수, 데이터, 완성된 코드를 정리해 종합한 꾸러미다.  라이브러리(library)라고도 한다. 패키지를 R환경에 올리는 함수가 `library()`인 이유다. `require()`도 패키지를 R환경에 올리는 함수이나 `library()`와는 달리, `TRUE`와 `FALSE`값을 산출한다. 

`패키지::함수`와 같은 방식을 이용해도 패키지의 함수를 이용할 수 있다. 아래 예문은 `psych`패키지의 `headTail()`함수 이용. 

예: `psych::headTail(df)`

`sessionInfo()`함수를 이용해 R환경에 올려진 패키지와 버전을 확인할 수 있다.

패키지 버전만 확인하고 싶으면 `packageVersion("패키지명")`을 이용한다.

R Studio에서 버전을 확인하는 방법은 다음과 같다. 

```
Tools -> Check for Package Updates ...
```

패키지를 설치할 때는 RStudio를 관리자 권한으로 실행해야 제대로 설치된다. 윈도가 보안정책을 강화했기 때문이다.  


### `rtools`

윈도에서 R의 다양한 패키지를 설치하고 사용하는데 필요한 패키지다. (맥이나 리눅스에서는 설치 불필요.)

1. CRAN의 [`rtools`페이지](https://cran.r-project.org/bin/windows/Rtools/)에 접속한다.
2. 설치된 R버전과 일치하는 버전의 `rtools`를 다운로드받는다. 예를 들어, R이 4.0대 버전이면 `rtools40`을 설치한다. 
    - `rtools`는 다른 패키지와 달리 `install.packages()`함수로 설치하지 않고, 설치파일을 컴퓨터에서 직접 실행해 설치한다. 
3. 설치할때 경로변경하지 말고 `C:/Rtools`에 설치한다. 실치과정에서 `Add rtools to system PATH`가 체크돼 있는지 확인한다. 


### tidyverse

정돈된 세계를 구성해 R을 한층 뛰어난 프로그래밍 언어로 만들어준 패키지다. (tidy를 직역하면 "깔끔한"이지만, tidyverse의 취지에 맞게 tidy를 "정돈된"으로 번역한다. )

정돈된 세상에 대해서는 한국통계학회 소식지 2019년 10월호에 실린 "데이터사이언스 운영체계 `tidyverse` 참조. 

- https://statkclee.github.io/ds-authoring/ds-stat-tidyverse.html

`tidyverse`는 정돈된 세상(tidy + universe)이란 의미의 종합패키지다. "정돈된 세계(tidyverse)"안에서는 코딩작업을 직관적이고도 일관성있게 할 수 있다. 해들리 위컴(Hadley Wicham)이 제시한 "정돈된 데이터 원리(tidy data principle)"에 따라 구성한 세계관이다.  `tidyverse`패키지를 설치하면 `ggplot2`, `dplyr`, `tidytext`, `lubridate` 등 다수의 유용한 패키지가 함께 설치된다.

 - Hadley Wicham http://hadley.nz/
 - Tidyverse Overview https://tidyverse.tidyverse.org


먼저 `install.packages()`함수를 이용해 `tidyverse` 패키지를 설치하고, `library()`함수를 이용해 현재의 R환경에 올려 패키지를 사용할 수 있도록 하자. 


```r
install.packages("tidyverse")
```


```r
library(tidyverse)
```

```
## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──
```

```
## ✔ ggplot2 3.3.6     ✔ purrr   0.3.4
## ✔ tibble  3.1.7     ✔ dplyr   1.0.9
## ✔ tidyr   1.2.0     ✔ stringr 1.4.0
## ✔ readr   2.1.2     ✔ forcats 0.5.1
```

```
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
```

설치하면 `-- Attaching packages --`라는 메시지가 뜨며 아래 8종의 패키지 목록이 보인다. 이 8종의 패키지는 `library(tidyverse)`를 통해 `tidyverse`패키지를 현재의 R환경에 올리면 함께 R환경에 올라가는 부착된 패키지다. 즉, 아래 8개 패키지를 `library()`로 개별적으로 올리지 않아도 R환경에서 사용할 수있다. 

 - `ggplot2` 시각화 도구모음. 그래픽의 문법에 기초 
 - `dplyr` 데이터 조작. 일종의 공구상자 
 - `tidyr` 데이터 정돈. 데이터를 정돈하는 함수 제공 
 - `readr` 데이터 이입. 행과 열이 있는 데이터(예: csv, tsv, fwf) 이입(import)
 
 - `purr` 함수형프로그래밍(functional programming) 도구모음
 - `tibble` 데이터프레임의 현대적 양식
 - `sringr`문자형 데이터(string) 작업 도구 모음
 - `forcats` 데이터유형(type)이 요인(factor)일때 발생하는 문제해결 도구모음. 

아래의 패키지는 `tidyverse`와 함께 설치되지만 `library(패키지명)`로 따로 R환경에 올려야 사용할 수 있는 패키지다. 

 - `hms` housr와 time 데이터 처리 도구 모음
 - `lubridate` date와 times 데이터 처리 도구 모음
 
 - `httr` 웹 API 
 - `rvest` 웹 스크레핑 
 - `readxl` xls ghrdms xlsx 파일 이입
 - `haven` SPSS, SAS, STATA 파일 이입
 - `jasonlite` JSON 
 - `xml2` XML
 
 - `modelr` 파이프라인안에서 모델링 
 - `broom` 모델을 tidydata로 


### 패키지 일괄설치

텍스트마이닝에는 여러 종류의 패키지가 필요하다. 이 모든 것을 매번 설치하고 번번히 실행하는 것이 번거롭다. 게다가 이미 설치된 패키지가 무엇이 있는지 기억하기 어렵기 때문에, 패키지를 반복해서 설치하는 경우가 있다. 설치돼 있는 패키지는 설치를 피하고, 새로운 패키지만 골라서 동시에 설치하는 방법을 알아보자. 

명령어 앞뒤로 괄호`( )`를 치면 할당한 객체의 내용을 콘솔에서 보여준다. 


```r
names( installed.packages()[,"Package"] )
package_list <- c( "tidyverse", "epubr", "showtext",
                  "tidytext", "tidymodels", "tidygraph", "textclean"
                  "topicmodels", "stm")
( package_list_installed <- package_list %in% installed.packages()[,"Package"] )

( new_pkg <- package_list[!package_list_installed] )
if(length(new_pkg)) install.packages(new_pkg)
```


설치한 여러 패키지를 동시에 R환경에 올리는 방법은 다음과 같다. 

`lapply`함수는 데이터 하부요소에 대해 투입한 함수를 하나 씩 반복적으로 실행해준다. `for`의 반복문보다 효율적이어서 자주 쓰는 함수다.  

아래 코드는 `require`함수를 설치해야 하는 패키지 목록이 담겨 있는 `package_list`의 하부요소(개별 패키지)에 대해 하나씩 실행하라는 의미다. `character.only = TRUE` 대신 `ch = T`로 입력해도 된다.


```r
lapply(package_list, require, character.only = TRUE)
( .packages() )
```

`library`대신 `require`를 쓴 이유는 반복실행 과정에 처리 결과에 대한 `TRUE`와 `FALSE`가 필요하기 때문이다. `require`와 `library`는 둘다 패키지를 R환경에 올리지만, `require`가 처리 결과에 대한 `TRUE`와 `FALSE`를 산출한다. 

위 코드를 각자 자주 사용하는 패키지 목록으로 수정해, 별도의 R파일로 만들어 패키지를 새로 설치하거나 실행할 때 사용하면 편리하다. 매번 번거롭게 `library`를 반복해서 입력할 필요가 없어진다.   


## 경고와 오류

Warning(경고)메시지는 참고만 하고 무시해도 되지만, 오류(error)메시지는 거의 대부분 해결해야 다음 단계로 넘어갈 수 있다. 

**오류가 발생하면 당황하지 말고, 오류메시지를 잘 읽어보자.** 

R 언어로 텍스트 마이닝 뿐만 아니라 다양한 개발 및 분석작업을 진행할 때 
흔한 오류로 다음을 꼽을 수 있다.

### 오자와 탈자 

가장 흔한 오류의 원인은 오타다.

- 영어는 단수와 복수의 구분이 엄격하다. 철자에 's'가 정확하게 들어 있는지 확인한다.

- '1'과 'l'의 차이. 사람 눈에 비슷해 보이는 글자에 주의한다. 기계에게는 전혀 다른 내용이다. 예를 들어, `readxl`패키지를 `readx1`로 입력하지 않았는지 확인해보자. 


### 괄호의 불일치

- 괄호의 앞`(`과 `)`가 일치해야 한다. 마무리를 하지 않으면 코드 실행이 될수가 없다. R스튜디오 편집창에서 오류 표시를 해 준다. 


### 보이지 않는 코드 

PDF문서의 내용을 R스튜디오 편집창에 복사해서 붙일 때, 문서의 코드를 그대로 복사해서 붙였으므로, 오자나 탈자가 없는데도, 코드가 작동하지 않는 경우가 있다.  이런 일이 생기는 이유는 사람의 눈에 동일한 문자라도 기계는 다른 문자코드로 인식할 수 있기 때문에. 특히, PDF문서를 복사해서 편집기에 복사해서 붙이면 사람 눈에 보이지 않는 코드도 함께 복사돼 붙여지는 경우가 있다. 

이런 문제가 생기면, 메모장같은 텍스트에디터에 해당 코드를 붙여넣었다 다시 복사해서 R스튜디오 편집창에 붙여 넣으면 해결할 수 있다. 


### 패키지 설치시 겪을 수 있는 오류 

패키지설치할 때 아래와 같은 오류가 발생하는 경우가 있다. 

```
> library("tidyverse")
Error: package or namespace load failed for ‘tidyverse’ in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]):
namespace ‘scales’ 0.4.0 is already loaded, but >= 0.4.1 is required
```


`tidyverse`패키지와 함께 설치되는 패키지가 의존하는 `scale`패키지가 컴퓨터에서 업데이트돼 있지 않아 오류가 발생했다는 의미다. 

해당 패키지(이 경우 `scale`)를 새로 설치하거나 업데이트한다. 

새로 설치할 때는 `dependencies=TRUE`를 명령어에 추가해 모든 의존 패키지도 설치하도록 하자. 

```
install.packages("패키지명", dependencies=TRUE)
```

패키지 업데이트를 해보는 방법도 있다. 

```
update.packages("패키지명")
```

만일 새로 설치해도 해결이 안되면, 패키지를 R콘솔에서 설치해본다. 이때 **R을 관리자권한**으로 실행하자. 


그래도 안되면, 패키지가 설치돼 있는 하드디스크폴더에서 해당 패키지 폴더를 삭제하고 다시 설치한다.  
패키지가 설치된 위치는 다음과 같다. `.libPaths()`함수를 통해 확인할 수 있다. 
패키지가 설치되는 위치는 RStudio를 관리자 권한으로 실행하는 경우 `C:/Program Files/R/[R버전]/library`다. 
관리자권한으로 실행하지 않으면 아래의 경우처럼 문서폴더에 패키지가 설치된다. 

```
내 PC > 문서 > R > win-library
또는
C:\Users\[윈도사용자]\Documents\R\win-library
예를 들어:
C:\Users\myPC\Documents\R\win-library
```

패키지 설치위치는  `.libPaths("폴더명")`함수로 **패키지 설치위치를 바꿀 수 있다**. 
예를 들어, C드라이브의 `library`폴더를 만들어 `.libPaths("c:/library")`를 입력하면 패키지 설치 경로가 변경된다.

### 실행할 때 겪는 오류

다음과 같은 에러메시지가 뜨는 경우가 있다. 메시지의 내용을 잘 읽어보자. 

```
Error in tibble(text = text_vword) %>% unnest_tokens(output = word, input = text) : 
  함수 "%>%"를 찾을 수 없습니다
```

실행하는데 필요한 함수 `%>%`를 찾을 수 없다는 의미다. `%>%`는 파이핑에 필요한 함수로서 `dplyr`에서 `magrittr`패키지를 통해 제공한다. `dplyr`는 `tidyverse`를 올리면 함께 부착된다. 

따라서 아래 3가지 중 하나만 하면 해결할 수 있다. 

```
library(tidyverse)
또는
library(dplyr)
또는
library(magrittr)
```

마찬가지로 아래와 같은 에러메시지가 뜨면 어떻게 해야할까? 

```  
Error in unnest_tokens(., output = word, input = text) : 
  함수 "unnest_tokens"를 찾을 수 없습니다  
```  

오류메시지의 내용을 보니, `unnest_tokens`함수가 없다고 한다. `unnest_tokens`가 어디에 속해 있는 함수인지 검색해보자. `tidytext`패키지의 함수란 정보를 어렵지 않게 찾을 수 있다. 따라서 `unnest_tokens`함수를 제공하는 패키지 `tidytext`를 실행한다. 설치가 안돼 있으면 설치부터 한다. 


```r
install.packages("tidytext")
library(tidytext)
```

- 기타 패키지 설치 관련 정보는 [이 문서](https://datadoctorblog.com/2020/04/18/R-package-troubleshooting/) 참조



## 코딩 스타일

일관성 있는 코드작성은 해들리 위컴의 R스타일 가이드를 참조하자.

- [the tidyverse style guide](https://style.tidyverse.org/)
- [일관성 있는 R 코드 작성하기: 해들리 위컴의 R 코딩 스타일 가이드](https://3months.tistory.com/386)

데이터를 할당한 객체이름을 정할 때 객체의 특성(예: 데이터구조)를 명기하는 습관을 들이는 것이 좋다. 

```
예: 
벡터: name_v
데이터프레임: name_df
매트릭스: name_m
리스트: name_l
사용자 함수: name_f
토큰: name_tk
```


## 파일경로 표시

### 슬래시 /

윈도에서는 경로(path) 표시 역슬래시`\`를 사용하지만,  
R환경에서는 슬래시`/`를 이용해 경로를 표시한다. `\\`처럼 역슬래시를 두번 쓰기도 한다.


`/`만 쓰거나 첫번째로 적는 `/`는 루트디렉토리를 의미한다. 

```
list.files("/") #루트디렉토리에 있는 모든 파일과 폴더 표시
list.files("/data") #루트디렉토리 아래의 data폴더에 있는 모든 파일과 폴더 표시
list.files("data") # 현재 작업디렉토리 아래의 data폴더에 있는 모든 파일과 폴더 표시
```

### 퀴즈 

`list.files("data\images")`를 실행하면 아래와 같은 오류가 발생한다. 이유는?
```
> list.files("data\images")
에러: ""C:\U"로 시작하는 문자열들 가운데 16진수가 아닌 "\U"가 사용되었습니다
```

윈도에서 사용하는 경로표시 `\`를 R환경에서 사용했기 때문이다. `\`를 `/`로 수정한다. 


### 마침표 . .. 

- 마침표 하나`.` 현재 작업디렉토리
- 마침표 둘`..` 현재 작업디렉토리 바로 한단계 위에 있는 폴더 


```
list.files(".") #작업디렉토리에 있는 모든 파일과 폴더 표시
list.files("./images") #작업디렉토리아래에 있는 images폴더에 있는 모든 파일과 폴더 표시. 
```

`list.files("./images")`의 산출결과는 `list.files("images")`와 같다. `./images`와 `images`는 둘다 현재 작업디렉토리 아래에 있는 `images`란 의미.

```
list.files("..") # 작업디렉토리 위 폴더에 있는 모든 파일과 폴더 표시
list.files("../dir") #작업디렉토의 위 폴더 아래(즉, 현 작업디렉토리와 같은 단계의 위치에 있는 폴더) 아래에 있는 images폴더에 있는 모든 파일과 폴더 표시
```

### 물결 `~`

물결표시`~`는 홈디렉토리를 의미한다. 로그인 사용자가 사용할 수 있는 최상위 디렉토리.

윈도의 경우에서 만일 사용자 ID를 user1이라고 한 경우 `C:/Users/user1/Documents`폴더가 홈디렉토리가 된다.
(윈도환경에서는 경로를 역슬래시를 사용하므로 `C:\Users\user1\Documents`로 표시된다.)

따라서 `list.files("~")`과 `list.files("C:/Users/user1/Documents")`는 같은 결과 산출. 

```
list.files("~") #홈디렉토리에 있는 모든 파일 표시
list.files("~/R/win-library") #홈디렉토리 아래단계에 있는 R/win-library폴더의 모든 파일과 폴더 표시 

```


## 파일과 객체

### 로컬 파일 처리 함수

하드디스크에 있는 로컬 파일을 다루는 함수는 디렉토리 생성을 할 때 `dir.create()`,
디렉토리 파일과 폴더 목록을 확인할 때 `list.files()` 함수를 사용한다.

```
dir.create("C:/newdir") 디렉토리(폴더) 생성
list.files() 현재 작업디렉토리 파일과 폴더 목록
```


### R 세센 객체 처리 함수

R을 실행하게 되면 세션을 생성하는데 해당 세션 작업공간에 저장된
객체 목록을 살펴볼 때 `ls()`, 객체를 삭제할 때는 `rm()` 명령어를 사용한다.

```
ls() 현재 작업공간에 있는 객체 목록
rm(객체명) 작업공간의 객체 제거. 필요없는 객체 제거에 사용. 
```

현재 작업중인 디렉토리를 파악할 때는 `getwd()`,
작업 디렉토리를 지정할 때는 `setwd()` 명령어를 사용한다.

```
getwd() 작업디렉토리(working directory) 표시
setwd("C:/newdir") "C:/newdir"을 작업디록토리 설정
```

단일 R객체를 파일로 저장하는 방법은 `saveRDS()` 반대로 이 파일을
로컬 컴퓨터에서 R 세션으로 불러올 때는 `readRDS()` 함수를 사용한다.

```
saveRDS(name_df, file = "name_df.rds")
name_df <- readRDS("name_df.rds")

```

복수의 R객체를 파일로 저장하고 불러들일 때는 `save()`와 `load()` 함수를 
사용한다.

```
save(n1_df, n2_df, file = "name.RData") n1_df과 n2_df객체를 작업디렉토리에 name.RData란 이름의 파일로 저장
load("name.RData") name.RData를 작업공간에 탑재
```

R환경의 모든 객체를 이미지로 저장할 때는 `save.images()` 함수와 
이를 다시 불러올 때는 `load()` 함수를 사용한다.

```
save.images("myData.RData") 작업공간을 이미지파일로 저장. 파일명 지정하지 않으면 .RData로 저장. 
load("myData.RData") 작업디렉토리 파일을 현 작업공간에 객체로 탑재
```

[`fst`패키지](http://www.fstpackage.org)를 이용하면 대용량 파일을 빠르게 처리할 수있다.

 - fst: http://www.fstpackage.org

```
# Store the data frame to disk
  write.fst(df, "dataset.fst")

# Retrieve the data frame again
  df <- read.fst("dataset.fst")

```


## 따옴표와 백틱

### 겹따옴표 홑따옴표

겹따옴표와 홑따옴표는 문자형요소를 지칭하는데, 함께 사용해야 할때가 있다. 

인용문안에서 인용해야 할때는 겹따옴표와 홑따옴표를 함께 사용한다. 

```
"이렇게 인용문 안에 '다시 인용할때' 겹따옴표와 홑따옴표를 함께 사용"
```

### 백틱(backquote/backtick) `

변수 혹은 객체명이 한글 특수기호 혹은 띄어쓰기가 있는 경우, 
키보드 가장 왼쪽 위에 있는 부호 백틱 한쌍을 이용한다. 

```
`한글변수(명)`

```

## 기타

### 폴더명칭 주의사항

R작업에 관련된 폴더이름은 모두 영문으로 지정한다. 
한글명 폴더를 이용할 경우 오류발생하는 경우가 드물지 않다. 


폴더명을 지정할 때 띄어쓰기를 하지않는다. 
오류의 원인이다. 데이터분석 작업을 하는 폴더의 이름은 모두 영문으로 붙여쓴다. 


R스튜디오는 작업디렉토리 기본설정이 홈디렉토리(~)로 돼 있다. 
만일 윈도나 맥 등 운영체제에서 한글을 사용자명으로 지정했을 꼉우, 경로에 한글폴더가 포함된다. 대부분 문제없지만, 간혹 오류 발생의 원인이 된다. 

작업디렉토리 기본값을 루트디렉토리 아래 영문폴더(예: `C:/data`)를 만들어 설정하자. 

### `NA`와 `NULL`의 차이

결측값 `NA`는 값이 없지만, 값이 들어갈 자리는 있는 상태.
`NULL`은 값과 자리가 모두 없는 상태.

- `0`은 결측값이 아니다. 
- `0`은 숫자형 값
- `"0"`은 문자형 값




