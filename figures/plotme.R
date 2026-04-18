library(ggplot2)
library(dplyr)
library(tidyr)

raw <- read.csv('kinematics.csv',header=TRUE)
data <- tibble(raw)
m=0.0060
g=9.81

data <- mutate(data,
     KE=1/2*m*v0^2,
     GPE=m*g*h)
     
# make a bar graph of energy
long <- pivot_longer(data,
     cols = c(KE,GPE),
     names_to = "type",
     values_to = "energy")
Efig <- ggplot(long,aes(x=type,y=energy,fill=type))+
     geom_hline(yintercept=0,color="gray70")+
     stat_summary(geom="bar",fun=mean)+
     stat_summary(geom="errorbar",
	fun.data=mean_sdl,fun.args=list(mult=1),width=0.2)+
     ylab('energy, \\unit{\\joule}')+
     theme_bw(base_size=8)+
     theme(legend.position="none",axis.title.x=element_blank())
ggsave('fig33.svg',plot=Efig,width=3.4167,height=2,units="in")

model <- aov(energy~type,long)
print(summary(model))