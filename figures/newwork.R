library(ggplot2)
library(dplyr)

raw <- read.csv('newwork.csv',header=TRUE)
data <- tibble(raw)

fig <- ggplot(data,aes(x=x,y=F))+
    geom_hline(yintercept=0,color="gray70")+
    geom_point(color="skyblue")+
    stat_summary(fun=mean,geom="line",aes(group=1),color="skyblue")+
    stat_summary(fun=mean,geom="area",fill="skyblue",alpha=0.5)+
    xlab('$x$, \\unit{\\meter}')+
    ylab('$F$, \\unit{\\newton}')+
    theme_bw(base_size=8)
ggsave('fig35.svg',plot=fig,width=3.4167,height=2,units="in")

library(pracma)
print(trapz(data$x,data$F))


grouped <- group_by(data,trial)
Wgrouped <- summarize(grouped,
	 W = trapz(x,F))
print(summarize(Wgrouped,
	meanW = mean(W),
	sdW = sd(W)))