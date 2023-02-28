rm(list = ls())
library(tidyverse)

data <- read.csv("2022-2023-All-Checkouts-SPL-Data.csv")

data <- data %>% select(Title, Checkouts)

data <- data %>% arrange(desc(Checkouts))

top_5_books <- data %>% top_n(5, Checkouts)

ggplot(top_5_books, aes(x = Title, y = Checkouts)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Top 2 Most Checked Out Things from Seattle Public Library",
       x = "Book Title", y = "Number of Checkouts") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +
  scale_y_continuous(labels = scales::comma) +
  guides(fill = FALSE)
