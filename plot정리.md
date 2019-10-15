### R plot type
#### point type
-   **“p”**: Points
-   **“l”**:  Lines
-   **“b”**:  Both    
-   **“c”**: The lines part alone of  “b”    
-   **“o”**: Both “overplotted”    
-   **“h”**: Histogram like (or high-density) vertical lines    
-   **“n”**:  No plotting
#### lty type
<img src="graph_image/lty_type.png" width="960" />

# barplot
## barplot(height, width=1, space=NULL)
``` r
## barplot(height, width = 1, space = NULL)
# 데이터 생성
op <- par(no.readonly=TRUE) # 원래의 그래프 파라미터를 모두 저장?
bar.width <-rep(1:3,4)
par(mfow = c(2,2))
op <- par(no.readonly = =TRUE)
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

# beside = True : 각각의 값마다 막대를 그림 (한 막대에 그려져있는 것을)
# bar.y는 matrix로 그룹별로 묶여져서 그려짐
barplot(bar.y, beside=TRUE,space = c(0.5,2))
title(main="Vector Barplot by space=c(0.5,2)")

```
<img src="graph_image/bar_1.png" width="960" />

## barplot(height, names.arg, legend.text )

``` r
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

```
<img src="graph_image/bar_2.png" width="960" />
```
bar.y의 데이터
     col 1 col 2 col 3
row 1     9    35    29
row 2     8    47    47
row 3     6    42    23
row 4    27    28    12
```

* 벡터 데이터는 legend나 names.arg를 쓸때 별개의 데이터를 넣어줘야한다
* matrix는 행,열의 이름을 쓰면된다

## barplot(height, horiz,density, angle, col, border)

* horiz : 그래프를 가로로
* density : 음영선의 밀도
* angle : 막대 또는 막대 구성요소에 대한 음영선의 기울기
* col 
* border : 막대경계선

``` r
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
```
<img src="graph_image/bar_3.png" width="960" />

```r
hotdogs <- read.csv("http://datasets.flowingdata.com/hot-dog-contest-winners.csv",sep=",",header=T)

barplot(hotdogs$Dogs.eaten, names.arg=hotdogs$Year,
        col=ifelse(hotdogs$New.record==1,"blue","red"),
        xlab="Year",ylab="Hot Dogs and buns ...")

```
<img src="graph_image/bar_4.png" width="960" />

# Box Plot
vector, list, dataframe의 데이터형을 그리고 표현할 수 있다
``` r

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

```
<img src="graph_image/box_1.png" width="960" />

## subset
* boxplot을 subset별로 실행하면 결과는 중첩되어 나온다(add=Tru
* subset = colname = group
``` r
dev.off()

boxplot(len~dose, data=ToothGrowth, boxwex = 0.25, at=1:3-0.2,
        subset = supp == "VC", col="yellow",main="Guinea Pig' Tooth Growth",
        xlab = "Vitamin C does mg", ylab = "tooth length", ylim = c(0,35))
boxplot(len~dose, data=ToothGrowth, add=TRUE, boxwex=0.25, at = 1:3 + 0.2,
        subset = supp == "OJ", col = "orange")
legend(2,9,c("Ascorbic acid","Orange juice"),fill=c("yellow","orange"))
```
<img src="graph_image/box_2.png" width="960" />

### 예제파일
```r
## 데이터 형식을 모르고 그래프를 그리면 원하지 않는 모양의 형태가 나온다 
test_data <- read.csv("C:/Users/dmswl/Downloads/test2.csv")
par(mfrow = c(1, 2))

# G1과 G2의 관계를 구분
boxplot(G2~G1, data = test_data, boxwex = 0.25, at=1:9 - 0.2,
        subset = Cat == 1)
boxplot(G2~G1, data = test_data, boxwex = 0.25, at=1:11 + 0.2,
        subset = Cat == 0,
        staplewex=0.5)

```
<img src="graph_image/box_3.png" width="960" />

* 위의 데이터를 이용하면 botplot으로 나오지 않는다
* 이유) x축값이 범주형 데이터가 아니기 때문에
* test2를 ToothGrowth 형태를 보고 왜 안되는지 이해
* ToothGrowth를 보면 dose와 supp가 고정되어 있고 len값을 가지는 형태이다
<img src="graph_image/box_data_1.png" width="960" />
<img src="graph_image/box_data_2.png" width="960" />

