


# EDA 중간 과제
* 표지필요 없음
* 15일까지 제출하자(더바빠지기 전에)
* 주관식 문항은 X
* 질문의 의도가 긍정인지 부정인지 주의해서 봐야한다(Reverse coding)
* 문항을 보고 어떤 주제를 분석할 지 찾아보고 분석해야한다
* "어떤 차이"인지 생각(나이차이, 세대차이..?)
* 70년대생 90년대생의 차이를 보여줘야한다
	* 원하는 분석 내용, 요구 사항 명세를 들어본다
* 파이썬으로 해도 된다
* 사회학분석은 범주형 데이터를 주로 다룬다
* 내가 던진 질문에 맞는 그래프를 그리는 것이 중요하다

## 작은 과제
* ggplot에서 원하는 부분에 원을 그리는 방법

# 과제하는 순서
1. 원하는 분석 내용, 요구 사항 명세를 들어본다
2. 해당 사항이 없을 경우,
데이터 수집 환경이라든가 메타 데이터, 코드북을 중심으로 어떤 주제의 분석이 가능한지 살피면서 주제를 정한다.
3. 정해진 주제에 맞는 항목들을 추출한다.
큰 데이터에서 주제에 맞는 항목들로 작은 데이터로 만든다
4. 응답 분포를 본다
5. 항목들간 관계를 본다

(이 순서대로 진행하면서 필요없는 변수를 제거한 이유를 드러내는 것이 좋다, 모든 경우를 고려하고 많이 생각, 의견의 반증을 다 확인했는지 알 수 있게 된다)

# 그래프

