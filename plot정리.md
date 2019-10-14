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

```
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTE4NTk1ODMzMCwxMzkyMjkxOTMsLTIwOD
g3NDY2MTJdfQ==
-->