# Dot chart
**데이터생성**
``` r
op <- par(no.readonly = TRUE)
par(mfrow = c(2,2))
month <- matrix(1:12,ncol=3)
rownames(month) <- paste("Row", 1:4)
colnames(month) <- paste("Col",1:3)
```
<img src="graph_image/dot_data1.png" width="960" />

```r
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
```
<img src="graph_image/dot_1.png" width="960" />

### color 변경 
* gdata : 그룹의 데이터의 요약값을 넣을 수 있다 ( gdata를 쓰면 축이 사라진다?)
``` r
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
```

<img src="graph_image/dot_2.png" width="960" />

# Pair
## matplot, matpoints, matlines
``` r
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
```
<img src="graph_image/pair_1.png" width="960" />

**크기,색상**
```r
op <- par(no.readonly = TRUE)
par(mfrow = c(2, 2))
matplot(mat, type = "lSo", main = "type = \"lSo\"")
matplot(mat, type = c("l","S","o"), main = "type = c(\"l\", \"S\", \"o\")")
matplot(mat, col = c("red","blue","green"), cex = c(1, 1.2, 1.4))
title(main = "c(\"red\", \"blue\", \"green\"), cex=c(1, 1.2, 1.4)")
matplot(mat, type = "l", lty = 3:5, lwd = 1:3)
title(main = "lty = 3:5, lwd = 1:3")
par(op)
```
<img src="graph_image/pair_2.png" width="960" />

## pairs()
```r
pairs(~Fertility + Education + Catholic, data=swiss,
      subset = Education <20, main = "Swiss data, Education <20",
      col = 1 + (swiss$Agriculture > 50),cex=1.2,
      pch = 1 + (swiss$Agriculture>50))
```
<img src="graph_image/pair_3.png" width="960" />


```r
pairs(iris[1:4], main = "Anderson's Iris Data--3 species",
      pch = 21, bg = c("red", "green3","blue")[unclass(iris$Species)])
```
<img src="graph_image/pair_4.png" width="960" />

# Lattice
## xyplot
```r
library(lattice)
head(mtcars)
xyplot(mpg ~ disp, data=mtcars)
```
<img src="graph_image/xyplot_1.png" width="960" />

* gear에 따라서 그래프를 그리도록 조건을 줄 수 있다
* gear를 factor형으로 변환해서 나눔
```r
xyplot(mpg ~ disp | factor(gear), data=mtcars)
```
<img src="graph_image/xyplot_2.png" width="960" />

* 범례 위치 조정
```r
xyplot(mpg~disp,data=mtcars,
       group=gear,
       auto.key=list(space="right")) # 범례를 오른쪽으로 밀어버림
```
<img src="graph_image/xyplot_3.png" width="960" />

* layout
* aspect : 그래프 너비 조정
```r
xyplot(mpg~disp | factor(gear),data=mtcars,
       layout = c(1,3),aspect=1)
```
<img src="graph_image/xyplot_4.png" width="960" />


### position argument + subset
##### lattice를 이용해서 여러개의 그래프 위치를 조정해가며 한번에 그릴 수 있다
* subset + position
* (left, bottom, right, top)
* 화면을 나누지 않고 (par(mfrow ...)) 위치를 조정해서 여러개의 그래프를 그림 
```r
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
```
<img src="graph_image/xyplot_5.png" width="960" />

### y축 scale
* y축을 10~30 으로
```r
xyplot(mpg~disp | factor(gear),data=mtcars,
       layout=c(3,1),aspect=1,
       scales = list(y=list(at=seq(10,30,10))))
```
<img src="graph_image/xyplot_6.png" width="960" />

