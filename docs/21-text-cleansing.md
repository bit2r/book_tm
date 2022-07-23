
---
output: html_document
editor_options: 
  chunk_output_type: console
---




# 정제(전처리)  {#text-clean}

정제는 자료정보지식지혜(DIKW)위계론의 1차부호화 단계에 해당한다. 정제를 거친 자료를 분석하는 2차부호화 과정을 거쳐 자료가 정보로 가공된다. 광물 정제과정에 비유할 수 있다. 금광석 등 광물을 캐면 먼저 잘게 분쇄한다. 불순물을 제거하고, 규격화한 금괴로 가공한다. 마찬가지로 원자료를 분석할 수 있는 단위로 분쇄(토큰화)하고, 불순물을 제거(불용어 제거)한 다음, 규격화한 양식으로 정규화한다. 

 - 토큰화
 - 불용어제거
 - 정규화
 



```r
pkg_l <- c("tidyverse", "tidytext", "textdata")
purrr::map(pkg_l, require, ch = T)
```

<pre class="r-output"><code>## [[1]]
## [1] TRUE
## 
## [[2]]
## [1] TRUE
## 
## [[3]]
## [1] TRUE
</code></pre>


## 토큰화

텍스트 원자료를 분석할 수 있도록 토큰(token)으로 잘게 나누는 단계다. 토큰의 단위는 분석 목적에 따라 글자, 단어, 엔그램(n-gram), 문장, 문단 등 다양하게 지정할 수 있다. 

### `unnest_tokens(df, output, input, token = "words", format = c("text", "man", "latex", "html", "xml"), to_lower = TRUE, drop = TRUE, collapse = NULL, ...)`


토큰으로 나누는 단위는 분석의 목적에 따라 다양한 단어, 글자, 문장 등 다양한 수준으로 설정할 수 있다. 

- "characters"  글자 단위
- "character_shingles" 복수의 글자 단위
- "words" 단어 단위
- "ngrams" 복수의 단어 단위
- "regex" 정규표현식으로 지정

`tidytext`패키지에서는 `unnest_tokens()`함수에서는 `token = `인자로 토큰 단위를 지정할 수 있다. 

##### 단어

`unnest_tokens()`함수에서 토큰의 기본값으로 설정된 단위는 단어("words")다. 



```r
text_v <- "You still fascinate and inspire me.
You influence me for the better. 
You’re the object of my desire, the #1 Earthly reason for my existence."

tibble(text = text_v) %>% 
  unnest_tokens(output = word, input = text,
                token = "words")
```

<pre class="r-output"><code>## <span style='color: #555555;'># A tibble: 25 × 1</span>
##   word     
##   <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>    
## <span style='color: #555555;'>1</span> you      
## <span style='color: #555555;'>2</span> still    
## <span style='color: #555555;'>3</span> fascinate
## <span style='color: #555555;'>4</span> and      
## <span style='color: #555555;'>5</span> inspire  
## <span style='color: #555555;'>6</span> me       
## <span style='color: #555555;'># … with 19 more rows</span>
</code></pre>

#####  글자 토큰

`token = `인자에 "characters"를 투입하면 글자 단위로 토큰화한다. 


```r
tibble(text = text_v) %>% 
  unnest_tokens(output = word, input = text,
                token = "characters") %>% 
  count(word, sort = T)
```

<pre class="r-output"><code>## <span style='color: #555555;'># A tibble: 21 × 2</span>
##   word      n
##   <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span> <span style='color: #555555; font-style: italic;'>&lt;int&gt;</span>
## <span style='color: #555555;'>1</span> e        20
## <span style='color: #555555;'>2</span> t        10
## <span style='color: #555555;'>3</span> o         8
## <span style='color: #555555;'>4</span> r         8
## <span style='color: #555555;'>5</span> i         7
## <span style='color: #555555;'>6</span> n         7
## <span style='color: #555555;'># … with 15 more rows</span>
</code></pre>

##### 복수의 글자

복수의 글자를 토큰의 단위로 할 때는 "character_shingles"을 `token = `인자에 투입한다. 기본값은 3글자. 


```r
tibble(text = text_v) %>% 
  unnest_tokens(output = word, input = text,
                token = "character_shingles", n = 4) %>% 
  count(word, sort = T)
```

<pre class="r-output"><code>## <span style='color: #555555;'># A tibble: 104 × 2</span>
##   word      n
##   <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span> <span style='color: #555555; font-style: italic;'>&lt;int&gt;</span>
## <span style='color: #555555;'>1</span> ence      2
## <span style='color: #555555;'>2</span> ethe      2
## <span style='color: #555555;'>3</span> reth      2
## <span style='color: #555555;'>4</span> 1ear      1
## <span style='color: #555555;'>5</span> andi      1
## <span style='color: #555555;'>6</span> arth      1
## <span style='color: #555555;'># … with 98 more rows</span>
</code></pre>

##### 복수의 단어(n-gram)

복수의 단어를 토콘 단위로 나눌 때는 `token = `인자에 "ngrams"인자를 투입한다. 기본값은3개이다.  


```r
tibble(text = text_v) %>% 
  unnest_tokens(output = word, input = text,
                token = "ngrams", n = 4) %>% 
  count(word, sort = T)
```

<pre class="r-output"><code>## <span style='color: #555555;'># A tibble: 22 × 2</span>
##   word                         n
##   <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>                    <span style='color: #555555; font-style: italic;'>&lt;int&gt;</span>
## <span style='color: #555555;'>1</span> 1 earthly reason for         1
## <span style='color: #555555;'>2</span> and inspire me you           1
## <span style='color: #555555;'>3</span> better you’re the object     1
## <span style='color: #555555;'>4</span> desire the 1 earthly         1
## <span style='color: #555555;'>5</span> earthly reason for my        1
## <span style='color: #555555;'>6</span> fascinate and inspire me     1
## <span style='color: #555555;'># … with 16 more rows</span>
</code></pre>


##### 정규표현식

정규표현식(regex: regular expressions)을 이용하면, 토콘을 보다 다양한 방식으로 나눌 수 있다. 


`token = `인자에 "regex"를 지정한다. `pattern = `에 정규표현식을 투입한다.  

정규표현식에서 "new line"을 의미하는 `"\n"`를 이용해 토큰화할 경우 문장 단위로 토큰화할 경우, 수 있다.  만일 공백 단위로 토큰화한다면, 공백을 의미하는 `"\\s"`를 투입한다. 



```r
tibble(text = text_v) %>% 
  unnest_tokens(output = word, input = text,
                token = "regex", pattern = "\n")
```

<pre class="r-output"><code>## <span style='color: #555555;'># A tibble: 3 × 1</span>
##   word                                                     
##   <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>                                                    
## <span style='color: #555555;'>1</span> <span style='color: #555555;'>"</span>you still fascinate and inspire me.<span style='color: #555555;'>"</span>                    
## <span style='color: #555555;'>2</span> <span style='color: #555555;'>"</span>you influence me for the better. <span style='color: #555555;'>"</span>                      
## <span style='color: #555555;'>3</span> <span style='color: #555555;'>"</span>you’re the object of my desire, the #1 earthly reason f…
</code></pre>




### `format = c("text", "man", "latex", "html", "xml")`

`format = `인자를 이용해 토큰화하는 문서의 형식을 지정할 수 있다. 

"html"문서를 토큰화해보자. 


```r
pp_html_df <- tibble(text = read_lines("https://www.gutenberg.org/files/1342/1342-h/1342-h.htm"))
pp_html_df[1:5,]
pp_html_df %>% unnest_tokens(word, text, format = "html") %>% .[1:5,]
```




### `to_lower = TRUE` 

영문은 대문자와 소문자 구분이 있다. `to_lower = `인자의 기본값은 `TRUE`다.  `FALSE`를 로 지정하면 대문자를 모두 소문자로 변경하지 않는다. 영문문서에서 사람이름이나 지명을 구분해야 한다면 토큰화 과정에서 모든 단어를 소문자화하지 말아야 한다. 


```r
tibble(text = text_v) %>% 
  unnest_tokens(output = word, input = text,
                to_lower = FALSE)
```

<pre class="r-output"><code>## <span style='color: #555555;'># A tibble: 25 × 1</span>
##   word     
##   <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>    
## <span style='color: #555555;'>1</span> You      
## <span style='color: #555555;'>2</span> still    
## <span style='color: #555555;'>3</span> fascinate
## <span style='color: #555555;'>4</span> and      
## <span style='color: #555555;'>5</span> inspire  
## <span style='color: #555555;'>6</span> me       
## <span style='color: #555555;'># … with 19 more rows</span>
</code></pre>



### `strip_punct = `

추가인자는 `tokenizers`함수로 전달해 다양한 설정을 할 수 있다. 예를 들어, `strip_punct = `인자에 `FALSE`를 투입하면, 문장부호를 제거하지 않는다. 



