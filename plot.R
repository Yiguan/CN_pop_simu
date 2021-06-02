library(data.table)
library(ggplot2)
library(RColorBrewer)
library(dplyr)
mycol = brewer.pal(8, "Set1")
mycol0 = brewer.pal(11, "Paired")
mycol1 = brewer.pal(9, 'YlOrRd')
## total fertility rate


tfr <- fread("total_fertility_rate.csv", header=T, sep=",", select=1:4)

tfr1 <- tfr %>% tidyr::gather("gg","vv",2:4)
ggplot() + geom_bar(data=tfr, aes(x=year, y=China), stat="identity", fill=mycol0[7]) +
	geom_line(data=tfr1, aes(x=year,y=vv, color=gg), size=1 ) +
	geom_hline(yintercept=2.1, linetype="dashed") + 
	theme_bw() + 
	theme(text = element_text(size = 18)) + 
	scale_color_manual(name = "", values=c("China"=mycol0[8], "developing"=mycol0[2], "world"="11")) +
	scale_y_continuous(name="Total Fertility Rate") +
	scale_x_continuous(name="Year", breaks=seq(1950,2020,10))



b0 <- fread("birth_0.0_version2.txt", header=T, sep="\t")
b0[Male_pop==0, Male_pop:=NA][Female_pop==0, Female_pop:=NA]

ggplot(data=b0) + 
	geom_bar(aes(x=Year, y=Male_pop/scale_down+Female_pop/scale_down, fill = "1"), stat="identity") +
	geom_line(aes(x=Year,y=Female_pop/scale_down, color = "2"), size=1) +
	geom_line(aes(x=Year, y=Male_pop/scale_down, color = "3"), size=1) +
	scale_color_manual(name="",values=c("2"=mycol[1], "3"=mycol[2]),
						labels=c("Female", "Male")) + 
	scale_fill_manual(name="", values=c("1"=mycol1[3]), labels=c("Total")) + 
	scale_y_continuous(name=bquote("Population * 1X"~10^8), breaks=seq(0,15,2)) +
	scale_x_continuous(name="Year", breaks=seq(2000,2150,by=20)) +
	theme_bw() + theme(text = element_text(size = 20))



b1 <- fread("birth_1.0_version2.txt", header=T, sep="\t")
b1[Male_pop==0, Male_pop:=NA][Female_pop==0, Female_pop:=NA]

ggplot(data=b1) + 
	geom_bar(aes(x=Year, y=Male_pop/scale_down+Female_pop/scale_down, fill = "1"), stat="identity") +
	geom_line(aes(x=Year,y=Female_pop/scale_down, color = "2"), size=1) +
	geom_line(aes(x=Year, y=Male_pop/scale_down, color = "3"), size=1) +
	scale_color_manual(name="",values=c("2"=mycol[1], "3"=mycol[2]),
						labels=c("Female", "Male")) + 
	scale_fill_manual(name="", values=c("1"=mycol1[3]), labels=c("Total")) + 
	scale_y_continuous(name=bquote("Population * 1X"~10^8), breaks=seq(0,15,2)) +
	scale_x_continuous(name="Year", breaks=seq(2000,2150,by=20)) +
	theme_bw() + theme(text = element_text(size = 20))


b2 <- fread("birth_2.0_version2.txt", header=T, sep="\t")
b2[Male_pop==0, Male_pop:=NA][Female_pop==0, Female_pop:=NA]

ggplot(data=b2) + 
	geom_bar(aes(x=Year, y=Male_pop/scale_down+Female_pop/scale_down, fill = "1"), stat="identity") +
	geom_line(aes(x=Year,y=Female_pop/scale_down, color = "2"), size=1) +
	geom_line(aes(x=Year, y=Male_pop/scale_down, color = "3"), size=1) +
	scale_color_manual(name="",values=c("2"=mycol[1], "3"=mycol[2]),
						labels=c("Female", "Male")) + 
	scale_fill_manual(name="", values=c("1"=mycol1[3]), labels=c("Total")) + 
	scale_y_continuous(name=bquote("Population * 1X"~10^8), breaks=seq(0,15,2)) +
	scale_x_continuous(name="Year", breaks=seq(2000,2150,by=20)) +
	theme_bw() + theme(text = element_text(size = 20))

b3 <- fread("birth_3.0_version2.txt", header=T, sep="\t")
b3[Male_pop==0, Male_pop:=NA][Female_pop==0, Female_pop:=NA]

