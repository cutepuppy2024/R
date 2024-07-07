# RFM
library(tidyverse)

ecom <- read.csv("/r/r_datas/e_commerce_data.csv")

head(ecom)
tail(ecom)
str(ecom)
summary(ecom)

# 결측치 25%
colSums(is.na(ecom))/nrow(ecom)

new_ecom <- ecom %>%
  filter(!is.na(CustomerID))

nrow(new_ecom)
  

# 중복확인
new_ecom %>%
  filter(duplicated(new_ecom)) %>%
  head()

new_ecom %>%
  filter(InvoiceNo == 536409 & StockCode == 22111 & CustomerID ==17908)

new_ecom <- new_ecom %>% 
  distinct()

new_ecom <- new_ecom %>%
  mutate(Invoice_Date = as.Date(mdy_hms(InvoiceDate)),
         total = Quantity * UnitPrice)

str(new_ecom)

# 이상치 확인
new_ecom %>%
  filter(Quantity == 80995 | Quantity == -80995)

new_ecom %>%
  filter(Quantity < 80995 & Quantity > -80995)%>%
  summary()

new_ecom %>%
  filter(Quantity < 74215 & Quantity > -74215)%>%
  summary()

ggplot(new_ecom, aes(x=Quantity)) +
  geom_histogram() +
  xlim(-10,130)

# %별 정리
new_ecom %>%
  summarise(q10 = quantile(Quantity,0.9),
         q1 = quantile(Quantity,0.99),
         q0.1 = quantile(Quantity,0.999))

new_ecom %>%
  filter(Quantity>500) %>%
  group_by(Description) %>%
  summarize(cnt = n()) %>%
  arrange(desc(cnt))

new_ecom %>%
  ggplot(aes(x=UnitPrice))+
  geom_histogram() +
  xlim(0,100)

new_ecom %>%
  summarize(q10 = quantile(UnitPrice,0.9),
            q1 = quantile(UnitPrice,0.99),
            q0.1 = quantile(UnitPrice,0.999))

new_ecom %>%
  filter(UnitPrice > 50) %>%
  group_by(Description) %>%
  summarize(cnt = n()) %>%
  arrange(desc(cnt))

nrow(new_ecom %>% filter(UnitPrice >50)) / nrow(new_ecom)

new_ecom %>%
  filter(Description == "Manual") %>%
  summary()

new_ecom %>%
  filter(str_sub(InvoiceNo,1,1) == "C")%>%
  # head()
summarize(cnt=n())

new_ecom <- new_ecom %>%
  filter(str_sub(InvoiceNo,1,1) != "C")

new_ecom %>%
  filter(UnitPrice == 0)

new_ecom <- new_ecom %>%
  filter(UnitPrice > 0)

head(new_ecom)


new_ecom %>%
  mutate(yearmonth = format(Invoice_Date,"%Y-%m"))%>%
  group_by(yearmonth) %>%
  summarise(cnt = n()) %>%
  ggplot(aes(x=yearmonth, y=cnt))+
  geom_col()


new_ecom %>%
  group_by(Country) %>%
  summarize(cnt =n()) %>%
  mutate(pct = cnt/sum(cnt)) %>%
  arrange(desc(cnt))

#RFM 생성

max(new_ecom$Invoice_Date)
today = as.Date('2011-12-10')  
# recency
recency <- new_ecom %>%
  group_by(CustomerID) %>%
  summarize(last_order = max(Invoice_Date)) %>%
  mutate(r=today - last_order) %>%
  arrange(CustomerID)  

# frequency
frequency <- new_ecom %>%
  distinct(CustomerID, InvoiceNo) %>%
  group_by(CustomerID) %>%
  summarize(f=n()) %>%
  arrange(CustomerID)

# monetary
monetary <-new_ecom %>%
  group_by(CustomerID) %>%
  summarize(m=sum(total)) %>%
  arrange(CustomerID)

rfm <- cbind(recency, frequency['f'], monetary['m'])
head(rfm)

# 전체 점수
rfm <- rfm %>%
  mutate(r_score = ntile(-r,3),
         f_score = ntile(f,3),
         m_score = ntile(m,3),
         total_score = r_score + f_score + m_score)

ggplot(rfm, aes(x=total_score)) +
  geom_bar()

# rfm 상관관계
rfm %>%
  select(r,f,m) %>%
  mutate(r=as.numeric(r)) %>%
  cor(.)

# rm 스코어
rfm <- rfm %>%
  mutate(fm_score = f_score + m_score)

ggplot(rfm, aes(x=fm_score)) +
  geom_bar()

# 각각의 그룹 비교
rfm %>%
  group_by(fm_score) %>%
  summarise(n=n(),
            avg_r = mean(r),
            avg_f = mean(f),
            avg_m = mean(m)) %>%
  mutate(ptg = n / sum(n))

# rfm 수정
rfm1 <-rfm %>%
  mutate(r_score = ntile(-r,4),
         f_score = ntile(f,4),
         m_score = ntile(m,4),
         total_score = r_score + f_score + m_score)

ggplot(rfm1, aes(x=fm_score)) +
  geom_bar()

rfm1 %>%
  group_by(fm_score) %>%
  summarise(n=n(),
            avg_r = mean(r),
            avg_f = mean(f),
            avg_m = mean(m)) %>%
  mutate(ptg = n / sum(n))
# write_csv("fm_score_summary.csv")

rfm %>%
  group_by(fm_score, f_score, m_socre) %>%
  summarise(n=n(),
            avg_r = mean(r),
            avg_f = mean(f),
            avg_m = mean(m)) %>%
# write_csv("fm_score_summary_detail.csv")
  
rfm %>%
  write_csv("fm_score.csv")


  