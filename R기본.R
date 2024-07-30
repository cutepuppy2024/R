
a<-"안녕하세요"
print(a)
cat(a,"인사","하자")

b<-"안녕"

# 변수목록
ls()
ls.str()

rm(a) # 변수 삭제
rm(list=ls(all=True)) # 모든 변수를 메모리에서 삭제제

j<-c(1,3,5) # 벡터 생성
k<-c("가","나")
l<-c("true","false")

m<-seq(from=0, to=30, by=3)
n<-seq(from=0, to=20, length.out=5)

rep(1,time=5)
rep(1:4,time=2)
rep(1:4,each=2)

p<-paste("a","b","c", sep="-")
q<-paste("d","e",sep="-")
paste("rainbow","is","beautiful", sep=" ")
paste(j, "all", collapse=", and ")

cbind(a,b)

paste(p,q,sep="/")
paste(q,10,sep="")

substr("dataAnalysis",5,10)


a<-T # True
b<-F # False


j<-c(1,3,5) # 벡터
j[1] # 벡터의 원소 자리수
j[-1] # 벡터의 제외하고자 하는 원소 자리수
j[c(1,2)] # 벡터의 1,2번째 원소
j2<-c(10,30,50); names(j2)<-c("M","L","C")
j2["L"]

list("T","K","L") 
L[[2]] # 리스트의 원소 자리수
L[c(1,2)] # 벡터의 1,2번째 원소
L$Karen # 리스트의 원소 값
data.frame(x=1:5, y=c("t","k","l"))
comb<- stack(list(v1=v1,v2=v2)) # 여러벡터를 합쳐 하나의 벡터와 요인으로 만들기
L[["name"]] <-null # 리스트 원소 제거
L[sapply(L,is.null)] <-null # 리스트에서 null값 제거
L[L==o] <-null
L[is.na(L)] <-null

factor(c("a","b","c"))

matrix(data, 2,3) #행렬
a<- matrix(data,2,3)
b<- matrix(0,4,5)
c<-matrix(1:20,4,5)

dim(c) # 차원
diag(c) # 대각행렬
t(c) # 전치행렬
solve(c) # 역

d<-matrix(1:20,5,4)
c %*% d # 행렬의 곱
c*3 # 행렬의 상수곱곱

rownames(a)<-c("행이름",...)
colnames(b)<-c("열이름",...)

f+f # 행렬간 계산
f-f
f+1
f-1

vec<-matrix[1,] # 행,렬 선택
vex<-matrix[,3]

# 데이터프레임

dfm <-data.frame(v1,v2,v3) #열로 데이터 프레임만들기
dfm <-as.data.frame(list.of.vectors)

#행결합 : 행의 개수가 동일해야함
newdata<-rbind(dfrm1,dfrm2)
#열결합 : 열의 개수와 열의 이름이 동일해야함
newdata<-cbind(dfrm1,dfrm2)

# 데이터프레임 할당
N=1000
dfm <-data.frame(dosage=numeric(N),lab=character(N), respones=numeric(N))

# 조회
dfm[dfm$name="Leo"]
dfm[dfm$a>3,b>4,c(p,q)] # a,b조건을 만족하는 변수 c,d를 조회
dfm[grep("Amy", dfm$a,ignore.case=T),c(p,q)] #"amy"가 들어있는 변수 a내에서 p,q값 조회

# 데이터셋 조회
subset(dfm,select=a) 
subset(dfm, a>60)

# 데이터 병합 
merge(df1,df2, by="df1과 df2의 공통열이름", all=T)


# 열 이름조회
colnames("나이")

# 행,열 선택
subset(dfm,select="나이")
subset(dfm,select=c("나이","성별"))
subset(dfm, select="나이",sebset=(조건))

# 이름으로 열 제거
subset(dfm, select=-"나이")

# 열이름 바꾸기 
colnames(dfm) <- "gender"

# 결측치 처리리
na.omit(dfm) # NA있는 행 삭제
complete.cases() # 결측값이 있으면 False, 없으면 True
is.na() # 결측치를 NA로 인식, 있으면 True
centralImputation() # (DMwR 패키지) NA 값에 가운데값으로 대치, 숫자는 median, factor는 최빈값
knnImputation() # (DMwR 패키지) NA값을 knn값으로 대치
Amelia() # RandomForest패키지의 rfImpute() 함수를 활용하여 NA 값 대치후 알고리즘에 적용



# 함수적용
sapply(a,log) # a 변수에, 연산 적용, 결과를 벡터/행렬 형태로 반환
lapply(l,func) # 결과를 리스트 형태로 반환
apply(mat,1,func)
lapply(dfm,func)
sapply(dfm,func)
apply(dfm, func) # 데이터 프레임이 동질적인 경우만 활용가능(행렬로 변환 후 함수 적용)
tapply(vec,factor,func) # 데이터가 집단에 속해있을 때(factors) 
by(dfm, factor, func) # 행집단 함수
model(dfm, factor, function(df) lm(종속변수 ~ 독립변수1+......,data=df))
mapply(factor, vec1, vec2....)


sd() # 표준편차
var() # 분산
cov(,) # 공분산
cor(,) # 상관계수

pi
print(pi, digits=5) # 자릿수
cat(format(pi,digits=5),"\n")

dir="/r/practice_r/" # / or \\
list.files(path=dir)
list.files(recursive = T, all.files=T)

read.csv("anemia", header=T)
read.csv("http://.....")
read.table("")
load("anemia.R")
source("anemia.R")

write.csv(dfm,"anemia.csv", col.names = F) # 파일로 저장

save(a, file="a.rdata") # R파일로 저장




library(XML)
url<-""
readHTML(url)

lines<-readLines("a.txt", n=n)


