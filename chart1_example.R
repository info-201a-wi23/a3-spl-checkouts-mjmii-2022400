library("dplyr")
library("ggplot2")
library("lubridate")

lib_data <- read.csv("2022-2023-All-Checkouts-SPL-Data.csv")

media_types <- c("BOOK", "EBOOK", "SOUNDDISC", "AUDIOBOOK", "VIDEODISC")


media_graph <- lib_data %>% 
  filter(MaterialType %in% c(media_types)) %>% 
  group_by(MaterialType, CheckoutMonth) %>% 
  summarise(Checkouts = sum(Checkouts, na.rm = TRUE))

media_graph$Month <- month(ymd(paste0("2022-", media_graph$CheckoutMonth, "-01")))

ggplot(media_graph, aes(x = Month, y = Checkouts, color = MaterialType)) +
  geom_line() + 
  scale_x_continuous(breaks = 1:12, labels = month.abb) +
  scale_y_continuous(limits = c(0, max(media_graph$Checkouts))) +
  labs(title = "Checkouts Based on Media Types 2023",
       x = "Month",
       y = "Checkouts",
       color = "Legend")
