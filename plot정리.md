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

```

```
bar.y의 데이터
     col 1 col 2 col 3
row 1     9    35    29
row 2     8    47    47
row 3     6    42    23
row 4    27    28    12
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTM5MjI5MTkzLC0yMDg4NzQ2NjEyXX0=
-->