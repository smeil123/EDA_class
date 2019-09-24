


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



<!--stackedit_data:
eyJoaXN0b3J5IjpbMTk2OTUwNjcwNCw4ODU0NjY1MzVdfQ==
-->