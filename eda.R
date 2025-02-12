library(tidyverse)
library(ggplot2)
data <- read_csv("co2_pcap.csv")

data <- data |>
  select(country, "1950":"2022")

data[, c("2003", "2004", "2005", "2006", "2011", "2012", "2013")]<- suppressWarnings(lapply(data[,c("2003", "2004", "2005", "2006", "2011", "2012", "2013")], as.double))
data_clean <- na.omit(data)

data_clean <- data_clean |>
  pivot_longer(
    cols = -country,
    names_to = "year",
    values_to ="co2_emissions"
  ) |>
  group_by(country) |>
  arrange(country, year)

data_clean <- data_clean |>
  mutate(year = as.double(year)) |>
  filter(country %in% c("USA", "Canada", "France", "Germany", "Italy", "Japan", "UK"))


p <- ggplot(data_clean, aes(x = year,y = co2_emissions, group = country, color = country)) +
  geom_line() +
  scale_fill_viridis_d() +
  ggtitle("G7 Countries Co2 Emissions p/Capita Progression 1950 - 2022") +
  labs(
    x = "Year",
    y = "Co2 Emissions in Tonnes",
  ) +
  theme_classic()

ggsave(
  "visualization.png",
  plot = p,
  width = 2700,
  height = 1800,
  units ="px"