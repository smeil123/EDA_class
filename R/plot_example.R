#--------------------3강-----------------------#
## barplot(height, width = 1, space = NULL)
# 데이터 생성
op <- par(no.readonly=TRUE) # 원래의 그래프 파라미터를 모두 저장?
bar.width <-rep(1:3,4)
par(mfow = c(2,2))
op <- par(no.readonly =TRUE)
set.seed(1)
bar.x <- round(runif(12)*50)
set.seed(2)
bar.y <- matrix(bar.x,ncol=3,byrow=T)

barplot(bar.x, width = 1)
title(main = "Vector Barplot by defaul width")

# 막대의 너비를 조정
barplot(bar.x, width = bar.width)
title(main = "Vector Barplot by width 1:3")

# 막대 간격 조정
barplot(bar.x,space=3)
title(main = "Vector Barplot by space=3")

####################################################
# beside = True : 각각의 값마다 막대를 그림 (한 막대에 그려져있는 것을)
# bar.y는 matrix로 그룹별로 묶여져서 그려짐
barplot(bar.y, beside=TRUE,space = c(0.5,2))
title(main="Vector Barplot by space=c(0.5,2)")

op <- par(no.readonly = TRUE)
rownames(bar.y) <- paste("row",1:4)
colnames(bar.y) <- paste("col",1:3)
par(mfrow = c(2,2))

barplot(bar.x, names.arg = letters[1:length(bar.x)])#x축을 알파벳 순서대로
title(main = "Vector Barplot using names.arg")

barplot(bar.y)
title(main="Matrix Barplot using default names.arg")

barplot(bar.x, legend.text = letters[1:length(bar.x)])
title(main="Vector Barplot using legend.text")

barplot(bar.y, legend.text = T)
title(main = "Matrix Barplot using legend.text = T")
par(op)


####################################################
op <- par(no.readonly = TRUE)
par(mfrow = c(2,2))
barplot(bar.x, horiz=T, density=10)
title(main = "Vector Barplot by horiz = T, density = 5")

barplot(bar.x, density=15)
title(main = "Vector Barplot by density = 15, angle = 135")

barplot(bar.x, col=rainbow(length(bar.x)))
title(main="Vector Barplot by rainbow color")

barplot(bar.y, border="red", col=c("lightblue","mistyrose","lightcyan","lavender"))
title(main = "matrix Barplot by col,border")

par(op)

####################################################
hotdogs <- read.csv("http://datasets.flowingdata.com/hot-dog-contest-winners.csv",sep=",",header=T)

barplot(hotdogs$Dogs.eaten, names.arg=hotdogs$Year,
        col=ifelse(hotdogs$New.record==1,"blue","red"),
        xlab="Year",ylab="Hot Dogs and buns ...")

####################################################
# boxplot

op <- par(no.readonly=TRUE)
par(mfrow = c(2,2))
# 데이터 생성
set.seed(1)
norm1 <- round(rnorm(100,3,2),digits=2) # 소수점 둘째자리
set.seed(2)
norm2 <- round(rnorm(100,3,3),digits=3)

# (1) 데이터 형식 vector 1개 
boxplot(norm1)
title("boxplot of one vector")

# (2) 데이터 형식 vector 2개 
boxplot(norm1,norm2)
title("boxplot of two vectors")

# (3) 데이터 형식 list 
list1 = list(data1=norm1, data2=norm2,
             data3=rnorm(100,7,4))
boxplot(list1)
title("boxplot of simple list")

# (4) 데이터 형식 dataframe
dimnames(InsectSprays)
dim(InsectSprays)
boxplot(count~spray, data=InsectSprays, col="lightgray")
title("boxplot of dataframe by formula")


# ==================== 소스순번: 014 ==================== 

op <- par(no.readonly = TRUE)
par(mfrow = c(3, 2))

boxplot(len ~ dose, data = ToothGrowth)
title("len ~ dose")

boxplot(len ~ supp, data = ToothGrowth)
title("len ~ supp")

# 더하기 형식으로 표현해서 표현 
boxplot(len ~ dose + supp, data = ToothGrowth)
title("len ~ dose + supp")

boxplot(len ~ supp == "VC", data = ToothGrowth)
title("len ~ supp == 'VC'")

