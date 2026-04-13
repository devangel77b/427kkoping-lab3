library(ggplot2)
library(dplyr)

raw <- read.csv('newwork.csv',header=TRUE)
data <- tibble(raw)

fig <- ggplot(data,aes(x=x,y=F))+
    geom_point()+
    stat_summary(fun=mean,geom="line",aes(group=1))

library(pracma)
print(trapz(data$x,data$F))