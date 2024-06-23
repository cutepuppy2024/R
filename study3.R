iris # 내장데이터

nrow(iris)
ncol(iris)

dim(iris)

head(iris)
head(iris,10)

tail(iris)
tail(iris, 10)

str(iris) # structure

View(iris) # 전체데이터프레임 확인
view(iris) # 소문자 불가

names(iris) # 컬럼
class(iris) # 타입
summary(iris) # 범위확인
boxplot(iris$Sepal.Length) # 시각홧

# dplyr 라이브러리
install.packages("dplyr")
library(dplyr) # "" 안씀 , load할 때 이와 같이 씀

emp_org <- read.csv("/r/r_datas/emp.csv")
emp<- emp_org

# 행 필터링 : filter
emp %>% filter(dept_no == 10)
emp %>% filter(job_level == 3)
emp %>% filter(job_level != 5)
emp %>% filter(join_date < "2022-01-01")
emp %>% filter(base > 5000)
emp %>% filter(job_level >=4)
emp %>% filter(ename <= "e") # d 이하로 시작되는 이름명명

emp %>% filter(dept_no == 10 & gender == "M" & bonus>= 400)
emp %>% filter(base >= 5000 | bonus>=500 | dept_no == 40)

emp %>% filter(dept_no==20 | dept_no==30)
emp %>% filter(dept_no %in% c(20,30))

emp_jr <- emp %>% filter(job_level==1 | job_level==2)
emp_sr <- emp %>% filter(job_level %in% c(3,4,5))
emp_jr
emp_sr

mean(emp_jr$base)
mean(emp_sr$base)

