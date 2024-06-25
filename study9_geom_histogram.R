library(tidyverse)

head(mpg)

ggplot(mpg, aes(x=hwy, fill=factor(drv))) +  # 범주형
  geom_histogram(binwidth = 2,  # bins = 16  # cols = "black",fill = "blue") +
                position = "identity",
                alpha = 0.5) +     # 구동방식에 따라3개의 히스토그램으로
  labs(title = "Histogram of Highway MPG",
       x = "Highway MPG",
       fill = "drive train") +
  scale_fill_manual(values = c("4" = "blue", "f" ="green", "r" = "red"),
                    breaks = c("4", "f", "r"),
                    labels = c("front-wheel drive", "rear wheel drive", "4wd"))
  
ggplot(mpg, aes(x=manufacturer, fill =drv)) +
  geom_bar(position = "fill") + # 비율율  # "stack" : 누적막대그래프  # 막대속성 : color = "black", fill="green", width = 0.4) +
  labs(x = "Manufacturer",
       title = "Bar Chart of Manufacturers") +
  coord_flip() # 가로막대그래프
  #theme(axis.text = element_text(angle = 45, hjust = 1))

class_hwy <- mpg %>%
  group_by(class) %>%
  summarize(avg_hwy = mean(hwy))

ggplot(class_hwy, aes(x=reorder(class, -avg_hwy), y = avg_hwy)) + # x = class -> 내림차순저렬렬
  geom_col() +
  labs(title = "Average Highway MPG by Type of Car",
       x = "Type of Car",
       y = "Average Highway MPG")

mpg_long <- mpg %>%
  group_by(class) %>%
  summarize(avg_hwy = mean(hwy),
            avg_cty = mean(cty)) %>%
  pivot_longer(cols = -class)

ggplot(mpg_long, aes(x =class, y = value, fill = name)) +
  geom_col(postion = "dadge")