boxplot(len ~ dose, data = ToothGrowth, subset = supp == "VC")
title("len ~ dose, subset = supp == 'VC'")

boxplot(len[supp == "VC"] ~ dose[supp == "VC"], data = ToothGrowth)
title("len[supp == 'VC'] ~ dose[supp == 'VC']")
par(op)

# ==================== 소스순번: 015 ==================== 
#range를 다르게 

op <- par(no.readonly = TRUE)
set.seed(3)
z <- round(rnorm(50) * 10)
summary(z)
z[50] <- 40       # 50번째 데이터를 40으로 치환하여 이상치를 만듦
summary(z)
par(mfrow = c(2, 2))
boxplot(z)
title(main="range = default(1.5)")
boxplot(z, range = 0)
title(main="range = 0")
boxplot(z, range = 1.0)
title(main="range = 1.0")
boxplot(z, range = 2.0)
title(main="range = 2.0")
par(op)


# ==================== 소스순번: 016 ==================== 
# width 변경 
op <- par(no.readonly = TRUE)
x1 <- runif(20)
x2 <- runif(20)
x3 <- runif(20)
x4 <- runif(20)
x5 <- runif(20)
x <- list(x1, x2, x3, x4, x5)
y1 <- runif(10)
y2 <- runif(40)
y3 <- runif(90)
y4 <- runif(160)
y <- list(y1, y2, y3, y4)
par(mfrow = c(2, 2))
boxplot(x)
title(main = "default")
boxplot(x, width = 1:5)
title(main = "width = 1:5")
boxplot(y, varwidth = T)
title(main = "varwidth = T")
# width를 줄 때 어디에 프라이어티를 줄 것인가??? 무슨말인지 몰게
boxplot(y, varwidth = T, width = 4:1)
title(main = "varwidth = T & width = 4:1")

# ==================== 소스순번: 021 ====================
# 그래프를 겹쳐서 그리기 
op <- par(no.readonly = TRUE)
par(mfrow = c(2, 2))
boxplot(x)
# add = True 하면 이전 그래프 위에 추가된다 
boxplot(y, add = TRUE)
title(main = "add = TRUE(y is added to x)")
# at = 1:3 - 0.2 인데 1~3에 0.2를 뺀 위치에 그림을 그린다
# 그래프를 겹쳐그리기 위해서 위치 조정을 해준다
boxplot(len ~ dose, data = ToothGrowth, boxwex = 0.25, at = 1:3 - 0.2,
        subset = supp == "VC", col = "yellow", main = "Guinea Pigs' Tooth Growth",
        xlab = "Vitamin C dose mg", ylab = "tooth length", ylim = c(0, 35))
boxplot(len ~ dose, data = ToothGrowth, add = TRUE, boxwex = 0.25, at = 1:3 + 0.2,
        subset = supp == "OJ", col = "orange")
legend(2, 9, c("Ascorbic acid", "Orange juice"), fill = c("yellow", "orange"))
boxplot(y, staplelty = 3)
title(main = "staplelty = 3")
boxplot(z, outpch = 2)
title(main = "outpch = 2")
par(op)
# 평균과 분산을 눈으로 확인할 수 있다
# 산점도는 추세에 집중해서 볼 수있다면
# 박스플롯은 항목에 따라 달라지는 효과?분산?평균?추세?를 다 알 수 있다




####################################################
dev.off()

boxplot(len~dose, data=ToothGrowth, boxwex = 0.25, at=1:3-0.2,
        subset = supp == "VC", col="yellow",main="Guinea Pig' Tooth Growth",
        xlab = "Vitamin C does mg", ylab = "tooth length", ylim = c(0,35))
boxplot(len~dose, data=ToothGrowth, add=TRUE, boxwex=0.25, at = 1:3 + 0.2,
        subset = supp == "OJ", col = "orange")
legend(2,9,c("Ascorbic acid","Orange juice"),fill=c("yellow","orange"))

tests = read.csv

## 데이터 형식을 모르고 그래프를 그리면 원하지 않는 모양의 형태가 나온다 
test_data <- read.csv("C:/Users/dmswl/Downloads/test2.csv")
par(mfrow = c(1, 2))

# G1과 G2의 관계를 구분
boxplot(G2~G1, data = test_data, boxwex = 0.25, at=1:9 - 0.2,
        subset = Cat == 1)
