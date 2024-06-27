library(tidyverse)

as.Date("2023-05-10")
as.Date("2023/05/10")

ymd("2023-05-10")
dmy("10-05-2023")
mdy("05102023")
ymd("230510")
mdy("May 10th 2023")
mdy("5월 10일 2023년")

ymd(230510)

dt1 <- ymd(20230722)
dt2 <- ymd(20221015)

year(dt1)
month(dt1)
day(dt1)
week(dt1)
wday(dt1)
wday(dt1, label =TRUE)
yday(dt1)

dt1 + days(20)
dt1 + months(5)
dt1 + years(2)

as.period(dt2 %--% dt1)
as.duration(dt2 %--% dt1)


(months(3) + days(2)) * 5

leap_year(2005) # 윤달
leap_year(2008)

today()
now()

hms("20:15:18") # , *도 가능

ymd_hms("2015-09-18 09:24:10")


tm1 <- hms("15:20:10")
tm2 <- hms("10:10:05")

hour(tm1)
minute(tm1)
secont(tm1)

hm("20,15") + minutes(35)

tm2 + second(20)

tm1 + tm2


am(tm1)
pm(tm1)

dt1_hm <- ymd_hm("20230430 14:30")
dt2_hm <- ymd_hm("20230430 14:30", tz="Asia/Seoul")

dt1_hm == dt2_hm

with_tz(dt1_hm, "Asia/Seoul")

dt1_hm - hours(9) == dt2_hm

round_date(dt1_hm, unit = "year")
round_date(dt1_hm, unit = "month")

ceiling_date(dt1_hm, unit = "year")
floor_date(dt1_hm, unit = "month")