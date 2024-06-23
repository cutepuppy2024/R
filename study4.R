library(dplyr)

emp_org <- read.csv("/r/r_datas/emp_csv")
emp <- emp_org

emp %>% select(ename)
emp %>% select(ename,gender)

emp %>% select(-base)
emp %>% select(-base,-bonus)

emp %>%
  filter(dept_no==30) %>%
  select(ename)

emp %>%
  filter(dept_no==10) %>%
  head(2)

# 열 정렬
emp %>%
  arrange(id)
emp %>%
  arrange(desc(base))

emp %>%
  arrange(dept_no, join_date)
emp %>%
  arrange(join_date, dept_no)

emp %>%
  arrange(desc(job_level), desc(base), join_date)

emp %>%
  filter(dept_no %in% c(10,40)) %>%
  select(id,ename) %>%
  arrange(desc(id))

emp %>%
  filter((dept_no == 10 & job_level<=2) | (dept_no %in% c(20,30) & job_level>=4)) %>%
  select(ename,dept_no,job_level,join_date) %>%
  arrange(desc(job_level), join_date)

# 열 추가 및 수정 : mutate
emp %>%
  mutate(total = base + bonus) %>%
  head

emp %>%
  mutate(special_bonus = base*0.1) %>%
  head

head(emp) # 컬럼이 추가되지 않음

emp$total <- emp$base + emp$bonus # $로 파생변수를 만들면 컬럼이 생성됨
emp
emp$special_bonus <- emp$base*0.1
emp

emp$total <- NULL # 값이 없어짐
emp

emp$special_bonus <- NA # NA로 채워짐(값이 있어야 하는 자리)
emp

emp <- emp %>% select(-special_bonus)
head(emp)

emp %>%
  mutate(total = base + bonus,
         special_bonus = total*0.1)

emp %>%
  mutate(is_new = ifelse(join_date >"2022-03-01","Y","N")) %>%
  arrange(is_new)

emp %>%
  mutate(is_new = ifelse(join_date >"2022-03-01","Y","N")) %>%
  select(ename,is_new)

#job_level 1,2 -> junior/ 나머지 senior
# 2023 200/ 10-> 400
# total > 6000 정렬
emp
emp %>%
  mutate(job_level_name = ifelse(job_level<= 2,"junior","senior"),
          signing_bonus = ifelse(join_date >= "2022-07-01" & join_date <= "2023-12-31",200,0),
          commission = ifelse(dept_no==10 & job_level_name=="senior",400,0),
          total = base + bonus + signing_bonus + commission) %>%
  filter(total>6000) %>%
  select(ename,total) %>%
  arrange(desc(total))
  