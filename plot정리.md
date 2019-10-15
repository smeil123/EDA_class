### R plot type
-   **“p”**: Points
-   **“l”**:  Lines
-   **“b”**:  Both    
-   **“c”**: The lines part alone of  “b”    
-   **“o”**: Both “overplotted”    
-   **“h”**: Histogram like (or high-density) vertical lines    
-   **“n”**:  No plotting
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
## barplot(height, names.arg=NULL, legend.text = NULL)

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

# ggplot
## boxplot
```r
library(socviz)
p = ggplot(data = organdata, mapping = aes(x = country, y = donors))
p + geom_boxplot()
```
<img src="graph_image/ggplot_1.png" width="960" />

```r
p + geom_boxplot() + coord_flip()
```
<img src="graph_image/ggplot_2.png" width="960" />

```r
p = ggplot(data = organdata, mapping = aes(x = reorder(country, donors, na.rm = TRUE), y = donors))
p + geom_boxplot() + labs(x = NULL) + coord_flip()
```
<img src="graph_image/ggplot_3.png" width="960" />

```r
p = ggplot(data = organdata,
           mapping = aes(x = reorder(country, donors, na.rm=TRUE),y = donors, fill = world))
p + geom_boxplot() + labs(x=NULL) +
  coord_flip() + theme(legend.position = "top")
```
<img src="graph_image/ggplot_4.png" width="960" />

<!--stackedit_data:
eyJoaXN0b3J5IjpbLTYwOTQ4MTkzMiw1MDYxMTA3ODQsLTI2MT
YzMjgyNiwxMzIwMTQ2MTQwLC0yOTM3NzM0NjgsNTYxMTI3NzYs
LTEyMjU5NjIwNjMsLTE0NzU0MjcyOTAsMTM5MjI5MTkzLC0yMD
g4NzQ2NjEyXX0=
-->