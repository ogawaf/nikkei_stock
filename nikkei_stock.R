library(tidyverse)
library(lubridate)
library(magrittr)
options(stringsAsFactors = F)


d <- 
  readr::read_csv("https://indexes.nikkei.co.jp/nkave/historical/nikkei_stock_average_daily_jp.csv",
                  locale = locale(encoding = "CP932")) 
d %<>%
  mutate(date = ymd(データ日付))
get_date <- d %>% arrange(desc(date)) %>% slice(1) %>% .$date

ggplot(d) +
  geom_line(aes(x = date, y = 安値, color ="安値"))  +
  geom_line(aes(x = date, y = 高値, color ="高値")) +
  scale_color_viridis_d(begin = 0.2, end = 0.8)  +
  labs(color = "", y = "株価", title = paste("最終更新日：", get_date))

ggsave("nikkei_stock.png")