boxplot(G2~G1, data = test_data, boxwex = 0.25, at=1:11 + 0.2,
        subset = Cat == 0,
        staplewex=0.5)

# 위의 데이터를 이용하면 botplot으로 나오지 않는다
# 이유) x축값이 범주형 데이터가 아니기 때문에
# test2를 ToothGrowth 형태를 보고 왜 안되는지 이해
# ToothGrowth를 보면 dose와 supp가 고정되어 있고 len값을 가지는 형태이다

####################################################
# DotChart
op <- par(no.readonly = TRUE)
par(mfrow = c(2,2))
month <- matrix(1:12,ncol=3)
rownames(month) <- paste("Row", 1:4)
colnames(month) <- paste("Col",1:3)

#(1) 벡터
dotchart(as.vector(month),label=month.abb)
title(main="x is a vector")

#(2) 행렬
dotchart(month)
title(main = "x is a matrix")

#(3) group
# row 별로 그룹화하고 그룹명 설정
quarter.name <- c("1QT","2QT","3QT","4QT")
quarter <- factor(row(month),label=quarter.name)
quarter
dotchart(month, groups = quarter)
title(main = "groups = quarter")
#(4) groups, labels
name <- c("1st", "2nd", "3rd")
dotchart(month, groups = quarter, labels = name)
title(main = "groups = quarter, labels = name")
par(op)

op <- par(no.readonly = TRUE)
par(mfrow = c(2, 2))
dotchart(month, cex = 1.1, bg = "red")
title(main = "bg = \"red\"")

dotchart(month, cex = 1.1, bg = "red", color = "blue")
title(main = "bg = \"red\", color = \"blue\"")

dotchart(month, cex = 1.1, color = "red", gcolor = "blue", groups = quarter,gdata = gmean)
title(main = "color = \"red\", gcolor = \"blue\"")

dotchart(month, cex = 1.1, lcolor = "red", gcolor = "blue", groups = quarter,gdata = gmean)
title(main = "lcolor = \"red\", gcolor = \"blue\"")
par(op)

####################################################
# matplot
op <- par(no.readonly=TRUE)
set.seed(10)
y1 <- rnorm(20,mean=-3,sd=1)
set.seed(20)
y2 <- rnorm(20,0,1)
set.seed(30)
y3 <- rnorm(20,3,1)
mat <- cbind(y1,y2,y3)

par(mfrow=c(2,2))
matplot(y1, type="l",main="One vector argument")
matplot(y1, y2, main = "Two vecter arguments")
matplot(mat, main = "Matrix argument")
matplot(mat, type = "n", main = "Add matlines, matpoints")
matlines(mat)
matpoints(mat)
par(op)

op <- par(no.readonly = TRUE)
par(mfrow = c(2, 2))
matplot(mat, type = "lSo", main = "type = \"lSo\"")
matplot(mat, type = c("l","S","o"), main = "type = c(\"l\", \"S\", \"o\")")
matplot(mat, col = c("red","blue","green"), cex = c(1, 1.2, 1.4))
title(main = "c(\"red\", \"blue\", \"green\"), cex=c(1, 1.2, 1.4)")
matplot(mat, type = "l", lty = 3:5, lwd = 1:3)
title(main = "lty = 3:5, lwd = 1:3")
par(op)

####################################################
# pair
pairs(~Fertility + Education + Catholic, data=swiss,
      subset = Education <20, main = "Swiss data, Education <20",
      col = 1 + (swiss$Agriculture > 50),cex=1.2,
      pch = 1 + (swiss$Agriculture>50))

pairs(iris[1:4], main = "Anderson's Iris Data--3 species",
      pch = 21, bg = c("red", "green3","blue")[unclass(iris$Species)])

####################################################
# ggplot
library(socviz)
p = ggplot(data = organdata, mapping = aes(x = country, y = donors))
p + geom_boxplot()

p + geom_boxplot() + coord_flip()

p = ggplot(data = organdata, mapping = aes(x = reorder(country, donors, na.rm = TRUE), y = donors))
p + geom_boxplot() + labs(x = NULL) + coord_flip()

p = ggplot(data = organdata,
           mapping = aes(x = reorder(country, donors, na.rm=TRUE),y = donors, fill = world))
