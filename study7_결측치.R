# 결측치처리
library(tidyverse)

stu1 <- data.frame(name = c("Hwayoung",NA,"Sua","Sojin", "Minjeong", "Goeun", "Janghoon","Sunghoon","Jaeyoung","Yesung","Jungjae", "Kyunghwan"),
                   class = c(1,2,3,2,3,1,1,2,3,3,2,2),
                   math = c(74,56,NA,57,42,39,55,68,NA,83,92,71),
                   eng = c(76,70,77,68,NA,63,70,NA,95,NA,100,65))

anyNA(stu1)

table(is.na(stu1$math))

ed <- stu1 %>%
  filter(!is.na(math) & !is.na(eng))

stu1 %>%
  drop_na()

na.omit(stu1) # 한번에 제거 가능하지만, 분석에 필요한 행까지 삭제될 수 있음

# 결측치가 많은 데이터인 경우
stu2 <- data.frame(stu1,
                   gender = c("f",NA,NA,NA,NA,NA,"m",NA,NA,NA,NA,NA))


stu2 %>%
  drop_na() # 필요한 데이터가 모두 삭제되므로


stu2 %>%
  drop_na(math,eng) %>% # 원하는 정보만을 제거
  group_by(class) %>%
  summarize(mean(math),mean(eng))

# na.rm
stu2 %>%
  summarize(mean(math, na.rm = T)) # 데이터가 크고 결측치가 적을 때 사용

# 다른 값으로 채우는 방법
stu2 %>%
  fill(gender, .direction="down") # 바로 위의 값으로 대체

stu2 %>%
  fill(math)

stu2 %>%
  replace_na(list(math = 0))

stu2 %>%
  replace_na(list(math = 0, eng = 10))

stu2 %>%
  mutate(math = ifelse(is.na(math), mean(math, na.rm = T),math))

stu2 %>%
  replace_na(list(math = mean(stu2$math, na.rm=T)))

avg = mean(stu2$math, na.rm = T)

stu2 %>%
  replace_na(list(math = avg))