```r
tibble(text = text_v) %>% 
  unnest_tokens(output = word, input = text,
                token = "words",
                strip_punct = FALSE)
```

<pre class="r-output"><code>## <span style='color: #555555;'># A tibble: 30 × 1</span>
##   word     
##   <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>    
## <span style='color: #555555;'>1</span> you      
## <span style='color: #555555;'>2</span> still    
## <span style='color: #555555;'>3</span> fascinate
## <span style='color: #555555;'>4</span> and      
## <span style='color: #555555;'>5</span> inspire  
## <span style='color: #555555;'>6</span> me       
## <span style='color: #555555;'># … with 24 more rows</span>
</code></pre>





## 불용어(stop words) 제거

불용어는 말 그대로 사용하지 않는 단어다.  불용어를 문자 그대로 해석하면 사용하지 않는 단어에 국한된다. 넓은 의미로 해석하면, 사용빈도가 높아 분석에 의미가 없거나, 내용을 나타내는데 기여하지 않는 단어, 숫자, 특수문자, 구두점, 공백문자, 기호 등이 포함된다.

무엇이 불용어가 돼야 하는지는 상황에 따라 다르다. 에를 들어, 대명사는 대부분의 불용어사전에 불용어로 포함돼 있지만, 분석 목적에 따라서는 대명사는 분석의 핵심단위가 되기도 한다. 기호도 마찬가지다. 기호를 이용한 이모티콘은 문서의 의미를 전달하기 때문에 모든 기호를 일괄적으로 제거해서는 안된다. 


앞서 제시한 연애편지를 문자 단위로 토큰화해 단어의 빈도를 계산해보자. 


```r
tibble(text = text_v) %>% 
  unnest_tokens(output = word, input = text) %>% 
  count(word, sort = TRUE)
```

<pre class="r-output"><code>## <span style='color: #555555;'># A tibble: 19 × 2</span>
##   word      n
##   <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span> <span style='color: #555555; font-style: italic;'>&lt;int&gt;</span>
## <span style='color: #555555;'>1</span> the       3
## <span style='color: #555555;'>2</span> for       2
## <span style='color: #555555;'>3</span> me        2
## <span style='color: #555555;'>4</span> my        2
## <span style='color: #555555;'>5</span> you       2
## <span style='color: #555555;'>6</span> 1         1
## <span style='color: #555555;'># … with 13 more rows</span>
</code></pre>

`count`로 단어빈도를 계산한 결과를 보면 "the"가 3회, "for", "me", "my", "you"가 각각 2회 사용됐다. 즉, 이 글은 너와 나에 대한 글이런 것을 알수 있다. 사랑고백이란 것이 너와 나의 일이므로 타당하다. 

분석결과를 보면 단어빈도로 의미를 파악하는데 불필요한 단어도 있다. "the", "for", "of", "and" 등과 같은 관사, 전치사, 접속사들처럼 자주 사용하는 단어들이다. 이런 단어는 불용어(stop words)로 처리해 분석대상에 제외하는 것이 보다 정확한 의미를 파악하는데 도움이 되는 경우도 있다. 


불용어를 제거하는 방법은 크게 두가지가 있는데 혼용한다. 

  - `anti_join()` 불용어목록을 데이터프레임에 저장한 다음, `anti_join()`함수를 이용해 텍스트데이터프레임과 배제결합하는 방법이다. 두 데이터프레임에서 겹치는 행을 제외하고 결합(join)한다. 이 경우 불용어 목록에 포함된 행이 제외된다.
  
  - `filter()`함수와 `str_detect()`함수를 함께 이용해 불용어 지정해 걸러내는 방법이다. 불용어사전에 포함돼 있지 않는 단어를 제거할 때 이용한다.




### 불용어 사전

주로 사용되는 불용어목록은 불용어사전으로 제공된다. `tidytext`패키지는 `stop_words`에 불용어를 모아 놓았다. `stop_words`의 구조부터 살며보자. 

