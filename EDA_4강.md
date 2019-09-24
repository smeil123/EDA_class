


### plot , xyplot
(Lattice package)
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
```


<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE5NTc5MjkyODEsMTIxMTMzOTM3NywtMz
k3ODk1MDkyLDE5Njk1MDY3MDQsODg1NDY2NTM1XX0=
-->