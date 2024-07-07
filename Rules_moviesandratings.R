# 연관규칙 
install.packages("arules")
install.packages("arulesViz")

library(arules) # 연관분석규칙
library(tidyverse) # 연관분석규칙시각화

movies <- read.csv("/r/r_datas/movies.csv")
ratings <- read.csv("/r/r_datas/ratings.csv")

head(movies)
tail(movies)
str(movies)

head(ratings)
tail(ratings)
str(ratings)

colSums(is.na(movies))
colSums(is.na(ratings))

movies %>%
  filter(duplicated(movies))

movies %>%
  filter(duplicated(movies$title)) %>%
  arrange(title)

movies %>%
  filter(title == "Aladdin (1992)")

ratings %>%
  filter(duplicated(ratings))

datasets <- ratings %>%
  inner_join(movies, by ="movieId")

new_dataset <- datasets %>%
  select(-genres, -timestamp) %>%
  group_by(title) %>%
  mutate(movieId = min(movieId),
         rating = mean(rating))

head(new_dataset)

summary(new_dataset)

# EDA
new_dataset %>%
  group_by(movieId) %>%
  summarise(cnt = n()) %>%
  summary()

new_dataset %>%
  group_by(userId) %>%
  summarise(cnt = n()) %>%
  summary()

new_dataset %>%
  group_by(userId) %>%
  summarise(cnt = n()) %>%
  ggplot(aes(y=cnt))+
  geom_boxplot()


new_dataset %>%
  group_by(userId) %>%
  summarise(cnt = n()) %>%
  summarise(avg= mean(cnt),
            qt90 = quantile(cnt,0.9),
            qt95 = quantile(cnt,0.95),
            qt99 = quantile(cnt,0.99),
            max = max(cnt))

ol <- new_dataset %>%
  group_by(userId) %>%
  summarise(cnt =n()) %>%
  filter(cnt > 1128)

new_dataset <- new_dataset %>%
  anti_join(ol,by="userId")

# 낮은 평점 제외
new_dataset <- new_dataset %>%
  select(userId, rating, title) %>%
  filter(rating <= 3.5)

# 데이터 포맷 변경
movie_lst <- split(new_dataset$title, new_dataset$userId)

trans <- as(movie_lst, "transactions")

summary(trans)

# 시각화
itemFrequencyPlot(trans, topN=10,type="absolute")

itemFrequencyPlot(trans, topN=10,type="relative")

# 규칙생성
rules <- apriori(trans, parameter=list(supp=0.1, conf=0.6, maxlen=2, target = "rules"))

# 상위 6개 신뢰도별
rules_conf <- sort(rules, by = "confidence", decreasing = T)

inspect(head(rules_conf))

# 상위 6개 리프트별
rules_lift <- sort(rules, by = "lift", decreasing=TRUE) 

inspect(head(rules_lift))

# 상위 6개 지지도별
rules_supp <- sort(rules, by = "support", decreasing=TRUE) 

inspect(head(rules_supp))

# 특정 아이템이 있는 규칙
rule_nemo <- subset(rules, items %in% ("Batman (1989)"))
inspect(sort(rule_nemo))