`kableExtra`패키지를 이용하면 데이터프레임을 깔끔하게 출력할 수 있다.([사용법은 여기](https://cran.r-project.org/web/packages/kableExtra/vignettes/awesome_table_in_html.html)) 


```r
install.packages("kableExtra")
```

데이터셋을 R세션에 올리는 함수는 `data()`함수다.


```r
library(kableExtra)
data(stop_words)
stop_words %>% glimpse()
```

<pre class="r-output"><code>## Rows: 1,149
## Columns: 2
## $ word    <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span> "a", "a's", "able", "about", "above", "acc…
## $ lexicon <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span> "SMART", "SMART", "SMART", "SMART", "SMART…
</code></pre>

```r
stop_words[c(1:3, 701:703, 1001:1003),] %>% 
  kbl() %>% kable_classic(full_width = F)
```

<table class=" lightable-classic" style='font-family: "Arial Narrow", "Source Sans Pro", sans-serif; width: auto !important; margin-left: auto; margin-right: auto;'>
 <thead>
  <tr>
   <th style="text-align:left;"> word </th>
   <th style="text-align:left;"> lexicon </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> a </td>
   <td style="text-align:left;"> SMART </td>
  </tr>
  <tr>
   <td style="text-align:left;"> a's </td>
   <td style="text-align:left;"> SMART </td>
  </tr>
  <tr>
   <td style="text-align:left;"> able </td>
   <td style="text-align:left;"> SMART </td>
  </tr>
  <tr>
   <td style="text-align:left;"> during </td>
   <td style="text-align:left;"> snowball </td>
  </tr>
  <tr>
   <td style="text-align:left;"> before </td>
   <td style="text-align:left;"> snowball </td>
  </tr>
  <tr>
   <td style="text-align:left;"> after </td>
   <td style="text-align:left;"> snowball </td>
  </tr>
  <tr>
   <td style="text-align:left;"> parted </td>
   <td style="text-align:left;"> onix </td>
  </tr>
  <tr>
   <td style="text-align:left;"> parting </td>
   <td style="text-align:left;"> onix </td>
  </tr>
  <tr>
   <td style="text-align:left;"> parts </td>
   <td style="text-align:left;"> onix </td>
  </tr>
</tbody>
</table>

`stop_words`는 행이 1,149개(불용어 1,149개)이고, 열이 2개(word와 lexicon)인 데이터프레임이다. word열에 있는 단어가 불용어고, lexicon열에 있는 값은 불용어 용어집의 이름이다. `tidytext`패키지의 `stop_words`에는 세 개의 불용어 용어집(SMART, snowball, onix) 이 포함돼 있다. `filter`함수로 특정 용어집에 있는 불용어 사전만 골라 이용할 수 있다. 



```r
stop_words$lexicon %>% unique
```

<pre class="r-output"><code>## [1] "SMART"    "snowball" "onix"
</code></pre>


불용어사전으로 불용어를 걸러낸 다음 단어빈도를 계산해보자. 


```r
data(stop_words)

tibble(text = text_v) %>%
  unnest_tokens(output = word, input = text) %>% 
  anti_join(stop_words) %>% 
  count(word, sort = TRUE)
```

<pre class="r-output"><code>## <span style='color: #555555;'># A tibble: 10 × 2</span>
##   word          n
##   <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>     <span style='color: #555555; font-style: italic;'>&lt;int&gt;</span>
## <span style='color: #555555;'>1</span> 1             1
## <span style='color: #555555;'>2</span> desire        1
## <span style='color: #555555;'>3</span> earthly       1
## <span style='color: #555555;'>4</span> existence     1
## <span style='color: #555555;'>5</span> fascinate     1
## <span style='color: #555555;'>6</span> influence     1
## <span style='color: #555555;'># … with 4 more rows</span>
</code></pre>

결과를 보면 "you"등 대명사가 포함된 토큰은 모두 제거됐는데, "you’re"는 그대로 남아 있다. 불용어 사전에는 "you're"로 홑따옴표(quotation mark)`'`를 이용했는데, 본문에는 "you’re"로 홑낫표(aphostrophe)`’`를 이용했기 때문이다. 불용어사전으로 본문의 "you’re"를 제거하기 위해서는 둘 중 한가지는 해야 한다. 본몬의 홑낫표를 홑따옴표로 변경하거나, 불용어사전을 수정한다.  


#### 본문 수정

먼저 본문 수정을 해보자. 


```r
tapo_v <- text_v %>% str_replace_all("’", "'")

tibble(text = tapo_v) %>%
  unnest_tokens(output = word, input = text) %>% 
  anti_join(stop_words) %>% 
  count(word, sort = TRUE)
```

<pre class="r-output"><code>## <span style='color: #555555;'># A tibble: 9 × 2</span>
##   word          n
##   <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>     <span style='color: #555555; font-style: italic;'>&lt;int&gt;</span>
## <span style='color: #555555;'>1</span> 1             1
## <span style='color: #555555;'>2</span> desire        1
## <span style='color: #555555;'>3</span> earthly       1
## <span style='color: #555555;'>4</span> existence     1
## <span style='color: #555555;'>5</span> fascinate     1
## <span style='color: #555555;'>6</span> influence     1
## <span style='color: #555555;'># … with 3 more rows</span>
</code></pre>




#### 불용어 사전 수정1

불용어 사전에 "you’re"를 추가해보자. 데이터프레임을 만들어 `bind_rows()`로 데이터프레임을 결합할수도 있고, `add_row()`로 불용사전에 열을 곧바로 추가할수도 있다. 

먼저 `add_row()`로 행에 곧바로 추가하는 방법을 이용해보자.  추가됐는지 확인이 수월하도록 첫째행 전에 추가하자. 


```r
stop_words %>% add_row(word = "you’re", lexicon = "NEW", .before = 1) %>% head(3)
```

<pre class="r-output"><code>## <span style='color: #555555;'># A tibble: 3 × 2</span>
##   word   lexicon
##   <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>  <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>  
## <span style='color: #555555;'>1</span> you’re NEW    
## <span style='color: #555555;'>2</span> a      SMART  
## <span style='color: #555555;'>3</span> a's    SMART
</code></pre>

이번에는 데이터프레임을 결합해보자. 또한 숫자 "1"도 함께 불용어사전에 추가하자. 
먼저 추가할 용어를 불용어사전과 같은 구조의 데이터프레임에 저장한다. 


```r
names(stop_words)
```

<pre class="r-output"><code>## [1] "word"    "lexicon"
</code></pre>

```r
stop_add <- tibble(word = c("you’re", "1"),
                   lexicon = "added")
stop_add
```

<pre class="r-output"><code>## <span style='color: #555555;'># A tibble: 2 × 2</span>
##   word   lexicon
##   <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>  <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>  
## <span style='color: #555555;'>1</span> you’re added  
## <span style='color: #555555;'>2</span> 1      added
</code></pre>


`bind_rows()`함수로 불용어사전과 결합한다. 


```r
stop_words2 <- bind_rows(stop_words, stop_add)
stop_words2 %>% tail()
```

<pre class="r-output"><code>## <span style='color: #555555;'># A tibble: 6 × 2</span>
##   word     lexicon
##   <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>    <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>  
## <span style='color: #555555;'>1</span> younger  onix   
## <span style='color: #555555;'>2</span> youngest onix   
## <span style='color: #555555;'>3</span> your     onix   
## <span style='color: #555555;'>4</span> yours    onix   
## <span style='color: #555555;'>5</span> you’re   added  
## <span style='color: #555555;'>6</span> 1        added
</code></pre>


새로 만든 불용어사전으로 정체한 후 단어 빈도를 계산해보자.


```r
tibble(text = text_v) %>%
  unnest_tokens(output = word, input = text) %>% 
  anti_join(stop_words2) %>% 
  count(word, sort = TRUE)
```

<pre class="r-output"><code>## <span style='color: #555555;'># A tibble: 8 × 2</span>
##   word          n
##   <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>     <span style='color: #555555; font-style: italic;'>&lt;int&gt;</span>
## <span style='color: #555555;'>1</span> desire        1
## <span style='color: #555555;'>2</span> earthly       1
## <span style='color: #555555;'>3</span> existence     1
## <span style='color: #555555;'>4</span> fascinate     1
## <span style='color: #555555;'>5</span> influence     1
## <span style='color: #555555;'>6</span> inspire       1
## <span style='color: #555555;'># … with 2 more rows</span>
</code></pre>

"you’re"와 숫자가 모두 제거됐다. 




#### 불용어 사전 수정2

통상적으로 쓰이는 불용어 중에는 실은 문서의 의미를 파악하는데 중요한 단서를 제공하는 단어도 있다. "you" "me" "my" 등과 같은 대명사는 흔하게 사용되기 때문에 불용어로 분류되지만, 맥락를 파악하는데 중요한 역할을 하기도 한다. 불용어 사전에서 대명사를 찾아 불용어 사전에서 제거하자. 


```r
stop_words$word %>% 
  str_subset("(^i$|^i[:punct:]+|^mys*|^me$|mine)")
```

<pre class="r-output"><code>##  [1] "i"      "i'd"    "i'll"   "i'm"    "i've"   "me"    
##  [7] "my"     "myself" "i"      "me"     "my"     "myself"
## [13] "i'm"    "i've"   "i'd"    "i'll"   "i"      "me"    
## [19] "my"     "myself"
</code></pre>

```r
stop_words3 <- stop_words %>% 
  filter(
    !str_detect(word, "(^i$|^i[:punct:]+|^mys*|^me$|^mine$)"),
    )
stop_words3$word %>% 
  str_subset("^i")
```

<pre class="r-output"><code>##  [1] "ie"          "if"          "ignored"     "immediate"  
##  [5] "in"          "inasmuch"    "inc"         "indeed"     
##  [9] "indicate"    "indicated"   "indicates"   "inner"      
## [13] "insofar"     "instead"     "into"        "inward"     
## [17] "is"          "isn't"       "it"          "it'd"       
## [21] "it'll"       "it's"        "its"         "itself"     
## [25] "it"          "its"         "itself"      "is"         
## [29] "it's"        "isn't"       "if"          "into"       
## [33] "in"          "if"          "important"   "in"         
## [37] "interest"    "interested"  "interesting" "interests"  
## [41] "into"        "is"          "it"          "its"        
## [45] "itself"
</code></pre>


#### 불용어 목록 만들기

제거하고 싶은 불용어를 최소화하고 싶을 때는 불용어 목록을 직접 만들수도 있다. "the, for, and"등이 포함된 불용어 목록을 만들어 정제해 보자. "the, for, and"등 불용어목록을 데이터프레임에 저장한 다음, `anti_join()`함수를 이용해 토큰데이터프레임과 배제결합한다. 



```r
stop_df <- tibble(word = c("the","for", "and"))

tibble(text = text_v) %>% 
  unnest_tokens(output = word, input = text) %>% 
  anti_join(stop_df) %>% 
  filter(!str_detect(word, "\\d+")) %>% 
  count(word, sort = TRUE)
```

<pre class="r-output"><code>## <span style='color: #555555;'># A tibble: 15 × 2</span>
##   word        n
##   <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>   <span style='color: #555555; font-style: italic;'>&lt;int&gt;</span>
## <span style='color: #555555;'>1</span> me          2
## <span style='color: #555555;'>2</span> my          2
## <span style='color: #555555;'>3</span> you         2
## <span style='color: #555555;'>4</span> better      1
## <span style='color: #555555;'>5</span> desire      1
## <span style='color: #555555;'>6</span> earthly     1
## <span style='color: #555555;'># … with 9 more rows</span>
</code></pre>




### `filter()`

`filter()`함수를 이용해 불용어사전을 수정하지 않고 불용어를 추가로 제거할 수 있다. 

예를 들어, 숫자를 불용어로 취급해 제거하는 상황에서 숫자를 불용어 사전에 넣지 말고 `filter()`로 걸러보자. 정규표현식(regex: regular expression)에서 숫자를 의미하는 `[:digit:]` 또는 `\\d`를 이용해 `filter()`함수와 `str_detect()`함수 및 부정연산자 `!`를 이용해 걸러낸다. 

`filter()`함수를 `str_detect()`함수와 함께 이용하는 이유는 다음과 같다. 

`str_subset()`함수는 패턴이 일치하는 문자를 출력하는 반면, `str_detect()`함수는 패턴이 일치하는 문자에 대한 논리값(TRUE or FALSE)을 출력한다. 


```r
df <- tibble(text = text_v) %>%
  unnest_tokens(output = word, input = text) %>% 
  anti_join(stop_words)
df$word %>% str_subset(pattern = "\\d+")
```

<pre class="r-output"><code>## [1] "1"
</code></pre>

```r
df$word %>% str_detect(pattern = "\\d+")
```

<pre class="r-output"><code>##  [1] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
## [10] FALSE
</code></pre>


불용어를 제거한 다음 추가로 본문에서 숫자와 홑낫표"’"가 포함된 문제를 제거하자. 


```r
tibble(text = text_v) %>%
  unnest_tokens(output = word, input = text) %>% 
  anti_join(stop_words) %>% 
  filter(
    !str_detect(word, pattern = "\\d+"),
    !str_detect(word, pattern = "you’re")
    ) %>% 
  count(word, sort = TRUE)
```

<pre class="r-output"><code>## <span style='color: #555555;'># A tibble: 8 × 2</span>
##   word          n
##   <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>     <span style='color: #555555; font-style: italic;'>&lt;int&gt;</span>
## <span style='color: #555555;'>1</span> desire        1
## <span style='color: #555555;'>2</span> earthly       1
## <span style='color: #555555;'>3</span> existence     1
## <span style='color: #555555;'>4</span> fascinate     1
## <span style='color: #555555;'>5</span> influence     1
## <span style='color: #555555;'>6</span> inspire       1
## <span style='color: #555555;'># … with 2 more rows</span>
</code></pre>






## 정규화(Normalization)

### 개괄

정규화는 추출한 단어를 일정한 틀로 규격화하는 작업이다. 한 단어는 문법적인 기능에 따라 다양한 표현이 있다. '먹다'에는 '먹었니' '먹었다' '먹고' 등의 표현이 있다. 'I'는 격에 따라 'my' 'me' 'mine' 등의 변형이 있다. 다양한 표현이 같은 의미를 나타낸다면 정규화를 통해 일정한 틀로 규격화해야 한다. 

정규화는 형태소(morpheme) 추출, 어간(stem) 추출, 표제어(lemme) 추출 등을 이용해 달성할 수 있다. 

 - 단어(word): 형태소의 집합. 자립이 가능한 최소 형태(예: 사과나무)
 - 형태소(morpheme): 뜻을 지닌 가장 작은 말의 단위. 예를 들어, '사과나무'는 '사과'와 '나무'로 나눠도 뜻을 지니지만, '사과'를 '사'와 '과'로 나누면 의미가 사라진다. 
 - 어기(base): 어근과 어간 등 단어에서 실질적인 의미를 나타내는 형태소
   - 어근(root) 어미와 직접결합이 안되는 어기. 예: '급하다'의 '급' '시원하다'의 '시원'. 
   - 어간(stem) 어미와 직접결합이 되는 어기. 예: '뛰어라'의 '뛰-'. '먹다'의 '먹-'.
 - 표제어(lemme) 사전에 등재된 대표단어. 원형 혹은 기본형(canonical form)이라고도 한다. 



### 형태소(morpheme)

형태소는 뜻을 지난 가장 작은 말의 단위다. 
'바지가 크다'는 문장에서 단어는 '바지' '가' '크다'가 있다. 형태소는 '바지' '가' '크' '다'로 구분할 수 있다. 명사인 '바지'를 '바'와 '지'로 나누면 '아랫도리에 입는 옷'이란 의미가 사라진다. 반면 형용사인 '크다'에는 어간인 '크-'에 '크다'는 의미가 담겨 있고, '-다'에는 문장을 마무리하는 의미가 담겨 있다. 


##### 품사태깅(Parts of Speech Tagging: PoS Tagging)

형태소를 추출하기 위해서 문장의 단어에 품사를 붙인다(tag). 

형태소 분석기마다 품사태깅의 방법이 조금씩 다르다. 한나눔(Hannaum)은 크게 9개 품사로 분류한뒤 22개로 세부 분류했다. Mecab-ko는 43개로 분류했다. 

 - [한국어 품사 태그 비교표](https://docs.google.com/spreadsheets/d/1OGAjUvalBuX-oZvZ_-9tEfYD2gQe7hTGsgUpiiBSXI8/edit#gid=0)




한나눔과 MeCab-ko의 품사태그 (Table \@ref(tab:postag)). 


<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:postag)한나눔과 MeCab-ko의 한국어 품사 태그 비교</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Hannanum09 </th>
   <th style="text-align:left;"> (ntags=9) </th>
   <th style="text-align:left;"> Hannanum22 </th>
   <th style="text-align:left;"> (ntags=22) </th>
   <th style="text-align:left;"> Mecab-ko </th>
   <th style="text-align:left;"> (ntags=43) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Tag </td>
   <td style="text-align:left;"> Description </td>
   <td style="text-align:left;"> Tag </td>
   <td style="text-align:left;"> Description </td>
   <td style="text-align:left;"> Tag </td>
   <td style="text-align:left;"> Description </td>
  </tr>
  <tr>
   <td style="text-align:left;"> N </td>
   <td style="text-align:left;"> 체언 </td>
   <td style="text-align:left;"> NC </td>
   <td style="text-align:left;"> 보통명사 </td>
   <td style="text-align:left;"> NNG </td>
   <td style="text-align:left;"> 일반 명사 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> NQ </td>
   <td style="text-align:left;"> 고유명사 </td>
   <td style="text-align:left;"> NNP </td>
   <td style="text-align:left;"> 고유 명사 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> NB </td>
   <td style="text-align:left;"> 의존명사 </td>
   <td style="text-align:left;"> NNB </td>
   <td style="text-align:left;"> 의존 명사 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> NNBC </td>
   <td style="text-align:left;"> 단위를 나타내는 명사 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> NN </td>
   <td style="text-align:left;"> 수사 </td>
   <td style="text-align:left;"> NR </td>
   <td style="text-align:left;"> 수사 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> NP </td>
   <td style="text-align:left;"> 대명사 </td>
   <td style="text-align:left;"> NP </td>
   <td style="text-align:left;"> 대명사 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> P </td>
   <td style="text-align:left;"> 용언 </td>
   <td style="text-align:left;"> PV </td>
   <td style="text-align:left;"> 동사 </td>
   <td style="text-align:left;"> VV </td>
   <td style="text-align:left;"> 동사 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> PA </td>
   <td style="text-align:left;"> 형용사 </td>
   <td style="text-align:left;"> VA </td>
   <td style="text-align:left;"> 형용사 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> PX </td>
   <td style="text-align:left;"> 보조 용언 </td>
   <td style="text-align:left;"> VX </td>
   <td style="text-align:left;"> 보조 용언 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> VCP </td>
   <td style="text-align:left;"> 긍정 지정사 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> VCN </td>
   <td style="text-align:left;"> 부정 지정사 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> M </td>
   <td style="text-align:left;"> 수식언 </td>
   <td style="text-align:left;"> MM </td>
   <td style="text-align:left;"> 관형사 </td>
   <td style="text-align:left;"> MM </td>
   <td style="text-align:left;"> 관형사 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> MA </td>
   <td style="text-align:left;"> 부사 </td>
   <td style="text-align:left;"> MAG </td>
   <td style="text-align:left;"> 일반 부사 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> MAJ </td>
   <td style="text-align:left;"> 접속 부사 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> I </td>
   <td style="text-align:left;"> 독립언 </td>
   <td style="text-align:left;"> II </td>
   <td style="text-align:left;"> 감탄사 </td>
   <td style="text-align:left;"> IC </td>
   <td style="text-align:left;"> 감탄사 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> J </td>
   <td style="text-align:left;"> 관계언 </td>
   <td style="text-align:left;"> JC </td>
   <td style="text-align:left;"> 격조사 </td>
   <td style="text-align:left;"> JKS </td>
   <td style="text-align:left;"> 주격 조사 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> JKC </td>
   <td style="text-align:left;"> 보격 조사 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> JKG </td>
   <td style="text-align:left;"> 관형격 조사 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> JKO </td>
   <td style="text-align:left;"> 목적격 조사 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> JKB </td>
   <td style="text-align:left;"> 부사격 조사 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> JKV </td>
   <td style="text-align:left;"> 호격 조사 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> JKQ </td>
   <td style="text-align:left;"> 인용격 조사 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> JC </td>
   <td style="text-align:left;"> 접속 조사 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> JX </td>
   <td style="text-align:left;"> 보조사 </td>
   <td style="text-align:left;"> JX </td>
   <td style="text-align:left;"> 보조사 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> JP </td>
   <td style="text-align:left;"> 서술격 조사 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> E </td>
   <td style="text-align:left;"> 어미 </td>
   <td style="text-align:left;"> EP </td>
   <td style="text-align:left;"> 선어말어미 </td>
   <td style="text-align:left;"> EP </td>
   <td style="text-align:left;"> 선어말어미 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> EF </td>
   <td style="text-align:left;"> 종결 어미 </td>
   <td style="text-align:left;"> EF </td>
   <td style="text-align:left;"> 종결 어미 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> EC </td>
   <td style="text-align:left;"> 연결 어미 </td>
   <td style="text-align:left;"> EC </td>
   <td style="text-align:left;"> 연결 어미 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> ET </td>
   <td style="text-align:left;"> 전성 어미 </td>
   <td style="text-align:left;"> ETN </td>
   <td style="text-align:left;"> 명사형 전성 어미 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> ETM </td>
   <td style="text-align:left;"> 관형형 전성 어미 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> X </td>
   <td style="text-align:left;"> 접사 </td>
   <td style="text-align:left;"> XP </td>
   <td style="text-align:left;"> 접두사 </td>
   <td style="text-align:left;"> XPN </td>
   <td style="text-align:left;"> 체언 접두사 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> XS </td>
   <td style="text-align:left;"> 접미사 </td>
   <td style="text-align:left;"> XSN </td>
   <td style="text-align:left;"> 명사파생 접미사 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> XSV </td>
   <td style="text-align:left;"> 동사 파생 접미사 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> XSA </td>
   <td style="text-align:left;"> 형용사 파생 접미사 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> XR </td>
   <td style="text-align:left;"> 어근 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> S </td>
   <td style="text-align:left;"> 기호 </td>
   <td style="text-align:left;"> S </td>
   <td style="text-align:left;"> 기호 </td>
   <td style="text-align:left;"> SF </td>
   <td style="text-align:left;"> 마침표, 물음표, 느낌표 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> SE </td>
   <td style="text-align:left;"> 줄임표 … </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> SSO </td>
   <td style="text-align:left;"> 여는 괄호 (, [ </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> SSC </td>
   <td style="text-align:left;"> 닫는 괄호 ), ] </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> SC </td>
   <td style="text-align:left;"> 구분자 , · / : </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> SY </td>
   <td style="text-align:left;"> 기타 기호 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> SH </td>
   <td style="text-align:left;"> 한자 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> SL </td>
   <td style="text-align:left;"> 외국어 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> SN </td>
   <td style="text-align:left;"> 숫자 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> F </td>
   <td style="text-align:left;"> 외국어 </td>
   <td style="text-align:left;"> F </td>
   <td style="text-align:left;"> 외국어 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
</tbody>
</table>



 







### 형태소 추출

정규화는 형태소를 추출해 달성할 수 있다. R의 대표적인 형태소 분석기로는 `RcppMeCab`와 `KoNLP`가 있다. 


#### `RcppMeCab`

한국어뿐 아니라 일본어와 중국어 형태소 분석도 가능하고 실행속도가 빠르다.  
 일본교토대학정보학연구대학원과 일본전신전화의 커뮤니케이션기본과학연구소가 공동으로 개발한 오픈소스 형태소 분석기 [`MeCab`](https://taku910.github.io/mecab/) 기반이다.  [은전](https://bitbucket.org/eunjeon/mecab-ko-dic/src/master/) 프로젝트로 한국어 형태소를 분석할수 있게 개발했다. [`RcppMeCab`패키지](https://github.com/junhewk/RcppMeCab)는 `MeCab`을 R에서 사용할 수 있도록 한 패키지다. 일본어 기반이라 띄어쓰기에 덜 민감하다. 


#### `KoNLP`

Java 기반의 한나눔(Hannanum) 분석기 기반이다. 널리 사용되는 형태소분석기다. NIADic, Sejong등 사전을 선택할 수 있다. [사용설명서](https://github.com/haven-jeon/KoNLP/blob/master/etcs/KoNLP-API.md)가 있고, 사용자 사전을 수정하기 용이하다. 





### RcppMeCab

`RcppMeCab`패키지를 설치하고 실행하자. 설치되는 기본폴더는 `C:\mecab`다. 설치폴더를 변경하지 않는다. 


```r
install.packages('RcppMeCab')
```

 **주의**
 
C드라이브에 `C:\mecab`폴더가 생성됐는지 확인한다. 사전파일이 이곳에 있다. 만일 `C:\mecab`폴더가 생성되지 않았다면 설치가 안된것이다. RStudio를 관리자권한으로 실행해 설치한다. 

만일, RStudio를 관리자권한으로 실행해 설치해도 `C:\mecab`가 생성되지 않는경우, [이 링크](https://1drv.ms/u/s!AkK5d7f0xyCHkH1yCmXI_sHq4T8V?e=uZWpey)에서 사전파일을 다운로드 받아 파일을 압축해제해 복사한다. `C:\mecab`가 생성되고, 이 폴더 바로  아래에 `libmecab.dll`파일과 `mecab-ko-dic`폴더가 생성돼 있어야 한다. 

기본함수는 `pos()`다. 문자벡터를 받아 리스트로 산출한다. 


```r
library(RcppMeCab)
test <- "한글 테스트 입니다."
pos(test)
```

<pre class="r-output"><code>## $`한글 테스트 입니다.`
## [1] "한글/NNG"      "테스트/NNG"    "입니다/VCP+EF"
## [4] "./SF"
</code></pre>

한글이 깨지는 경우가 있는데, 이는 한글인코딩 방식이 맞지 않기 때문이다. 윈도는 EUC-KR방식을 확장한 CP949방식을 사용하기 때문에 UTF-8방식과 호환이 안된다. 이 경우 `enc2utf8`함수를 이용해 한글인코딩 방식을 UTF-8으로 변경한다. 



```r
library(tidyverse)
test_v <- enc2utf8(test)
test_v %>% pos
```

<pre class="r-output"><code>## $`한글 테스트 입니다.`
## [1] "한글/NNG"      "테스트/NNG"    "입니다/VCP+EF"
## [4] "./SF"
</code></pre>

참고: UTF-8을 CP949로 인코딩을 바꾸고 싶으면 `iconv`함수를 이용한다. 


```r
iconv(x, from = "UTF-8", to = "CP949")`
```

`x`는 문자벡터. 자세한 사용법은 `?iconv` 참조. 

#### `join = FALSE`

`join = FALSE`인자를 이용하면 품사태그를 제외하고 형태소만 산출한다. 


```r
test_v %>% pos(join = FALSE)
```

<pre class="r-output"><code>## $`한글 테스트 입니다.`
##      NNG      NNG   VCP+EF       SF 
##   "한글" "테스트" "입니다"      "."
</code></pre>


#### `format = "data.frame"`

`format = "data.frame"`을 지정하면 데이터프레임으로 산출한다.


```r
test_v %>% pos(format = "data.frame")
```

<pre class="r-output"><code>##   doc_id sentence_id token_id  token    pos subtype
## 1      1           1        1   한글    NNG        
## 2      1           1        2 테스트    NNG    행위
## 3      1           1        3 입니다 VCP+EF        
## 4      1           1        4      .     SF
</code></pre>

#### `posParallel(x)`

`posParallel()`함수는 메모리를 많이 사용하지만 처리속도가 빠르다. 


```r
test_v %>% posParallel(format = "data.frame")
```

<pre class="r-output"><code>##   doc_id sentence_id token_id  token    pos subtype
## 1      1           1        1   한글    NNG        
## 2      1           1        2 테스트    NNG    행위
## 3      1           1        3 입니다 VCP+EF        
## 4      1           1        4      .     SF
</code></pre>






### `KoNLP`

형태소 분석기 한나눔(Hannanum)을 R에서 사용할 수 있도록한 패키지다. CRAN에서 내려져 있기 때문에 [개발자 깃헙](https://github.com/haven-jeon/KoNLP)에서 `remote`패키지의 `install_github()`함수를 이용해 설치한다. 

`KoNLP`를 설치하기 위해서는 자바와 `rtools`가 필요하다. 

#### 자바JDK

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


#### `rtools`

1. CRAN의 [`rtools`페이지](https://cran.r-project.org/bin/windows/Rtools/)에 접속한다.

2. 설치된 R버전과 일치하는 버전의 `rtools`를 다운로드받는다. R이 4.0대 버전이면 `rtools40`을 설치한다. 

- `rtools`는 다른 패키지와 달리 `install.packages()`함수로 설치하지 않고, 설치파일을 컴퓨터에서 직접 실행해 설치한다. 

3. 설치할때 경로변경하지 말고 `C:/Rtools`에 설치한다. 실치과정에서 `Add rtools to system PATH`가 체크돼 있는지 확인한다. 

- 기타 KoNLP 설치이슈에 대해서는 [이 문서](https://www.facebook.com/notes/r-korea-krugkorean-r-user-group/konlp-%EC%84%A4%EC%B9%98-%EC%9D%B4%EC%8A%88-%EA%B3%B5%EC%9C%A0/1847510068715020/) 참조


#### 의존패키지

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




### `KoNLPy`

형태소 분석기로는 한나눔(Hannanum)과 MeCab외 꼬꼬마(Kkma), 코모란(Komoran), Okt 등의 형태소는 파이썬 패키지인 `KoNLPy`로 추출가능하다. 

구글 colab에서 파이썬을 구동하면 `KoNLPy`패키지를 설치해 다양한 패키지로 형태소를 분석할 수 있다. 








### 연습

이상의 `오감도`를 `KoNLP`와 `RcppMeCab`을 이용해 각각 형태소분석해 자주 사용된 단어의 빈도를 비교하자. 이 결과를 형태소를 추출하지 않은 결과와도 비교하자. 



```r
ogamdo_txt <- "13인의 아해가 도로로 질주하오.
(길은 막다른 골목이 적당하오.)

제1의 아해가 무섭다고 그리오.
제2의 아해도 무섭다고 그리오.
제3의 아해도 무섭다고 그리오.
제4의 아해도 무섭다고 그리오.
제5의 아해도 무섭다고 그리오.
제6의 아해도 무섭다고 그리오.
제7의 아해도 무섭다고 그리오.
제8의 아해도 무섭다고 그리오.
제9의 아해도 무섭다고 그리오.
제10의 아해도 무섭다고 그리오.
제11의 아해가 무섭다고 그리오.
제12의 아해도 무섭다고 그리오.
제13의 아해도 무섭다고 그리오.
13인의 아해는 무서운 아해와 무서워하는 아해와 그렇게뿐이 모였소.(다른 사정은 없는 것이 차라리 나았소)

그중에 1인의 아해가 무서운 아해라도 좋소.
그중에 2인의 아해가 무서운 아해라도 좋소.
그중에 2인의 아해가 무서워하는 아해라도 좋소.
그중에 1인의 아해가 무서워하는 아해라도 좋소.

(길은 뚫린 골목이라도 적당하오.)
13인의 아해가 도로로 질주하지 아니하여도 좋소."
```


#### `KoNLP`
`KoNLP`의 `SimplePos09()`함수를 `unnset_tokens()`의 `token = `인자로 투입하면 오류가 발생한다.  



```r
ogamdo_txt %>% tibble(text = .) %>% 
  unnest_tokens(word, text, token = SimplePos09)
```

문자벡터에서 형태소 추출해 데이터프레임으로 저장한다. 


```r
ogamdo_txt %>% SimplePos09() %>% flatten_dfc() %>% 
  pivot_longer(everything(), names_to = "header", values_to = "value") %>% 
  separate_rows(value, sep = "\\+") %>% 
  separate(value, into = c("word", "pos"), sep = "/") %>% 
  count(word, sort = T) %>% 
  filter(str_length(word) > 1) %>% 
  slice_max(n, n = 10) %>% 
  mutate(word = reorder(word, n)) %>% 
  ggplot() + geom_col(aes(word, n)) +
  coord_flip()
```

`KoNLP`의 ` extractNoun()`함수 이용


```r
ogamdo_txt %>% extractNoun() %>% tibble(text = .)
```


#### `RcppMeCab`

`RcppMeCab`의 `pos()`함수 이용


```r
enc2utf8(ogamdo_txt) %>% pos(format = "data.frame") %>% 
  select(token:pos) %>% 
  count(token, sort = T) %>% 
  filter(str_length(token) >1) %>% 
  slice_max(n, n = 10) %>% 
  mutate(token = reorder(token, n)) %>% 
  ggplot + geom_col(aes(token, n)) +
  coord_flip()
```

<img src="21-text-cleansing_files/figure-html/clean45-1.png" width="576" style="display: block; margin: auto;" />

`RcppMeCab`의 `pos()`함수는 `unnest_tokens()`의 `token = `인자에 투입해도 된다.


```r
ogamdo_txt %>% enc2utf8 %>% tibble(text = .) %>% 
  unnest_tokens(word, text, token = pos) %>% 
  separate(col = word, 
           into = c("word", "morph"), 
           sep = "/" ) %>% 
  count(word, sort = T) %>% 
  filter(str_length(word) > 1) %>% 
  slice_max(n, n = 10) %>% 
  mutate(word = reorder(word, n)) %>% 
  ggplot() + geom_col(aes(word, n)) +
  coord_flip()
```

<img src="21-text-cleansing_files/figure-html/clean46-1.png" width="576" style="display: block; margin: auto;" />



#### 형태소 미추출


```r
ogamdo_txt %>% tibble(text = .) %>% 
  unnest_tokens(word, text) %>% 
  count(word, sort = T) %>% 
  filter(str_length(word) > 1) %>% 
  slice_max(n, n = 10) %>% 
  mutate(word = reorder(word, n)) %>% 
  ggplot() + geom_col(aes(word, n)) +
  coord_flip()
```

<img src="21-text-cleansing_files/figure-html/clean47-1.png" width="576" style="display: block; margin: auto;" />




#### 비교

먼저 데이터프레임으로 결합한 후 행과 열 확인.


```r
KoNLP_df <- ogamdo_txt %>% SimplePos09() %>% flatten_dfc() %>% 
  pivot_longer(everything(), names_to = "header", values_to = "value") %>% 
  separate_rows(value, sep = "\\+") %>% 
  separate(value, into = c("word", "pos"), sep = "/") %>% 
  count(word, sort = T) %>% 
  filter(str_length(word) > 1) %>% 
  slice_max(n, n = 10)

MeCab_df <- ogamdo_txt %>% enc2utf8 %>% tibble(text = .) %>% 
  unnest_tokens(word, text, token = pos) %>% 
  separate(col = word, 
           into = c("word", "morph"), 
           sep = "/" ) %>% 
  count(word, sort = T) %>% 
  filter(str_length(word) > 1) %>% 
  slice_max(n, n = 10)

word_df <- ogamdo_txt %>% tibble(text = .) %>% 
  unnest_tokens(word, text) %>% 
  count(word, sort = T) %>% 
  filter(str_length(word) > 1) %>% 
  slice_max(n, n = 10)

KoNLP_df %>% glimpse()
MeCab_df %>% glimpse()
word_df %>% glimpse()
```

행의 수와 열의 이름이 같으므로 세 데이터프레임을 행방향 결합할 수 있다. 결합한 데이터프레임으로 막대도표로 시각화한다.


```r
df <- bind_rows(KoNLP = KoNLP_df, MeCab = MeCab_df, word = word_df, .id = "ID")

df %>% mutate(word = reorder(word, n)) %>% 
  ggplot() + geom_col(aes(word, n, fill = ID)) + 
  coord_flip()
```

세 경우에 대해 `ID`열로 값이 부여돼 있으므로 `facet_wrap()`함수로 구분할 수 있다. 


```r
df %>% mutate(word = reorder(word, n)) %>% 
  ggplot() + geom_col(aes(word, n, fill = ID), show.legend = F) + 
  coord_flip() +
  facet_wrap(~ID)
```

라벨을 세개의 도표에 분리해 표시하자. scales =인자를 “free”로 지정한다. 기본값은 “fixed”다.


```r
df %>% mutate(word = reorder(word, n)) %>% 
  ggplot() + geom_col(aes(word, n, fill = ID), show.legend = F) + 
  coord_flip() +
  facet_wrap(~ID, scales = "free") +
  ggtitle("형태소분석기 비교") +
  xlab("단어") + ylab("빈도") +
  theme(plot.title = element_text(size = 24, hjust = 0.5),
        axis.title.x = element_text(size = 18),
        axis.title.y = element_text(size = 18))
```






### 어간(stem) 추출



- 단어(word): 형태소의 집합. 자립이 가능한 최소 형태(예: 사과나무)

- 형태소(morpheme): 뜻을 지닌 가장 작은 말의 단위. 예를 들어, ’사과나무’는 ’사과’와 ’나무’로 나눠도 뜻을 지니지만, ’사과’를 ’사’와 ’과’로 나누면 의미가 사라진다.

- 어기(base): 어근과 어간 등 단어에서 실질적인 의미를 나타내는 형태소
  
  - 어근(root) 어미와 직접결합이 안되는 어기. 예: ‘급하다’의 ’급’ ‘시원하다’의 ’시원.’
  
  - 어간(stem) 어미와 직접결합이 되는 어기. 예: ‘뛰어라’의 ’뛰-.’ ‘먹다’의 ’먹-.’
  
- 표제어(lemme) 사전에 등재된 대표단어. 원형 혹은 기본형(canonical form)이라고도 한다.


어간추출과 표제어 추출에 대한 설명 [참고 문헌](https://smltar.com/stemming.html)




**어간추출 패키지**

- `SnowballC`

어간추출로 널리 사용되는 알고리듬인 포터 알고리듬 스테밍을 적용. 

- `hunspell`

포터알고리즘에 사전 방식 결합


`SnowballC`와 `hunspell`은 `tidytext` 등 텍스트분석 패키지와 패키지로 함께 설치되나 함께 부착되지는 않는다. 





```r
love_v <- c("love", "loves", "loved","love's" ,"lovely", 
            "loving", "lovingly", "lover", "lovers", "lovers'", "go", "went") 

SnowballC::wordStem(love_v)
```

<pre class="r-output"><code>##  [1] "love"     "love"     "love"     "love'"    "love"    
##  [6] "love"     "lovingli" "lover"    "lover"    "lovers'" 
## [11] "go"       "went"
</code></pre>

```r
hunspell::hunspell_stem(love_v)
```

<pre class="r-output"><code>## [[1]]
## [1] "love"
## 
## [[2]]
## [1] "love"
## 
## [[3]]
## [1] "loved" "love" 
## 
## [[4]]
## [1] "love"
## 
## [[5]]
## [1] "lovely" "love"  
## 
## [[6]]
## [1] "loving" "love"  
## 
## [[7]]
## [1] "loving"
## 
## [[8]]
## [1] "lover" "love" 
## 
## [[9]]
## [1] "love"
## 
## [[10]]
## character(0)
## 
## [[11]]
## [1] "go"
## 
## [[12]]
## [1] "went"
</code></pre>

`hunspell`은 리스트로 산출하므로 `unnest()`함수로 리스트구조를 풀어준다. `unnest()`는 `flatten_()`계열과 달리 데이터프레임을 입력값으로 받는다. 


```r
library(hunspell)
love_v %>% tibble(text = .) %>% unnest_tokens(word, text) %>% 
  mutate(hunspell = hunspell_stem(word)) 
```

<pre class="r-output"><code>## <span style='color: #555555;'># A tibble: 12 × 2</span>
##   word   hunspell 
##   <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>  <span style='color: #555555; font-style: italic;'>&lt;list&gt;</span>   
## <span style='color: #555555;'>1</span> love   <span style='color: #555555;'>&lt;chr [1]&gt;</span>
## <span style='color: #555555;'>2</span> loves  <span style='color: #555555;'>&lt;chr [1]&gt;</span>
## <span style='color: #555555;'>3</span> loved  <span style='color: #555555;'>&lt;chr [2]&gt;</span>
## <span style='color: #555555;'>4</span> love's <span style='color: #555555;'>&lt;chr [1]&gt;</span>
## <span style='color: #555555;'>5</span> lovely <span style='color: #555555;'>&lt;chr [2]&gt;</span>
## <span style='color: #555555;'>6</span> loving <span style='color: #555555;'>&lt;chr [2]&gt;</span>
## <span style='color: #555555;'># … with 6 more rows</span>
</code></pre>

`unnest()`로 리스트를 풀면 토큰의 수가 늘어난다. `hunspell_stem()`함수가 스테밍 전후의 단어를 모두 산출하기 때문이다. `hunspell`로 어간추출할때는 주의해야 한다. `hunspell`패키지의 목적이 텍스트분석이 아니라 철자확인이다. 



```r
library(SnowballC)
love_v %>% tibble(text = .) %>% unnest_tokens(word, text) %>% 
  mutate(SnowballC = wordStem(word)) %>% 
  mutate(hunspell = hunspell_stem(word)) %>% 
  unnest(hunspell)
```

<pre class="r-output"><code>## <span style='color: #555555;'># A tibble: 16 × 3</span>
##   word   SnowballC hunspell
##   <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>  <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>     <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>   
## <span style='color: #555555;'>1</span> love   love      love    
## <span style='color: #555555;'>2</span> loves  love      love    
## <span style='color: #555555;'>3</span> loved  love      loved   
## <span style='color: #555555;'>4</span> loved  love      love    
## <span style='color: #555555;'>5</span> love's love'     love    
## <span style='color: #555555;'>6</span> lovely love      lovely  
## <span style='color: #555555;'># … with 10 more rows</span>
</code></pre>





### 표제어(lemme) 추출 

#### 어간(stem)과 표제어(lemme)의 차이

어근은 단어의 일부로서 변하지 않는다. 예를 들어, "produced" "producing" "production"의 표제어는 "produce"이고 어근은 "produc-"다.

"me"와 "my" 그리고, "you"와 "you're"는 형태는 다르지만, 같은 의미를 공유하하고 있다. 각각 같은 의미이므로 하나로 묶어 줄 필요가 있지만, 어근추출로는 그 목적을 달성할 수 없다. 형태가 달라 어근추출처럼 규칙성을 찾을 수 없기 때문이다. 



```r
word_v <- c("love", "loves", "loved", "You", "You're", "You'll", "me", "my", "myself", "go", "went") 

SnowballC::wordStem(word_v)
```

<pre class="r-output"><code>##  [1] "love"   "love"   "love"   "You"    "You'r"  "You'll"
##  [7] "me"     "my"     "myself" "go"     "went"
</code></pre>

#### `spacyr`


표제어 추출에 사용하는 패키지는 `spacyr`이다. [사용자설명서](https://cran.r-project.org/web/packages/spacyr/vignettes/using_spacyr.html)

##### 미니콘다 설치

(아나콘다 혹은 미니콘다가 이미 컴퓨터에 설치돼 있으면 곧바로 `spacyr` 패키지 설치로 이동) 

`spacyr`은 파이썬 `spaCy`패키지를 R에서 사용할 수 있도록한 패키지이므로, `spacyr`을 이용하기 위해서는 컴퓨터에 파이썬과 필요한 패키지가 설치돼 있어야 한다. 파이썬과 자주사용하는 패키지를 한번에 설치할 수 있는 것이 아나콘다와 미니콘다이다. 

 - 아나콘다: 파이썬 + 자주 사용하는 패키지 1500여개 설치(3GB 이상 설치공간 필요)
 - 미니콘다: 파이썬 + 필수 패키지 700여개 설치(260MB 설치공간 필요)
 ([미니콘다 설치 안내](https://docs.conda.io/en/latest/miniconda.html))
 
미니콘다 설치 안내 페이지에서 본인의 운영체제에 맞는 파일을 선택해 컴퓨터에 설치한다. 관리자권한으로 설치한다 (다운로드받은 파일에 마우스커서 올려 놓고 오른쪽 버튼 클릭해 '관리자권한으로 실행' 선택)

설치후 Anaconda Prompt를 연다. 

 - 윈도화면 왼쪽 아래의 `시작`버튼을 클릭하면 윈도 시작 메뉴가 열린다. 상단 '최근에 추가한 앱'에서 Anaconda Prompt(Miniconda 3)을 클릭하면 Anaconda Prompt가 열린다. (Anaconda Powershell Prompt를 이용해도 된다) 

프롬프트가 열리면 `conda --version`을 입력한다. `conda 4.9.2`처럼 콘다의 버전 정보가 뜨면 설치에 성공. 

##### `spacyr` 패키지 설치

`spacyr` 패키지를 설치하고 구동한다. (패키지 설치할 때는 R이나 RStudio를 관리자 권한으로 실행해 설치한다.)


```r
# install.packages("spacyr")
# library(spacyr)
```

패키지를 설치하고 구동했으면 `spacy_install()`을 실행한다. 콘솔에 Proceed여부를 묻는 화면이 나면 `2: Yes`를 선택해 진행한다. 


```r
spacy_install()
```

`spacy_install()`은 시스템 파이썬(또는 아나콘다 파이썬)과는 별개로 R환경에서 파이썬을 실행할 수 있는 콘다환경이 생성된다. 

##### `reticulate` 패키지 설치

파이썬 모듈을 R환경에서 실행할 수 있도록 하는 파이썬-R 인터페이스 패키지다. 


```r
install.packages("reticulate")
```


##### `spacy_initialize()`

`spacy_initialize()`로 R에서 `spaCy`를 초기화한다. 


```r
# library(spacyr)
# spacy_initialize() 
```


##### 파이썬 설정 오류

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

###### RStudio에서 설정

1. RStudio의 `Tools` 메뉴 선택. 
2. 드롭다운 메뉴가 열리면, `Global Options` 선택
3. `Options` 창이 뜨면 왼쪽 메뉴 하단의 `Python`선택
4. `Python interpreter:`의 `Select`버튼 클릭
5. `Python interpreter`를 선택할 수 있는 창이 열리면, `spacy_initialize()`함수가 찾는 파이썬 경로 선택(예: `C:\Users\[사용자ID]\AppData\Local\r-miniconda\envs\spacy_condaenv\python.exe`)


###### `Sys.setevn()` 함수 이용

```
Sys.setenv(RETICULATE_PYTHON = "`spacy_initialize()`함수가 찾는 파이썬 경로")

예:

Sys.setenv(RETICULATE_PYTHON = "C:\Users\[사용자ID]\AppData\Local\r-miniconda\envs\spacy_condaenv\python.exe")

```

###### `reticulate::use_python()` 함수 이용

```
reticulate::use_python("`spacy_initialize()`함수가 찾는 파이썬 경로")

예: 

reticulate::use_python("C:\Users\[사용자ID]\AppData\Local\r-miniconda\envs\spacy_condaenv\python.exe")

```

###### 설정 변경 확인

`reticulate::py_config()`를 실행하면 파이썬 설정 환경을 확인할 수 있다. 

```
python: C:\Users\[사용자ID]\AppData\Local\r-miniconda\envs\spacy_condaenv\python.exe
...

```


##### `spacyr` 설치 확인


```r
# word_v <- c("love", "loves", "loved", "You", "You're", "You'll", "me", "my", "myself", "go", "went")
# 
# library(spacyr)
# spacy_initialize()
# 

# word_v %>% spacy_parse()
```

어간추출과 달리, went의 표제어인 go로 산출한다. me에 대해서는 I를 표제어로 산출하나, my에 대해서는 my를 표제어로 제시한다. 



### 연습

셰익스피어의 소네트27을 `SnowbalC`와 `spacyr`을 이용해 분석해 보자



```r
s27_v <- "Weary with toil I haste me to my bed,
The dear repose for limbs with travel tired;
But then begins a journey in my head
To work my mind when body's work's expired;
For then my thoughts, from far where I abide,
Intend a zealous pilgrimage to thee,
And keep my drooping eyelids open wide
Looking on darkness which the blind do see:
Save that my soul's imaginary sight
Presents thy shadow to my sightless view,
Which like a jewel hung in ghastly night
Makes black night beauteous and her old face new.
Lo! thus by day my limbs, by night my mind,
For thee, and for myself, no quietness find."
```

#### `SnowballC`

`unnest_tokens()`의 `token = `인자에 `wordStem()`함수를 투입하면 오류 발생.


```r
library(SnowballC)
s27_v %>% tibble(text = .) %>% 
  unnest_tokens(word, text, token = wordStem)
```


어근추츨(stemming)을 먼저 한 다음 정돈텍스트(tidy text)로 전환한다. 

 - 행(row) 하나에 토큰(token)이 하나만 할당 (one-token-per-row).   


```r
s27_v %>% SnowballC::wordStem()
```

<pre class="r-output"><code>## [1] "Weary with toil I haste me to my bed,\nThe dear repose for limbs with travel tired;\nBut then begins a journey in my head\nTo work my mind when body's work's expired;\nFor then my thoughts, from far where I abide,\nIntend a zealous pilgrimage to thee,\nAnd keep my drooping eyelids open wide\nLooking on darkness which the blind do see:\nSave that my soul's imaginary sight\nPresents thy shadow to my sightless view,\nWhich like a jewel hung in ghastly night\nMakes black night beauteous and her old face new.\nLo! thus by day my limbs, by night my mind,\nFor thee, and for myself, no quietness find."
</code></pre>

토큰화를 먼저 한 다음에 어간을 추출한다. 


```r
s27_v %>% tibble(text = . ) %>% 
  unnest_tokens(word, text) %>% 
  mutate(stemmed = wordStem(word)) %>% 
  count(stemmed, sort = T)
```

<pre class="r-output"><code>## <span style='color: #555555;'># A tibble: 81 × 2</span>
##   stemmed     n
##   <span style='color: #555555; font-style: italic;'>&lt;chr&gt;</span>   <span style='color: #555555; font-style: italic;'>&lt;int&gt;</span>
## <span style='color: #555555;'>1</span> my          9
## <span style='color: #555555;'>2</span> for         4
## <span style='color: #555555;'>3</span> to          4
## <span style='color: #555555;'>4</span> a           3
## <span style='color: #555555;'>5</span> and         3
## <span style='color: #555555;'>6</span> night       3
## <span style='color: #555555;'># … with 75 more rows</span>
</code></pre>



#### `spacyr`

`spacy_parse()`는 표제어(lemme)와 품사 태그(pos) 등의 정보가 포함된 데이터프레임으로 산출한다. 


```r
s27_v %>% spacy_parse()
```

분석에 필요한 열만 선택한다. 


```r
s27_v %>% spacy_parse() %>% 
  select(token:pos) 
```

`unnest_tokens()`로 출력 형식 통일


```r
s27_v %>% spacy_parse() %>% 
  select(token:pos) %>% 
  unnest_tokens(word, lemma) %>% 
  count(word, sort = T)
```


#### 비교

불용어를 제거하지 않고 SnowballC 및 spacyr를 이용한 정규화 결과와 정규화하지 않은 결과를 비교해보자.


```r
SnowballC_df <- s27_v %>% tibble(text = . ) %>% 
  unnest_tokens(word, text) %>% 
  mutate(stemmed = wordStem(word)) %>% 
  count(stemmed, sort = T) %>% 
  slice_max(n, n = 15)

spacyr_df <- s27_v %>% spacy_parse() %>% 
  select(token:pos) %>% 
  unnest_tokens(word, lemma) %>% 
  count(word, sort = T) %>% 
  slice_max(n, n = 15)

noNor_df <- SnowballC_df <- s27_v %>% tibble(text = . ) %>% 
  unnest_tokens(word, text) %>% 
  count(word, sort = T) %>% 
  slice_max(n, n = 15)

df <- bind_rows(SnowballC = SnowballC_df, spacyr = spacyr_df, noNor = noNor_df,
                .id = "ID")
```




```r
df %>% mutate(word = reorder(word, n)) %>% 
  ggplot() + geom_col(aes(word, n, fill = ID), show.legend = F) + 
  coord_flip() +
  facet_wrap(~ID, scales = "free") +
  ggtitle("정규화 결과 비교") +
  xlab("단어") + ylab("빈도") +
  theme(plot.title = element_text(size = 24, hjust = 0.5),
        axis.title.x = element_text(size = 18),
        axis.title.y = element_text(size = 18))
```

불용어를 제거하고 SnowballC 및 spacyr를 이용한 정규화 결과와 정규화하지 않은 결과를 비교해보자.




```r
SnowballC_df <- s27_v %>% tibble(text = . ) %>% 
  unnest_tokens(word, text) %>% 
  mutate(stemmed = wordStem(word)) %>% 
  anti_join(stop_words) %>% 
  count(stemmed, sort = T) %>% 
  head(20)

spacyr_df <- s27_v %>% spacy_parse() %>% 
  select(token:pos) %>% 
  unnest_tokens(word, lemma) %>% 
  anti_join(stop_words) %>% 
  count(word, sort = T) %>% 
  head(20)

noNor_df <- SnowballC_df <- s27_v %>% tibble(text = . ) %>% 
  unnest_tokens(word, text) %>% 
  anti_join(stop_words) %>% 
  count(word, sort = T) %>% 
  head(20)

df <- bind_rows(SnowballC = SnowballC_df, spacyr = spacyr_df, noNor = noNor_df,
                .id = "ID")
```




```r
df %>% mutate(word = reorder(word, n)) %>% 
  ggplot() + geom_col(aes(word, n, fill = ID), show.legend = F) + 
  coord_flip() +
  facet_wrap(~ID, scales = "free") +
  ggtitle("정규화 결과 비교") +
  xlab("단어") + ylab("빈도") +
  theme(plot.title = element_text(size = 24, hjust = 0.5),
        axis.title.x = element_text(size = 18),
        axis.title.y = element_text(size = 18))
```

막대도표 대신 표를 만들어 비교해 보자. 이를 위해서는 데이터프레임을 행방향으로 결합해야 한다. 

행결합하면 행의 이름이 구분할 필요가 있으므로, `unnest_tokens()`함수에서 `output = `인자를 설정할 때 해당 패키지 이름으로 설정한다.

불용어 처리 전과 후를 구분해서 비교해보자. 



```r
SnowballC_df <- s27_v %>% tibble(text = . ) %>% 
  unnest_tokens(SnowballC, text) %>% 
  mutate(SnowballC = wordStem(SnowballC)) %>% 
  count(SnowballC) %>% 
  arrange(SnowballC) %>% 
  head(40)

spacyr_df <- s27_v %>% spacy_parse() %>% 
  select(lemma) %>% 
  unnest_tokens(spacyr, lemma) %>% 
  count(spacyr) %>% 
  arrange(spacyr) %>% 
  head(40)

noNor_df <- s27_v %>% tibble(text = . ) %>% 
  unnest_tokens(noNor, text) %>% 
  count(noNor) %>% 
  arrange(noNor) %>% 
  head(40)


bind_cols(noNor_df, SnowballC_df, spacyr_df)
```



불용어 처리한 다음에도 결과를 비교해보자. 


```r
SnowballC2_df <- s27_v %>% tibble(text = . ) %>% 
  unnest_tokens(SnowballC, text) %>% 
  mutate(word = wordStem(SnowballC)) %>% 
  anti_join(stop_words) %>% 
  mutate(SnowballC = word) %>% 
  count(SnowballC) %>% 
  arrange(SnowballC) %>% 
  head(40)

spacyr2_df <- s27_v %>% spacy_parse() %>% 
  select(lemma) %>% 
  unnest_tokens(word, lemma) %>% 
  anti_join(stop_words) %>% 
  rename(spacyr = word) %>% 
  count(spacyr) %>% 
  arrange(spacyr) %>% 
  head(40)

noNor2_df <- s27_v %>% tibble(text = . ) %>% 
  unnest_tokens(word, text) %>% 
  anti_join(stop_words) %>% 
  count(word) %>% 
  arrange(word) %>% 
  head(40)


bind_cols(noNor2_df, SnowballC2_df, spacyr2_df)
```


```r
s27_v <- "Weary with toil I haste me to my bed,
The dear repose for limbs with travel tired;
But then begins a journey in my head
To work my mind when body's work's expired;
For then my thoughts, from far where I abide,
Intend a zealous pilgrimage to thee,
And keep my drooping eyelids open wide
Looking on darkness which the blind do see:
Save that my soul's imaginary sight
Presents thy shadow to my sightless view,
Which like a jewel hung in ghastly night
Makes black night beauteous and her old face new.
Lo! thus by day my limbs, by night my mind,
For thee, and for myself, no quietness find."
```


### 과제

구텐베르크 프로젝트에서 영문 문서 한편을 선택해 두 가지 방식의 정규화(`SnowballC`를 이용한 어근 추출과 `spacyr`을 이용한 표제어 추출)한 결과와 정규화하지 않은 결과를 비교한다. 

1. 막대도표로 시각화해 비교
2. 표로 만들어 비교
3. 3건의 결과에 대해 간략하게 설명





