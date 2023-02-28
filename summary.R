library(data.table)

# most popular checkout method
data_set <- fread("2022-2023-All-Checkouts-SPL-Data.csv")
setkey(data_set, CheckoutYear)
top_medium <- data_set[CheckoutYear == 2022, .(total = sum(Checkouts)), by = CheckoutType][order(-total)][1]$CheckoutType
print(top_medium)

# least popular checkout method
library(dplyr)
least_pop_med <- data_set %>%
  filter(CheckoutYear == 2022, !is.na(Checkouts)) %>%
  group_by(CheckoutType) %>% 
  summarise(total = sum(Checkouts)) %>% 
  arrange(total) %>% 
  slice_head(n = 1) %>% 
  pull(CheckoutType)
print(least_pop_med)

# most popular format
mostpop_format <- data_set %>%
  select(MaterialType, Checkouts) %>%
  group_by(MaterialType) %>%
  summarize(total_checkouts = sum(Checkouts)) %>%
  arrange(desc(total_checkouts)) %>%
  slice_head(n = 1)
print(mostpop_format$MaterialType)

# average number of checkouts in 2022
checkouts_2022 <- data_set %>%
  group_by(CheckoutYear) %>%
  summarize(checkouts = sum(Checkouts, na.rm = TRUE))
avg_2022 <- checkouts_2022 %>% 
  summarize(average_checkouts = round(mean(checkouts, na.rm = TRUE), 0)) %>% 
  pull(average_checkouts)
print(avg_2022)

# The most checked out book of 2022.
most_pop_book <- data_set %>% filter(MaterialType == "BOOK") %>% 
  group_by(Title) %>%
  summarise(Checkouts = sum(Checkouts)) %>%
  filter(Checkouts == max(Checkouts)) %>%
  pull(Title)
print(most_pop_book)
