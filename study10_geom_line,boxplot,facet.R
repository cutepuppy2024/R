library(tidyverse)

head(economics)
head(economics_long)

summary(economics)

# line
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


# boxplot
ggplot(mpg, aes(x=drv, y=hwy, fill=drv)) +
  geom_boxplot(varwidth = T, # 데이터의 크기에 따라 박스의 크기결정정
               notch = T,
               outlier.color = "red",
               outlier.shape = "square",
               outlier.size = 3) + 
  labs(x = "Type of Drive Train",
       y = "Highway MPG",
       title = "Box Plot of Highway MPG by Type of Drive Train")+
  geom_jitter()

table(mpg$drv)

ggplot(mpg, aes(x=displ, y=hwy)) + # , color = class
  geom_point() +
  facet_wrap(~class, ncol =2, strip.position = "left", scale = "free_x")  # nrow =2

ggplot(mpg, aes(x=displ, y=hwy, color=class)) + 
  geom_point() +
  facet_grid(drv ~ class) # class~. / .~class

