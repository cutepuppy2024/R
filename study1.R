# 변수 생성 : <-
a <- 2
b = 0.3
a <- 1
a

c <- "hi" # 문자는 "", 안쓰면 error
d <- "hello"
f <- "1"

# 숫자변수 연산
a + b
a + 4
f+5 # 문자와 연산불가

# 여러개의 값을 변수에 넣기
v1 <- c(1,2,3) # combine
v1

v2 <- c(4:6)
v2

v3 <- seq(1,7)
v3

v4 <- seq(1,18, by = 2) # parameter : by - 2씩 증가하는 숫자
v4

v1
v2
v1 + v2

v1 + 2

v2 + v3 # 길이가 다르면 error

v1 + v4 # 배수인 경우 연산 가능 

v5 <- c("hi", "NICE", "!")
v5

# 데이터타입

var_num <- c(1,2,3,4,1,2) # 숫자형 : 연산가능
var_fac <- factor(c(1,2,3,4,1,2)) # 범주형 : 연산불가능, levels로 출력됨

var_num+1
var_fac+1

var_num
var_fac

class(var_num) # 타입확인
class(var_fac) 

var_char1 <- "abc" # 대소문자 구분
var_char2 <- "ABC" 
var_char3 <- "1"
var_char4 <- "!!"

var_char1
var_char2
var_char3
var_char4

class(var_char1)
class(var_char2)
class(var_char3)
class(var_char4)

var_char1 == var_char2 # boolean 타입으로 

var_logic1 <- T  # 내장형변수수
var_logic2 <- TRUE

var_logic1 == var_logic2

var_date1 <- as.Date("2023-05-05") # 함수수
var_date2 <- as.Date("23/05/05")

var_date1
var_date2 

var_date2 <- as.Date("23/05/05" , format = "%y/%m/%d")
var_date2

u1 <-  NULL # 비어있음
u2 <- NA # 어떤값이 분명히 있어야 하는데 빠져잇는 경우
u3 <- NaN # 수학적으로 정답불가
u4 <- Inf # 무한대표시 +/-

# 함수
x <- c(1,2,3)
mean(x)

math_score <- c(80,65,84,77,56,99,92)
mean(math_score)
max(math_score)
min(math_score)

y <- c("Hi", "I", "am", "Gina")
y

paste(y, collapse=" ")
paste(y, collapse=",")
paste(y, collapse = "")

toupper(y)
tolower(y)

paste(toupper(y),collapse=(" "))

y_edited = paste(toupper(y),collapse=(" "))
y_edited


# 패키지
install.packages("stringr")
library(stringr)
str_length("abcdefg")
?str_length # 함수의 사용법을 알고 싶을 때


# 벡터
v1 <- c(1,2,3)
v2 <- c("a","b","c")
v3 <- factor(c("a","b","c","a","b"))
v4 <- c(1,F,T,F) # 강제형변환
v5 <- c("d",1,-1) # => 문자형으로 변환

# 행렬
m1 <- matrix(1:12,3,4) # 값, 행, 열열
m1

m2 <- matrix(c("a","b","c","d"),2,3)
m2

# 배열 : 다양한 타입
a1 <- array(1:12, c(2,3,2)) # 값, c(행, 열, 개수)
a1

a2 <- array(1:12, c(1,3,4))
a2

# 데이터 프레임 : 행렬보다 유연
df1 <- data.frame(id = 1:3,
                  first_name = c("Minji", "Sara","Jahee"),
                  last_name = c("Kim", "Lee","Part"))
df1

df2 <- data.frame(v1,v2)
df2

v4 <- factor(c("a","b","c"))

df3 <- data.frame(v1,v2,v4) # 길이가 반드시 같아야 함함
df3

# 리스트 : 모든 타입 가능능
l1 <- list(v1,a1,m1,df1)
l1