```
my_packages = c("tidyverse","broom","coefplot","cowplot","gapminder","GGally",
                "ggrepel","ggridges","gridExtra","here","interplot","margins",
                "maps","mapproj","mapdata","MASS","quantreg","rlang","scales",
                "survey","srvyr","viridis","viridisLite","devtools")

install.packages(my_packages,repos="https://cran.rstudio.com")
devtools::install_github("kjhealy/socviz")

# ==================== 소스순번: 035 ==================== 

col.table <- function(cols, main=NULL, fg=NULL) {
  n <- length(cols)
  plot(seq(n), rep(1, n), xlim = c(0, n), ylim = c(0, 1), type = "n", xlab = "", ylab = "", axes = F)
  
  main.txt <- if(is.null(main)) paste("Color Table by", deparse(substitute(cols)))
  else main
    title(main=main.txt)
  
  fg <- if(is.null(fg)) unlist(lapply(cols, function(x)
    ifelse(mean(col2rgb(x)) > 127 | toupper(x) %in% c("WHITE", "#FFFFFF"), "black", "white")))
  else rep(fg, n)
  
  for(i in 1:n) {
    polygon(c(i - 1, i - 1, i, i), c(0.05, 1, 1, 0.05), col = cols[i]) # 직사각형 
    text(mean(c(i - 1, i)), 0.52, labels = cols[i], srt=90, adj=0.5, col=fg[i], cex=1.5)
  }
}
op <- par(no.readonly = TRUE)
par(mfrow=c(2,1))
col.table(1:16)
col.table(5:20)
par(op)

cols <- colors() #모든 칼라명 
length(cols)
grep("sky",cols,value=TRUE)
col2rgb(grep("sky",cols,value=TRUE)) #칼라마다 RGB값 출력
op <- par(no.readonly = TRUE)
par(mfrow=c(2,1),mar=c(1,1,3,1))
col.table(grep("sky",cols,value=TRUE))
col.table(grep("red",cols,value=TRUE))
par(op)


#Apha는 투명도 
seqs <- seq(0, 255, length = 20)
alpha <- toupper(as.character.hexmode(seqs)) 
op <- par(no.readonly = TRUE)
par(mfrow = c(5, 1), mar = c(0, 0, 2, 0))
col.table(paste("#FF0000", alpha, sep = ""), fg = 1)
col.table(paste("#00FF00", alpha, sep = ""), fg = 1)
col.table(paste("#0000FF", alpha, sep = ""), fg = 1)
col.table(rainbow(20), main = "Alpha Channel 사용 안함")
col.table(rainbow(20, alpha = seq(0, 1, length = 20)),
          
          main = "Alpha Channel 사용", fg=1)

par(op)


# 채도/명암 조절
hsv(0.5,0.5,0.5)

# 원을 그리는 방법 
op <- par(no.readonly=TRUE)
par(pty="s")
# 방법1
angle <- (0:360) * pi/180
# 방법 2
angle <- seq(-pi,pi,length=361)
x <- 3 + 5 * cos(angle) # 중심 (3,4)
y <- 4 + 5 * sin(angle)
plot(x,y,type="l",main="circle with radius 5 and center (3,4)")

# barplot
# 그래프 그릴 데이터 생성
op <- par(no.readonly = TRUE)
bar.width <- rep(1:3, 4)
bar.width
par(mfrow = c(2, 2))
op <- par(no.readonly = TRUE)
set.seed(1)
bar.x <- round(runif(12) * 50)
set.seed(2)
bar.y <- matrix(bar.x, ncol = 3, byrow = T)

# 그래프 그리기
barplot(bar.x, width = 1)
title(main = "Vector Barplot by default width")
barplot(bar.x, width = bar.width) #  막대 두께 변화 
title(main = "Vector Barplot by width 1:3")
barplot(bar.x, space = 2)
title(main = "Vector Barplot by space = 2")
## 그룹별로 묶어서 보여줄 때 좋을 듯 -> multi variable
barplot(bar.y, beside = TRUE, space = c(0.5, 2)) # 공간을 다르게 
title(main="Vector Barplot by space = c(0.5, 2)")
par(op)

# 항목에 이름 넣기,legend
op <- par(no.readonly = TRUE)
rownames(bar.y) <- paste("row", 1:4)
colnames(bar.y) <- paste("col", 1:3)
par(mfrow = c(2, 2))
barplot(bar.x, names.arg = letters[1:length(bar.x)])
title(main = "Vector Barplot using names.arg")
barplot(bar.y)
title(main = "Matrix Barplot using default names.arg")
barplot(bar.x, legend.text = letters[1:length(bar.x)])
title(main = "Vector Barplot using legend.text")
barplot(bar.y, legend.text = T)
title(main = "Matrix Barplot using legend.text = T")
par(op)


##########################################
hotdogs <- read.csv("http://datasets.flowingdata.com/hot-dog-contest-winners.csv",sep=",",header=T)
head(hotdogs)
barplot(hotdogs$Dogs.eaten)
barplot(hotdogs$Dogs.eaten,col="red",
        names.arg=hotdogs$Year,
        xlab="Year",
        ylab="먹은 개수")
title(main = "핫도그 많이 먹기")

barplot(hotdogs$Dogs.eaten,
        col=ifelse(hotdogs$New.record==1,"blue","red"),
        names.arg=hotdogs$Year,
        xlab="Year",
        ylab="먹은 개수")

#####################################
# boxplot -> 여러가지 데이터 형식으로 입력값으로 줄 수 있다
# 알아두면 좋을 옵션 
# add (barplot이랑 조금 다른 점?)
# notch

op <- par(no.readonly = TRUE)
par(mfrow = c(2, 2))
set.seed(1)
norm1 <- round(rnorm(100, 3, 2), digits = 2)
set.seed(2)
norm2 <- round(rnorm(100, 3, 3), digits = 2)
# (1) 데이터 형식 vector 1개 
boxplot(norm1)
title("boxplot of one vector")
# (2) 데이터 형식 vector 2개 
boxplot(norm1, norm2)
title("boxplot of two vectors")
list1 = list(data1 = norm1, data2 = norm2,
             data3 = rnorm(100, 7, 4))

# (3) 데이터 형식 list 
boxplot(list1) # list를 입력값으로 넣는다 
title("boxplot of simple list")
# (4) 데이터 형식 dataframe
dimnames(InsectSprays)
dim(InsectSprays)
boxplot(count ~ spray, data = InsectSprays, col = "lightgray")
title("boxplot of dataframe by formula")
par(op)

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
boxplot(y, varwidth = T, width = 4:1)겟
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


## 데이터 형식을 모르고 그래프를 그리면 원하지 않는 모양의 형태가 나온다 
test_data <- read.csv("C:/Users/dmswl/Downloads/test2.csv")
par(mfrow = c(1, 2))

# G1과 G2의 관계를 구분
boxplot(G2~G1, data = test_data, boxwex = 0.25, at=1:9 - 0.2,
        subset = Cat == 1, col = "yellow")
boxplot(G2~G1, data = test_data, boxwex = 0.25, at=1:11 + 0.2,
        subset = Cat == 0, col = "yellow", add=TRUE, staplewex=0.5)

# 에이데이터는 botplot으로 나오지 않는다
# 이유) x축값이 범주형 데이터가 아니기 때문에
# test2를 ToothGrowth 형태를 보고 왜 안되는지 이해
# ToothGrowth를 보면 dose와 supp가 고정되어 있고 len값을 가지는 형태이다

#########################################33
# dotchart
# 산점도랑 비슷
# 여러 데이터 형식을 사용할 수 있다

op <- par(no.readonly = TRUE)
par(mfrow = c(2, 2))
month <- matrix(1:12, ncol = 3)
rownames(month) <- paste("Row", 1:4)
colnames(month) <- paste("Col", 1:3)
# (1) 벡터
dotchart(as.vector(month), label = month.abb)
title(main = "x is a vector")
# (2) 행렬
dotchart(month)
title(main = "x is a matrix")
# (3) group
quarter.name <- c("1QT", "2QT", "3QT", "4QT")
quarter <- factor(row(month), label = quarter.name)
quarter
dotchart(month, groups = quarter)
title(main = "groups = quarter")
# (4) groups, labels
name <- c("1st", "2nd", "3rd")
dotchart(month, groups = quarter, labels = name)
title(main = "groups = quarter, labels = name")


```

## 3D그래프
* 3D그래프를 그려야하는 이유 ) 두 변수의 기울기를 보려줄때
* 예를 들어 남/여 임금차이는 성별 한 변수의 기울기만 보여주고 그래프를 따로그리는 것이 보기 편하다
* 반면) 남/여 + 연령 별 임금차이를 보여주는 것은 두변수의 차이를 보여주는 것이기 때문에 3D가 잘보여줄 것이다



### pairs()
* width와 length를 볼 때 빨간색 집단을 빼면 positive한 상관관계를 가짐을 알 수 있다. 
* 데이터의 상관관계, 연속형변수/범주형 변수임을 한번에 다 확인할 수 있는 매우 중요한 부분

### 정리 
처음에는 차이를 많이 보여주기 위해 많은 정보를 담고 있는 그래프를 그린다.
나중에는 내가 보여주고 싶은 부분에 집중할 수 있는 그래프를 그려야 한다.

<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE0OTc1OTA1OTEsLTQ0NjM0MzA1NiwtMT
Y0NzY0ODI1NywtMTA4MjI3MDIxMywtMTUyODc3MTgxNCwtNzM2
MjE0NTE3LC0yNjgzNDQzMDMsNDEyMTg0ODgwLDYwMzY4NDk2MC
w3MzA5OTgxMTZdfQ==
-->