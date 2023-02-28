library(tidyverse)

checkout_data <- read_csv("2022-2023-All-Checkouts-SPL-Data.csv")

merged_data <- checkout_data %>%
  #gather(key = "CheckoutType", value = "Checkouts", "Horizon":"OverDrive")%>%
  filter(CheckoutType %in% c("Horizon", "OverDrive"))

ggplot(merged_data, aes(x = CheckoutMonth, y = Checkouts, fill = CheckoutType)) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c("#00BFFF", "#FFA500"), name = "Checkout Type",
                    labels = c("Horizon", "OverDrive")) +
  scale_x_continuous(breaks = seq(1, 12, 1), labels = month.abb) +
  ylab("Number of Checkouts") +
  ggtitle("Monthly Checkouts by Checkout Type") +
  theme_minimal()
