library(readxl)
library(readr)
library(dplyr)
library(ggplot2)
library(lubridate)

weather0918 <- read_csv("1194556.csv")
weather9908 <- read_csv("1194555.csv")

weather20yr <- bind_rows(weather9908, weather0918)
weather20yr

ggplot(weather20yr) + geom_point(aes(DATE, TAVG))
ggplot(weather20yr) + geom_point(aes(DATE, TMAX))

weather20yr %>% filter(TMAX>90) %>% 
  ggplot() + geom_point(aes(DATE, TMAX))

weather20yr <- weather20yr %>% mutate(over90=TMAX>90)

summary90 <- weather20yr %>% group_by(month=floor_date(DATE, "month")) %>% 
  summarize(days90=sum(over90))

summary90

summary90 %>% ggplot(aes(month, days90)) + geom_col()

ggplot(weather20yr) + geom_histogram(aes(TMAX, col=year(DATE)<2009), alpha=0.5)