p + geom_boxplot() + labs(x=NULL) +
  coord_flip() + theme(legend.position = "top")

###################################################
p = ggplot(data = organdata,
           mapping = aes(x = reorder(country, donors, na.rm=TRUE),
                         y = donors, color = world))

p + geom_point() + labs(x=NULL) +
  coord_flip() + theme(legend.position = "top")

p + geom_jitter() + labs(x=NULL) +
  coord_flip() + theme(legend.position = "top")

p + geom_jitter(position = position_jitter(width=0.15)) +
  labs(x=NULL) + coord_flip() + theme(legend.position = "top")

by_country = organdata %>% group_by(consent_law, country) %>%
  summarize_if(is.numeric, funs(mean, sd), na.rm = TRUE) %>%
  ungroup()

by_country
p = ggplot(data = by_country,
           mapping = aes(x = donors_mean, y = reorder(country, donors_mean),
                         color = consent_law))

p + geom_point(size=3) +
  labs(x = "Donor Procurement Rate",
       y = "", color = "Consent Law") +
  theme(legend.position="top")

#--------------------4강-----------------------#
# xyplot
library(lattice)
head(mtcars)
xyplot(mpg ~ disp, data=mtcars)

# gear에 따라서 그래프를 그리도록 조건을 줄 수 있다
# gear를 factor형으로 변환해서 나눔 
xyplot(mpg ~ disp | factor(gear), data=mtcars)

xyplot(mpg~disp,data=mtcars,
       group=gear,
       auto.key=list(space="right")) # 범례를 오른쪽으로 밀어버림


xyplot(mpg~disp | factor(gear),data=mtcars,
       layout = c(1,3),aspect=1)

## position
plot1 <- xyplot(mpg~disp,data=mtcars,
                aspect=1,xlim=c(65,480),ylim=c(9,35),
                subset=gear==5)
plot2 <- xyplot(mpg~disp,data=mtcars,
                aspect=1,xlim=c(65,480),ylim=c(9,35),
                subset=gear==4)

plot3 <- xyplot(mpg~disp,data=mtcars,
                aspect=1,xlim=c(65,480),ylim=c(9,35),
                subset=gear==3)

print(plot1, position=c(0, 2/3, 1, 1), more=TRUE)
print(plot2, position=c(0, 1/3, 1, 2/3), more=TRUE)
print(plot3, position=c(0, 0, 1, 1/3))

## y scale
xyplot(mpg~disp | factor(gear),data=mtcars,
       layout=c(3,1),aspect=1,
       scales = list(y=list(at=seq(10,30,10))))

## panel argument
xyplot(mpg ~ disp | factor(gear), data=mtcars,
       layout=c(3, 1), aspect=1,
       panel=function(...) {
         panel.xyplot(...)
         panel.abline(h=29, lty="dashed")
         panel.text(470, 29.5, "efficiency criterion",
                    adj=c(1, 0), cex=.7)
         
       })

xyplot(mpg ~ disp | factor(gear), data=mtcars,
       layout=c(3, 1), aspect=1,
       panel=function(x, y, ...) {
         panel.lmline(x, y)
         panel.xyplot(x, y, ...)
       })

