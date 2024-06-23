library(dplyr)
emp_org <-read.csv("/r/r_datas/emp.csv")

emp <- emp_org
head(emp)

emp

emp %>%  # 결과값 : tibble (행*열)
  group_by(dept_no) %>%
  summarize(avg_base = mean(base),
            med_base = mean(base),
            sum_bonus = sum(bonus),
            no_ppl = n()) # 행의 개수를 구하는 함수

# sd : 표준편차

emp %>%
  mutate(job_level_name = ifelse(job_level<=2,"junior","senior")) %>%
  group_by(dept_no, job_level_name, gender,) %>%
  summarize(avg_base = mean(base))

emp %>%    # 순서대로 확인하면서 실행할것것
  filter(dept_no!=30) %>%
  group_by(dept_no) %>%
  mutate(pay = base + bonus) %>%
  summarize(avg = mean(pay)) %>%
  arrange(desc(avg))%>%
  select(dept_no)%>% 
  head(1)
  

# 데이터 합치기 : join
month.name
month.abb  

m1 <- data.frame(id = 1:3,
                 kname = c("1월","2월","3월"),
                 name = month.name[1:3])

m2 <- data.frame(id=4:12,
                 name = month.name[4:12])
a1 <- data.frame(abb = month.abb[3:1],  # 순서가 변경될 경우 matching이이상하게 될 수 있음
                 num = 3:1)  # id도 동일하게 순서를 맞추어 정렬시켜줌
a2 <- data.frame(abb = month.abb[2:5])

rbind(m1,m2)

cbind(m1,a1)

bind_rows(m1,m2) # 컬럼수가 달라도 합칠 수 있는 함수/ 컬럼순서가 바뀌면 NA로 채워지며 출력됨

cbind(m2,a2) # 길이가 달라 error

left_join(m1,a1, by="id")
left_join(m1,a1, by=c("id"="num")) # 변수명이 다른경우

d1 <- data.frame(name = c("Minji","Sojin", "Hyunwoo", "Kitoe"),
                 bday = c("1980-01-02","1982-05-06","1988-02-04","1993-04-07"),
                 job = c("Accountant", "Analysis","Developer","CEO"))
d2 <- data.frame(name = c("Minji","Sojin", "Hyunwoo", "Kitoe"),
                 bday = c("2001-03-30","1982-05-06","2003-09-22","1993-04-07"),
                 city = c("Seoul", "Daegu","Gwangju","Jeju"))

inner_join(d1,d2,by=c("name","bday"))

dept <- data.frame(dept_no = c(10,30,40,50),
                   dept_name =c("Sales", "Operation", "HR", "Research"))
loc <- data.frame(dept_no = c(10,30,40,50,60),
                  location = c("Seoul","Incheon","Busan","Jeonju","Daejeon"))

extra_info <- full_join(dept,loc, by="dept_no")

inner_join(emp,extra_info, by="dept_no") 

left_join(emp,extra_info, by="dept_no") 

m1 <- data.frame(id = 1:4,
                 name = month.name[1:4])

m2 <- data.frame(id = 3:7,
                 name = month.name[3:7])

m3 <- data.frame(id = 3:7,
                 name = month.name[3:7],
                 kname = c("3월","4월","5월","6월","7월"))

rbind(m1,m2)
bind_rows(m1,m3)

union(m1,m2)
intersect(m1,m2) # 교집합합
setdiff(m1,m2) # 차집합
setdiff(m2,m1)

emp
# 3명의 사원정보가 emp format에 맞추어 있는 경우와 그렇지 않은 경우
new_emp1 <- data.frame(id=c(6701,6702,6703),
                       ename = c("jyang","kkim","olee"),
                       dept_no = c(10,30,30),
                       job_level = c(3,2,1),
                       join_date = c("2023-08-01","2023-08-01","2023-08-01"),
                       gender = c("M","F","M"),
                       base = c(3500,5000,5500),
                       bonus = c(100,150,100))
new_emp2 <- data.frame(id= 6704:6706,
                       ename = c("mkim","ylee","oyeom"),
                       gender = c("F","F","M"))

all_emp <- union(emp, new_emp1)
all_emp <- bind_rows(all_emp, new_emp2)

tail(all_emp)

# 프로젝트 a,b에 참여하는 사원원
a <- all_emp %>%
  filter(id %in% c(6003,6163,6018,6302,6224))

b <- all_emp %>%
  filter(dept_no %in% c(30,40))

intersect(a,b)
union(a,b)
setdiff(a,b)
setdiff(b,a)


# 유용한 함수들
# 1) all.equal()
emp_org <-read.csv("/r/r_datas/emp.csv")

emp <- emp_org


all.equal(emp,emp_org) # 두 df가 같은지

emp1 <- emp %>% # 컬럼의 순서가 변경된 경우 -> 정보가 다른것으로 인식됨됨
  select("id", "ename" ,"dept_no", "job_level", "join_date", "base", "bonus", "gender")

all.equal(emp1,emp)

emp2 <- emp %>%
  filter(gender=="M")

all.equal(emp2,emp)

# 2) lead() : 차를 구할 때 
emp %>%
  group_by(job_level) %>%
  summarize(avg = mean(base)) %>%
  mutate(next_avg = lead(avg),
         diff = next_avg-avg) 

data.frame(emp %>%
  group_by(job_level) %>%
  summarize(avg = mean(base)) %>%
  mutate(next_avg = lead(avg),
         diff = next_avg-avg)) # 서식적용되지 않고 float타입으로 출력

# 3) lag()
emp %>%
  group_by(dept_no, job_level) %>%
  summarize(avg = mean(base)) %>%
  mutate(prev_avg = lag(avg),
         diff = prev_avg-avg) #tibble : 그룹이 달라지면 적용하지 않음음

df_emp <- data.frame(emp %>%
  group_by(dept_no, job_level) %>%
  summarize(avg = mean(base), .groups = 'drop') %>%
  select(dept_no, job_level, avg))

df_emp %>%
  mutate(prev_avg = lag(avg),
         diff = prev_avg-avg) # tibbl이 적용되지 않은 식식
  
# 4) 순위 : row_number(), 
# min_rank() : 동일한 순위는 동일숫자로
# dense_rank() : 동일한 순위는 동일숫자, 이후 그 다음 숫자부여여 
v1 <- c(20,10,30,40,50)
v2 <- c(10,20,30,30,30,40,NA) # NA는 순위부여되지 않고, NA로 나옴옴

row_number(v2)
min_rank(v2)
dense_rank(v2)

emp
emp %>%
  arrange(desc(base), desc(bonus)) %>%
  mutate(rank1 = row_number(desc(base)),
         rank2 = min_rank(desc(base)),
         rank3 = dense_rank(desc(base)))

# 5) 누적합 평균균 : cummean()
emp %>%
  arrange(join_date) %>%
  group_by(gender) %>%
  arrange(gender) %>%
  mutate(cum_base = cummean(base))

