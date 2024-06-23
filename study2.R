# csv 호출
csv1 <- read.csv("/r/r_datas/emp.csv")
head(csv1)

csv2 <- read.csv("/r/r_datas/emp2.csv", header = F) # 컬럼명 없는 경우 1행이 컬럼으로들어가므로 파라미터 지정정
head(csv2) # 6개

names(csv2) # 컬럼호출
names(csv2) <- c("id", "ename", "dept_no", "job_level",  "join_date", 
                 "gender", "base", "bonus")

head(csv2)

names(csv2)[4] <- "levels" # 컬럼명변경경
head(csv2)

emp <- csv1 # 데이터프레임복사
emp

emp$dept_no

emp$total <- emp$base + emp$bonus # 파생변수
head(emp)

emp$country <- "Korea"
head(emp)

emp$city <- ifelse(emp$dept_no==20, "Incheon","Seoul") # 조건문
emp

emp$special_bonus <-ifelse(emp$dept_no==40 | emp$job_level==3,1000,0) 
emp

# 중첩조건문 3가지
emp$pos <- ifelse(emp$job_level==1 | emp$job_level==2, "junior",
                  ifelse(emp$job_level==3 | emp$job_level==4,"intermediate","senior"))
emp$pos <- ifelse(emp$job_level %in% c(1,2), "junior",
                  ifelse(emp$job_level %in% c(3,4),"intermediate","senior"))
emp$pos <- ifelse(emp$job_level <3, "junior",
                  ifelse(emp$job_level <5,"intermediate","senior"))
emp


write.csv(emp, file = "csv1.dup.csv")