ggplot(data=b3) + 
	geom_bar(aes(x=Year, y=Male_pop/scale_down+Female_pop/scale_down, fill = "1"), stat="identity") +
	geom_line(aes(x=Year,y=Female_pop/scale_down, color = "2"), size=1) +
	geom_line(aes(x=Year, y=Male_pop/scale_down, color = "3"), size=1) +
	scale_color_manual(name="",values=c("2"=mycol[1], "3"=mycol[2]),
						labels=c("Female", "Male")) + 
	scale_fill_manual(name="", values=c("1"=mycol1[3]), labels=c("Total")) + 
	scale_y_continuous(name=bquote("Population * 1X"~10^8), breaks=seq(0,80,10)) +
	scale_x_continuous(name="Year", breaks=seq(2000,2150,by=20)) +
	theme_bw() + theme(text = element_text(size = 20))


b1.3 <- fread("birth_1.3_version2.txt", header=T, sep="\t")
b1.3[Male_pop==0, Male_pop:=NA][Female_pop==0, Female_pop:=NA]

ggplot(data=b1.3) + 
	geom_bar(aes(x=Year, y=Male_pop/scale_down+Female_pop/scale_down, fill = "1"), stat="identity") +
	geom_line(aes(x=Year,y=Female_pop/scale_down, color = "2"), size=1) +
	geom_line(aes(x=Year, y=Male_pop/scale_down, color = "3"), size=1) +
	scale_color_manual(name="",values=c("2"=mycol[1], "3"=mycol[2]),
						labels=c("Female", "Male")) + 
	scale_fill_manual(name="", values=c("1"=mycol1[3]), labels=c("Total")) + 
	scale_y_continuous(name=bquote("Population * 1X"~10^8), breaks=seq(0,15,2)) +
	scale_x_continuous(name="Year", breaks=seq(2000,2150,by=20)) +
	theme_bw() + theme(text = element_text(size = 20))



b2.1<- fread("birth_2.1_version2.txt", header=T, sep="\t")
b2.1[Male_pop==0, Male_pop:=NA][Female_pop==0, Female_pop:=NA]

ggplot(data=b2.1) + 
	geom_bar(aes(x=Year, y=Male_pop/scale_down+Female_pop/scale_down, fill = "1"), stat="identity") +
	geom_line(aes(x=Year,y=Female_pop/scale_down, color = "2"), size=1) +
	geom_line(aes(x=Year, y=Male_pop/scale_down, color = "3"), size=1) +
	scale_color_manual(name="",values=c("2"=mycol[1], "3"=mycol[2]),
						labels=c("Female", "Male")) + 
	scale_fill_manual(name="", values=c("1"=mycol1[3]), labels=c("Total")) + 
	scale_y_continuous(name=bquote("Population * 1X"~10^8), breaks=seq(0,15,2)) +
	scale_x_continuous(name="Year", breaks=seq(2000,2150,by=20)) +
	theme_bw() + theme(text = element_text(size = 20))





ggplot() + geom_line(data = b3, aes(x=Year, y=Male_pop/scale_down+Female_pop/scale_down, color = "1"), size=1) +
	geom_line(data = b2.1, aes(x=Year, y=Male_pop/scale_down+Female_pop/scale_down, color = "2"), size=1) +
	geom_line(data = b2, aes(x=Year, y=Male_pop/scale_down+Female_pop/scale_down, color = "3"), size=1) +
	geom_line(data = b1.3, aes(x=Year, y=Male_pop/scale_down+Female_pop/scale_down, color = "4"), size=1) +
	geom_line(data = b1, aes(x=Year, y=Male_pop/scale_down+Female_pop/scale_down, color = "5"), size=1) +
	geom_line(data = b0, aes(x=Year, y=Male_pop/scale_down+Female_pop/scale_down, color = "6"), size=1) +
	scale_color_manual(name="TFR",values=c("6"=mycol1[9], "5"=mycol1[8],"4"=mycol1[7], "3"=mycol1[6], "2"=mycol1[4],"1"=mycol1[4]),
						labels=c("3.0", "2.1", "2.0", "1.3", "1.0", "0.0")) + 
	scale_y_continuous(name=bquote("Population * 1X"~10^8),limits=c(0,30)) +
	scale_x_continuous(name="Year", breaks=seq(2000,2150,by=20)) +
	theme(text = element_text(size = 20)) 

