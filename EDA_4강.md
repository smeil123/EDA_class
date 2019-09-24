

# Lattice Package

### plot , xyplot
```
library(lattice)
attach(pressure)
plot(temperature,pressure)
xyplot(pressure ~ temperature)
```
** 두개 차이점 **
* y축이 가로로 나온다
* x축 간격이 넓어진다
* xyplot이 보기 좀 편리해지게 나온다
* xyplot는 grid(격자)기반이기 때문에 그룹되 그래프를 그릴때 유용하다

* 각 함수마다 어떤 그래피인지
	* bwplot() -> boxplot() 등등..

```
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

xyplot(mpg~disp | factor(gear),data=mtcars,
       layout = c(1,3
),aspect=2)
```
### position argument
#### lattice를 이용해서 여러개의 그래프 위치를 조정해가며 한번에 그릴 수 있다
```
## subset + potision
# (left, bottom,right,top)
# 화면을 나누지 않고 위치를 조정해서 여러개의 그래프를 그릴 수 있다

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

### y축 scale
```
xyplot(mpg~disp | factor(gear),data=mtcars,
       layout=c(3,1),aspect=1,
       scales = list(y=list(at=seq(10,30,10))))
```

### panel
 그래프 안에 선넣기

```
xyplot(mpg ~ disp | factor(gear), data=mtcars,
       layout=c(3, 1), aspect=1,
       panel=function(...) {
         panel.xyplot(...)
         panel.abline(h=29, lty="dashed")
         panel.text(470, 29.5, "efficiency criterion",
                    adj=c(1, 0), cex=.7)
      
 })
```
**각 그래프마다 기울기 그리기**
```
xyplot(mpg ~ disp | factor(gear), data=mtcars,
       layout=c(3, 1), aspect=1,
       panel=function(x, y, ...) {
         panel.lmline(x, y)
         panel.xyplot(x, y, ...)
       })
```

### prepanel
panel 크기를 조절한다.
* aspect = xy 가 데이터를 외곡되게 보여줄 수 있다
* 45도가 왜곡주지 않고 사람들이 제대로 인식할 수 있는데 이를 prepanel이 잡아준다
```
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

### 데이터에 level이 많을 때
```
 level : 몇개의 범주가 있는지 확인
# paste 합치기
packet <- outer(levels(barley$year), levels(barley$site), paste)
as.vector(aperm(packet, 1:2)) # (1) prem.cond = 1:2인 경우의 패킷 순서
as.vector(aperm(packet, 2:1))    # (2) prem.cond = 2:1인 경우의 패킷 순서
# 그래프 그릴 때는그냥 year*site로 사용하며면 된다
dotplot(variety ~ yield | year * site, data = barley, layout = c(6, 2),
        xlab = "Barley Yield (bushels/acre) ", ylab = NULL,
        perm.cond = c(2, 1),
        main = "variety ~ yield | year * site, perm.cond = c(2, 1)
")

```

### splom
scatterplot을 그려준다
```
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
### trellis패키지의 기본 설정을 바꿀 수 있다
```
names(trellis.par.get())
show.settings()
trellis.par.set(list(add.text=list(col="yellow")))
show.settings()

```

## ggplot2


## 참고사이트
* [https://statkclee.github.io/viz/viz-trellis.html](https://statkclee.github.io/viz/viz-trellis.html)
* 
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTQ3MTA2MDU3Myw1NjYyNzUzMzgsOTA5OT
A5MjIyLC0xODUxOTEwMDQyLC0xMDY3ODYzNTM5LDg2MzQwNDg2
LDEyMTEzMzkzNzcsLTM5Nzg5NTA5MiwxOTY5NTA2NzA0LDg4NT
Q2NjUzNV19
-->