### panel
* 그릴 수 있는 그래프 종류
<img src="graph_image/xyplot_10.png" width="960" />

 * 그래프 abline 그리기 

```r
xyplot(mpg ~ disp | factor(gear), data=mtcars,
       layout=c(3, 1), aspect=1,
       panel=function(...) {
         panel.xyplot(...)
         panel.abline(h=29, lty="dashed")
         panel.text(470, 29.5, "efficiency criterion",
                    adj=c(1, 0), cex=.7)
      
 })
```
<img src="graph_image/xyplot_7.png" width="960" />

* **각 그래프마다 기울기 그리기** : lmline
```r
xyplot(mpg ~ disp | factor(gear), data=mtcars,
       layout=c(3, 1), aspect=1,
       panel=function(x, y, ...) {
         panel.lmline(x, y)
         panel.xyplot(x, y, ...)
       })
```
<img src="graph_image/xyplot_8.png" width="960" />

### prepanel
panel 크기를 조절한다.
* aspect = xy 가 데이터를 외곡되게 보여줄 수 있다
* 45도가 왜곡주지 않고 사람들이 제대로 인식할 수 있는데 이를 prepanel이 잡아준다
```r
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
```
<img src="graph_image/xyplot_9.png" width="960" />


### Dotplot 
* 범주형 변수 그래프
*  level : 몇개의 범주가 있는지 확인
* aperm : matrix transpose
* 2개의 범주형 변수를 붙여서 packet을 만듦(year과 site를 붙임)
```r 
# paste 합치기
packet <- outer(levels(barley$year), levels(barley$site), paste)
as.vector(aperm(packet, 1:2)) # (1) prem.cond = 1:2인 경우의 패킷 순서
as.vector(aperm(packet, 2:1))    # (2) prem.cond = 2:1인 경우의 패킷 순서
# 그래프 그릴 때는그냥 year*site로 사용하면 된다
dotplot(variety ~ yield | year * site, data = barley, layout = c(6, 2),
        xlab = "Barley Yield (bushels/acre) ", ylab = NULL,
        perm.cond = c(2, 1),
        main = "variety ~ yield | year * site, perm.cond = c(2, 1)
")
```
<img src="graph_image/dotplot_1.png" width="960" />

### splom
* scatterplot을 그려준다
```r
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
```
<img src="graph_image/splom_1.png" width="960" />

### trellis패키지의 기본 설정을 바꿀 수 있다
```r
names(trellis.par.get())
show.settings()
trellis.par.set(list(add.text=list(col="yellow")))
show.settings()
```

# ggplot
<img src="graph_image/ggplot.png" width="960" />

## boxplot
```r
library(socviz)
p = ggplot(data = organdata, mapping = aes(x = country, y = donors))
p + geom_boxplot()
```
<img src="graph_image/ggplot_1.png" width="960" />

* coord_flip()은 x축과 y축의 구성을 뒤집어 표현하라는 명령어
```r
p + geom_boxplot() + coord_flip()
```
<img src="graph_image/ggplot_2.png" width="960" />

* reorder를 통해서 순서대로 나열
* x축의 이름을 없앰
```r
p = ggplot(data = organdata, mapping = aes(x = reorder(country, donors, na.rm = TRUE), y = donors))
p + geom_boxplot() + labs(x = NULL) + coord_flip()
```
<img src="graph_image/ggplot_3.png" width="960" />

* fill = world : 색을 다르게

```r
p = ggplot(data = organdata,
           mapping = aes(x = reorder(country, donors, na.rm=TRUE),y = donors, fill = world))
p + geom_boxplot() + labs(x=NULL) +
  coord_flip() + theme(legend.position = "top")
```
<img src="graph_image/ggplot_4.png" width="960" />

## point

