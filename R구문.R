with(dfm, expr)
attach(dfm)
detach(dfm)

as.character()
as.complex()
as.numeric()
as.double()
as.integer()
as.logical()

as.data.frame()
as.list()
as.matrix()
as.vector()


# 벡터 ->
as.list(vec)
as.matrix(vec)
as.data.frame(vec)
as.data.frame(rbind(vec)) # 1행짜리 행렬렬

# 리스트 ->
unlist(lst)
as.matrix(lst) # 1열짜리 행렬
as.matrix(rbind(lst)) #1행짜리 행렬
as.data.frame(lst)

# 행렬 ->
as.vector(mat)
as.list(mat)
as.data.frame(mat)

# 데이터프레임 ->
dfm[[1]] / dfm[,1] # 1열짜리 데이터프레임
dfm[1,] #1행짜리 데이터프레임
as.list(dfm)


data() 
summary()
head()
install.packages()
library()
q() # 작업종료
setwd("~/") # R데이터, 파일을 로드하거나 저장할 때 워킹 디렉토리를 지정정


# 분할
g1 <-split(a,b)
g2 <-unstack(data.frame(a,b))
strsplit("사랑한다,너를",",")


nchar("words") # 문자열길이
length(j) # 벡터 j의 길이

sen = "오늘은 좋은 날, 내일도 좋은 날, 모레도 좋은 날"
sub("좋은","안좋은",sen) # 첫번째 단어만 대체
gsub("좋은","안좋은",sen) # 모든 단어 대체


# 날짜
Sys.date()
d<-as.Date("2024-12-24")
p<-as.POSIXlt(d) # calendar date and time
p$yday # 일부 추출

format(Sys.Date(), format=%m/%d/%y) 
format(Sys.Date(), '%a') # 요일 조회, 
# b 축약된 월이름 조회, B 전체 월이름 조회
# d 두자리 숫자의 일 조회, m 두자리 숫자의 월 조회
# y 두자리 숫자의 연도 조회, Y 네자리 숫자의 연도 조회

