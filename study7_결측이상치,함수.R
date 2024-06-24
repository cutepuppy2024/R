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


# 이상치
hs <- data.frame(id = 1:10,
                 gender = c("f","f","f","f","m","m","m","mm","mm","m"),
                 age = c(17,18,18,17,17,18,18,19,19,16),
                 math = c(65,70,50,60,1,60,90,70,110,0))

table(hs$age)
table(hs$gender)

new_hs <- hs %>%
  mutate(gender = ifelse(gender == "mm","m",gender),
         age = ifelse(age == 16,17,age),
         math = ifelse(math>=0 & math <=100 & math %% 5 == 0, math, NA))

new_hs %>%
  group_by(gender, age) %>%
  summarize(avg = mean(math, na.rm=T))

head(mpg)
?mpg # 데이터의 관련된 정보 확인

summary(mpg)

boxplot(mpg$hwy)$stat

mpg %>%
  mutate(hwy = ifelse(hwy<12 | hwy>37, NA, hwy)) %>%
  arrange(desc(hwy))


# 다른 함수들
# 1. gather
stu1 <- data.frame(name =c("Jimin", "Hyunsoo", "Sangho", "Yerim"),
                   year1 = c(100,70,80,60),
                   year2 = c(77,49,53,82))
stu2 <- pivot_longer(stu1,
                    cols = c("year1", "year2"),
                    names_to = "year",
                    values_to = "grade")

gather(stu1, key = year, value = grade, year1, year2)

pivot_wider(stu2,
            names_from = year,
            values_from = grade)

# 2. spread
spread(stu2, key = year, value = grade)

# 3. separate
df1 <- data.frame(id = 1:4,
                  x = c("m-014", "f-1524", "f-2534", "f-65"),
                  bday = c(920134,941025,960409,970228))

df1 %>%
  separate(x, into = c("gender", "age"), sep = "-")

df1 %>%
  separate_wider_delim(x,names = c("gender", "age"), delim="-")

df1 %>%
  separate_wider_position(bday, widths = c(year=2, month =2, day = 2))  

df1 %>%
  separate_wider_position(bday, widths = c(year=2,3, day = 1))  

df2 <- data.frame(id = 1:4,
                  color = c("red,oragne","red, yellow, purple", "green, blue", "blue, pink, green"))

df2 %>%
  separate_longer_delim(color, delim = ",")

df2 %>%
  separate_longer_delim(color, delim = ",")%>%
  group_by(id) %>%
  summarize(cnt = n())

# 4. unite()
df3 <- data.frame(id = 1:3,
                  year = c(2000,2001,2000),
                  month = c(5,3,11),
                  day = c(24,30,15))

df3 %>%
  unite(data, year, month, day, sep = ",")

# 5. expand()
df4 <- data.frame(
  type = c("apple", "orange", "apple",  "orange",  "orange", "orange"),
  year = c(2010,2010,2012,2010,2011,2012),
  size = c("S","S","S","S","L","L")
)

df4 %>%
  expand(year, type, size)