```r
p = ggplot(data = organdata,
         mapping = aes(x = reorder(country, donors, na.rm=TRUE),
                       y = donors, color = world))

p + geom_point() + labs(x=NULL) +
  coord_flip() + theme(legend.position = "top")
```
<img src="graph_image/ggplot_5.png" width="960" />

* jitter로 noise를 줘서 같은 자리에 있는 데이터들이 보이도록 한다 
```r
p + geom_jitter() + labs(x=NULL) +
  coord_flip() + theme(legend.position = "top")
```
<img src="graph_image/ggplot_6.png" width="960" />

* position = position_jitter(width=0.15) : zitter 의 크기 조정

```r
p + geom_jitter(position = position_jitter(width=0.15)) +
  labs(x=NULL) + coord_flip() + theme(legend.position = "top")
```
<img src="graph_image/ggplot_7.png" width="960" />

* 데이터의 변형이 필요하다 

```r
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
```
<img src="graph_image/ggplot_8.png" width="960" />
<img src="graph_image/ggplot_data_1.png" width="960" />

##
* sacle_x_continuous(name,breaks,labels,limits)
	* name : x 축 label
	* breaks : 간격
	* labels
	* limits : x축 (시작, 끝)
```r
p <- ggplot(mtcars)

p + geom_point(aes(x=disp,y=mpg,color=gear),size=4) +
  scale_y_continuous(name="miles per gallon", limits = c(0,40))+
  scale_x_continuous(name="displacement (cu.in.)")
```
<img src="graph_image/ggplot1_1.png" width="960" />

* geom_line 추가
```r
p + geom_point(aes(x=disp, y=mpg)) +
  scale_y_continuous(trans="log",breaks=seq(10, 40, 10)) +
  scale_x_continuous(trans="log",breaks=seq(100, 400, 100)) +
  geom_line(aes(x=disp, y=mpg), stat="smooth",method="lm")
```
<img src="graph_image/ggplot1_2.png" width="960" />

* coord_trans : 값을 수치변환한다
```r
p + geom_point(aes(x=disp, y=mpg)) +
  scale_x_continuous(trans="log") +
  scale_y_continuous(trans="log") +
  geom_line(aes(x=disp, y=mpg), stat="smooth",method="lm") +
  coord_trans(x="exp", y="exp")
```
<img src="graph_image/ggplot1_3.png" width="960" />

### 그룹간 비교 : facet_wrap
```r
p <- ggplot(mtcars)
p + geom_point(aes(x=disp,y=mpg)) + facet_wrap(~gear,nrow=1)
```
<img src="graph_image/ggplot1_4.png" width="960" />

### theme 옵션
* them_bw() : 배경색이 반전된다(하얀색)
* element_text 
* element_blank() : 이름을 비워둔다 
* labs로 title작성
```r
p + geom_point(aes(x=disp, y=mpg)) +
  theme_bw()
p + geom_point(aes(x=disp, y=mpg)) +
  theme(axis.title.y=element_text(angle=0, vjust=.5)) # y축이름을 가로로
p + geom_point(aes(x=disp, y=mpg)) +
  theme(axis.title.y=element_blank())
p + geom_point(aes(x=disp, y=mpg)) +
  labs(title="Vehicle Fuel Efficiency")
```
<img src="graph_image/ggplot1_5.png" width="960" />

### geom_hline, geom_text
* 라인과
```r
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
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTUwNzk4MTUyMyw4NTQyMzk3NzEsMTU3NT
A5Njg5Nyw1NzEwNzUwNzIsMTMwNjgwNzkzOSwtODI1MTU5Mzkz
LDExMTg4MjIzMjAsLTE4ODk3NDU0NzUsNTA2MTEwNzg0LC0yNj
E2MzI4MjYsMTMyMDE0NjE0MCwtMjkzNzczNDY4LDU2MTEyNzc2
LC0xMjI1OTYyMDYzLC0xNDc1NDI3MjkwLDEzOTIyOTE5MywtMj
A4ODc0NjYxMl19
-->