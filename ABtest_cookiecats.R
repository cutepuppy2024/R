# A/B Test

library(tidyverse)

game <- read.csv("/r/r_datas/cookie_cats.csv")

head(game)
tail(game)
str(game)
summary(game)


colSums(is.na(game))

game %>%
  filter(duplicated(game)) %>%
  head()

summary(game)

game %>%
  group_by(version) %>%
  count()

game %>%
  ggplot(aes(x=version, y=sum_gamerounds))+
  geom_boxplot()

game %>%
  group_by(version) %>%
  summarise(avg= mean(sum_gamerounds),
            qt90 = quantile(sum_gamerounds,0.9),
            qt99 = quantile(sum_gamerounds,0.99),
            qt999 = quantile(sum_gamerounds,0.999),
            max = max(sum_gamerounds))

new_game <-game %>%
  filter(sum_gamerounds < 49854) %>%
  arrange(desc(sum_gamerounds))

new_game %>%
  ggplot(aes(x=version, y=sum_gamerounds)) +
  geom_boxplot()


# EDA
# 버전별 플레이수 히스토그램
game %>%
  ggplot(aes(x=sum_gamerounds, fill=version)) +
  geom_histogram(position="identity",
                 alpha = 0.4)+
  xlim(0,100)
  
# 버전별 총 인원수, 평균 게임 플레이 횟수
game %>%
  group_by(version) %>%
  summarize(players = n(),
            avg=mean(sum_gamerounds),
            median = median(sum_gamerounds),
            max = max(sum_gamerounds))


# 버전별 설치 후 게임 한번도 안한 유저
new_game %>%
  group_by(version, retention_1, retention_7) %>%
  filter(sum_gamerounds == 0) %>%
  summarize(players = n())

# 버전별 설치 후 게임하지 않은 플레이어 55%
game %>%
  mutate(total_count = n()) %>%
  group_by(retention_1, total_count)%>%
  summarize(count = n(),
            avg = mean(sum_gamerounds)) %>%
  mutate(pct = count / total_count)

# 버전별
# 1일차, 7일차 두번 다 들어온 플레이어 vs 그렇지 않은 플레이어 -> 비슷한 결과
# 14.9%, 14.3%  앞으로도 게임을 계속 할 플레이어
game %>%
  group_by(version) %>%
  mutate(total_count = n()) %>%
  group_by(version, retention_1, retention_7, total_count) %>%
  summarize(count = n(),
            avg = mean(sum_gamerounds)) %>%
  mutate(pct = count/ total_count)

# AB Test
# 가설세우기
# 정규성 확인필요

gate30 <- new_game %>%
  filter(version == "gate_30")

gate40 <- new_game %>%
  filter(version == "gate_40")

# 정규성 가정 - 샤피로
shapiro.test(gate30$sum_gamerounds)

# qq_plot
ggplot(gate30, aes(sample = sum_gamerounds)) +
  geom_qq()+
  geom_qq_line()+
  labs(title="Gate 30 : QQ Plot for Normality Check")

ggplot(gate40, aes(sample = sum_gamerounds)) +
  geom_qq()+
  geom_qq_line()+
  labs(title="Gate 40 : QQ Plot for Normality Check")

# 비모수적 검정 - 윌콕슨
wilcox.test(gate30$sum_gamerounds,gate40$sum_gamerounds)



