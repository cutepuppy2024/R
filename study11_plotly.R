install.packages("plotly")

library(plotly)
library(tidyverse)

p <- ggplot(mpg, aes(x=displ, y=hwy, col=drv))+
  geom_point()

plot(p)
ggplotly(p)

plot_ly(mpg, x =~displ,y=~hwy, type = "scatter", mode = "markers", symbol =~drv)%>% # color/symbol
  layout(title = "interactive scatter plot",
         xaxis = list(title = "highway MPG"),
         yaxis = list(title = "displacement"))

plot_ly(mpg, x =~displ,y=~hwy, type = "scatter", mode = "markers",
        marker = list(size=6, color = "green", line=list(color="red", width=2)))

new_mpg <- mpg %>%
  group_by(manufacturer, drv) %>%
  summarise(cnt = n())

plot_ly(new_mpg, x=~manufacturer, y=~cnt, type = "bar", color=~drv) %>%
  layout(title = "interactive bar graph",
         xaxis = list(title = "manufacturer"),
         yaxis = list(title = "count"),
         barmode = "stack") #"group","overlay"

g1 <- plot_ly(new_mpg, y=~manufacturer, x=~cnt, type = "bar", name = "highway MPG") %>%
  layout(title = "Highway MPG",
         yaxis = list(categoryorder = "total ascending")) #"group","overlay"

g2 <- plot_ly(new_mpg, y=~manufacturer, x=~cnt, type = "bar", name = "city MPG") %>%
  layout(title = "city MPG",
         yaxis = list(categoryorder = "total ascending")) 

subplot(g1,g2, nrows =1) %>%
  layout(title = "MPG by Manufacturers",
         legend = list(orientation = "h"))

plot_ly(mpg, x =~drv,y=~hwy, type ="box", color =~class,
        boxmean = T, boxpoints = "all", jitter = 0.8) %>%
  layout(boxmode = "group")

head(economics)

plot_ly(economics, x =~date,y=~unemploy, type = "scatter", mode = "lines")

econ <- economics_long %>% # 정규화값
  select(-value) %>%
  pivot_wider(names_from = variable,
              values_from = value01)

plot_ly(econ, x=~date) %>%
  add_trace(econ, x =~date,y=~unemploy, type = "scatter", mode = "lines",
        name="unemploy", line =list(color="black", width=7))%>%
  add_trace(y=~pce, mode = "lines",
            name="pce", line =list(color="red", dash= "dash")) %>%
  add_trace(y= ~psavert, mode="lines",
            name="psavert", line =list(color="blue", dash= "dot")) %>%
  layout(title = "economics in the US",
         xaxis = list(rangeslider = list(type ="date")),
         yaxis = list(title = "normalized value"))





