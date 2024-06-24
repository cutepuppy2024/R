library(tidyverse)

?anscombe

ans_tidy <- anscombe %>%
  mutate(obs = row_number()) %>% # 번호부여
  pivot_longer(cols = -obs, names_to = "key", values_to = "value") %>%
  separate_wider_position(cols = key, widths = c(variable = 1, set = 1)) %>%
  pivot_wider(names_from = variable, values_from = value)

ans_tidy %>%
  group_by(set) %>%
  summarize(mean(x), mean(y), var(x), var(y), sd(x), sd(y), cor(x,y))


ggplot(ans_tidy, aes(x,y))+
  geom_point()+
  facet_wrap(~set) +
  geom_smooth(method = "lm", se = F)

# 숫자, 문자, 범주
options(scipen = 999)

head(midwest)

ggplot(midwest, aes(x =area, y=poptotal)) +
  geom_point()+
  geom_smooth(method = "lm")+
  coord_cartesian(xlim=c(0,0.1),ylim=c(0,1000000))

                  