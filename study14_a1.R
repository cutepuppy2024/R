library(tidyverse)

mql <- read.csv("/r/r_datas/olist_marketing_qualified_leads_dataset.csv")
cd <- read.csv("/r/r_datas/olist_closed_deals_dataset.csv")

head(mql)

tail(mql)

str(mql)

summary(mql)

mql <- mql %>%
  mutate(first_contact_date = as.Date(ymd(first_contact_date)))

colSums(is.na(mql))

mql %>%
  filter(duplicated(mql))

mql %>%
  filter(origin != "")

head(cd)

mql %>%
  group_by(origin) %>%
  summarise(cnt = n(),
            pct = cnt / 80000) %>%
  arrange(desc(cnt))

mql <- mql %>%
  filter(origin != "")

# 판매자로 전환된 고객데이터
head(cd)
tail(cd)
str(cd)
summary(cd)

colSums(is.na(cd))

cd %>%
  filter(duplicated(cd))

cd <- cd %>%
  mutate(won_date = as.Date(ymd(won_date)))

# 리드타입별
cd %>%
  group_by(lead_type) %>%
  summarise(cnt=n())%>%
  arrange(desc(cnt)) %>%
  ggplot(aes(x=lead_type, y =cnt)) +
  geom_col()

# 비즈니스 타입별
cd %>%
  group_by(business_type) %>%
  summarise(cnt=n())%>%
  arrange(desc(cnt))

# 비즈니스 세그먼트별별
cd %>%
  group_by(business_segment) %>%
  summarise(cnt = n()) %>%
  mutate(pct = cnt / sum(cnt)) %>%
  arrange(desc(cnt))

cd %>%
  filter(business_segment == "" | business_type =="" | lead_type == "")

cd %>%
  filter(business_segment == "" & business_type =="" & lead_type == "")

# 병합
mql_cd <- mql %>%
  left_join(cd, by ="mql_id")

# 유입채널별 판매자 전환율
mql_cd %>%
  group_by(origin) %>%
  summarize(mqls = n(),
            sellers = sum(ifelse(is.na(seller_id),0,1))) %>%
  mutate(conversion = sellers / mqls) %>%
  arrange(desc(conversion))

# 랜딩페이지별 전환율
mql_cd %>%
  group_by(landing_page_id) %>%
  summarize(mqls = n(),
            sellers = sum(ifelse(is.na(seller_id),0,1))) %>%
  mutate(conversion = sellers / sum(sellers)) %>%
  arrange(desc(conversion))

# 영업담당자별 전환시키는데 걸리는 시간
sr_info <- mql_cd %>%
  filter(!is.na(seller_id)) %>%
  mutate(duration = won_date - as.Date(first_contact_date)) %>%
  group_by(sr_id) %>%
  mutate(avg_duration = mean(duration , na.rm= T),
         sellers = n()) %>%
  distinct(sr_id, avg_duration, sellers) %>%
  arrange(avg_duration)

sr_info

sr_info %>%
  mutate(avt_duration = as.integer(avg_duration)) %>%
  summary()
