library(tidyverse)

head(economics)
head(economics_long)

summary(economics)

ggplot(economics, aes(x=date, y =unemploy))+
  geom_line(color = "red") +
  labs(title = "Number of Unemployed Over Time",
       x = "date",
       y = "number of unemployed in thousands") +
  geom_smooth(method = "lm", se = F) + # se : 신뢰구간
  theme(panel.grid.major.x = element_line(color = "black"),
        panel.grid.major.y = element_blank())

ggplot(economics_long, aes(x =date, y = value01, color = variable)) +
  geom_line() +
  theme_bw() # 배경흰색으로