xyplot(NOx ~ E | C, data = ethanol,
       prepanel = function(x, y) prepanel.loess(x, y),
       panel = function(x, y) {
         panel.grid(h = -1, v = 2)
         panel.xyplot(x, y, pch = 16, col = "blue")
         panel.loess(x, y, col = "red")
       },
       aspect = "xy",
       main = "prepanel = function(x, y)
       prepanel.loess(x, y)")

##
packet <- outer(levels(barley$year), levels(barley$site), paste)
as.vector(aperm(packet, 1:2)) # (1) prem.cond = 1:2인 경우의 패킷 순서
as.vector(aperm(packet, 2:1))    # (2) prem.cond = 2:1인 경우의 패킷 순서
# 그래프 그릴 때는그냥 year*site로 사용하면 된다
dotplot(variety ~ yield | year * site, data = barley, layout = c(6, 2),
        xlab = "Barley Yield (bushels/acre) ", ylab = NULL,
        perm.cond = c(2, 1),
        main = "variety ~ yield | year * site, perm.cond = c(2, 1)
        ")

dotplot(variety ~ yield | year * site, data = barley, layout = c(6, 2),
        xlab = "Barley Yield (bushels/acre) ", ylab = NULL,
        perm.cond = c(1, 2),
        main = "variety ~ yield | year * site, perm.cond = c(1, 2)
        ")

##splom
trellis.par.set(theme = col.whitebg())
super.sym <- trellis.par.get("superpose.symbol")
splom(~iris[1:4], groups = Species, data = iris,
      panel = panel.superpose,
      pscales = list(
        list(labels = c("4.0", "5.0", "6.0", "7.0", "8.0")),
        list(at = c(2, 3, 4)),
        list(limits = c(1, 10)),
        list(at = seq(0.5, 2.5, 0.5))),
      key = list(title = "Three Varieties of Iris",
                 columns = 3,
                 points = list(pch = super.sym$pch[1:3],
                               col = super.sym$col[1:3]),
                 text = list(c("Setosa", "Versicolor", "Virgi
                               nica"))))

##ggplot
p <- ggplot(mtcars)

p + geom_point(aes(x=disp,y=mpg,color=gear),size=4) +
  scale_y_continuous(name="miles per gallon", limits = c(0,40))+
  scale_x_continuous(name="displacement (cu.in.)")

p + geom_point(aes(x=disp, y=mpg)) +
  scale_y_continuous(trans="log",breaks=seq(10, 40, 10)) +
  scale_x_continuous(trans="log",breaks=seq(100, 400, 100)) +
  geom_line(aes(x=disp, y=mpg), stat="smooth",method="lm")

p + geom_point(aes(x=disp, y=mpg)) +
  scale_x_continuous(trans="log") +
  scale_y_continuous(trans="log") +
  geom_line(aes(x=disp, y=mpg), stat="smooth",method="lm") +
  coord_trans(x="exp", y="exp")

p + geom_point(aes(x=disp,y=mpg)) + facet_wrap(~gear,nrow=1)

p + geom_point(aes(x=disp, y=mpg)) +
  theme_bw()
p + geom_point(aes(x=disp, y=mpg)) +
  theme(axis.title.y=element_text(angle=0, vjust=.5))
p + geom_point(aes(x=disp, y=mpg)) +
  theme(axis.title.y=element_blank())
p + geom_point(aes(x=disp, y=mpg)) +
  labs(title="Vehicle Fuel Efficiency")

gcLimits <- data.frame(category=c("2WD car",
                                  "4WD car",
                                  "2WD small pick-up truck",
                                  "4WD small pick-up truck",
                                  "2WD std pick-up truck",
                                  "4WD std pick-up truck"),
                       limit=c(29, 24, 20, 18, 17, 16))

p + geom_point(aes(x=disp, y=mpg))+
  geom_hline(data=gcLimits,
             aes(yintercept=limit),
             linetype="dotted") +
  geom_text(data=gcLimits,
            aes(y=limit + .1, label=category),
            x=70, hjust=0, vjust=0, size=3)


#--------------------5강-----------------------#

by_country = organdata %>% group_by(consent_law, country) %>%
  summarize_if(is.numeric, funs(mean, sd), na.rm = TRUE) %>%
  ungroup()

p = ggplot(data = by_country,
           mapping = aes(x = roads_mean, y = donors_mean))
p + geom_point() + geom_text(mapping = aes(label = country), hjust = 0)

##
library(ggrepel)
elections_historic %>% select(2:7)
p_title = "Presidential Elections: Popular & Electoral College Margins"
p_subtitle = "1824-2016"
p_caption = "Data for 2016 are provisional."
x_label = "Winner's share of Popular Vote"
y_label = "Winner's share of Electoral College Votes"
p = ggplot(elections_historic, aes(x = popular_pct, y = ec_pct,
                                   label = winner_label))

p + geom_hline(yintercept = 0.5, size = 1.4, color = "gray80") +
  geom_vline(xintercept = 0.5, size = 1.4, color = "gray80") +
  geom_point() +
  geom_text_repel() +
  scale_x_continuous(labels = scales::percent) +
  scale_y_continuous(labels = scales::percent) +
  labs(x = x_label, y = y_label, title = p_title, subtitle = p_subtitle,
       caption = p_caption)

p = ggplot(data = by_country,
           mapping = aes(x = gdp_mean, y = health_mean))

p + geom_point() +
  geom_text_repel(data = subset(by_country,gdp_mean > 25000),
                  mapping = aes(label = country))

p + geom_point() +
  geom_text_repel(data = subset(by_country,
                                gdp_mean > 25000 | health_mean < 1500 |country %in% "Belgium"),
                  mapping = aes(label = country))

##

organdata$ind <- organdata$ccode %in% c("Ita","Spa") & organdata$year > 1980
p = ggplot(data=organdata,
           mapping = aes(x=roads,
                         y=donors,color=ind))
p + geom_point() + 
  geom_text_repel(data=subset(organdata,ind),
                  mapping =aes(label=ccode))+
  guides(label=FALSE,color=FALSE)

##
p = ggplot(data = organdata, mapping = aes(x = roads, y = donors))
p + geom_point() + annotate(geom = "text", x = 91, y = 33,
                            label = "A surprisingly high \n recovery rate.",
                            hjust = 0)

p + geom_point() +
  annotate(geom = "rect", xmin = 125, xmax = 155,
           ymin = 30, ymax = 35, fill = "red", alpha = 0.2) +
  annotate(geom = "text", x = 157, y = 33,
           label = "A surprisingly high \n recovery rate.", hjust = 0)

p = ggplot(data = organdata, 
           mapping = aes(x = roads, y = donors,
                         color = world))
##
p + geom_point() + scale_x_log10() +
  scale_y_continuous(breaks = c(5,15, 25),
                     labels = c("Five", "Fifteen","Twenty Five"))

p + geom_point() +
  scale_color_discrete(labels = c("Corporatist","Liberal", "Social Democratic", "Unclassified")) +
  labs(x = "Road Deaths",y = "Donor Procurement", color = "Welfare State")

p + geom_point() + labs(x = "Road Deaths", y = "Donor Procurement") +
  guides(color = FALSE)

#--------------------6강-----------------------#
p <- ggplot(data=practice, aes(x=no,y=pm10))
p <- p + geom_line() + labs(x="Date",y="PM10")
p <- ggplot(data=practice, aes(x=no,y=n_article))
p <- p + geom_line() + labs(x="Date",y="# of News Article")

library(cowplot)
cowplot::plot_grid(p1,p2,nrow=2,rel_heightts = c(0.75,0.25),align="v")

##
head(yahoo)
p <- ggplot(data=yahoo, aes(x=Employees, y=Revenue))
p + geom_path(color="gray80") +
  geom_text(aes(color=Mayer, label=Year),
            size=5,fontface="bold")+
  theme(legend.position="bottom")+
  labs(color = "Mayer is CEO",
       x = "Employess", y="Revenue(Million)",
       title = "Yahoo Employees vs Revenues, 2004-2014")+
  scale_x_continuous(labels = scales::dollar)+
  scale_y_continuous(labels = scales::comma)

##
p = ggplot(data = yahoo,
           mapping = aes(x = Year, y = Revenue/Employees))

p + geom_vline(xintercept = 2012) +
  geom_line(color = "gray60", size = 2) +
  annotate("text", x = 2013, y = 0.44,
           label = " Mayer becomes CEO", size = 4) +
  labs(x = "Year\n",
       y = "Revenue/Employees",
       title = "Yahoo Revenue to Employee Ratio, 2004-2014")

##
p_lab = "Amount Owed, in thousand of Dollors" 
p_title = "Outstanding Student Loans" 
p_subtitle = "44 million borrowers owe a total ~" 
p_caption = "Source: FRD NY" 
f_labs = c(`Borrowers` = "Percept of\n all Borrowers", `Balances` = "Percent of \n all Balances")

p + geom_bar(stat = "identity") + 
  scale_fill_brewer(type = "qual", palette = "Dark2") +
  scale_y_continuous(labels = scales::percent) + 
  guides(fill=FALSE) +
  theme(strip.text.x = element_text(face = "bold")) + 
  labs(y = NULL, x = p_xlab, 
       caption = p_caption, 
       title = p_title,
       subtitle = p_subtitle) +
  facet_grid(~ type, labeller = as_labeller(f_labs)) +
  coord_flip()


