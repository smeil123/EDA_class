datavis.ca? 어느 홈페이지에 들어가면 시각화를 다양한 언어로 만들어둔게 있다

**이 두가지 모두 EDA가 필요하다**
* 알고싶은 문제가 명확한 경우
* 데이터는 있는데 문제가 불분명한 경우
	* 뭘하고싶은지 모르겠는데 일단 수집하고 보는거?


EDA를 할 때 주의할 점
* 2D로 표현가능한데 3D를 사용할 필요없다.
* 잘못된 전달, 보여주고 싶은 부분만 극대화해서 데이터를 외곡하면 안된다. 스케일을 다르게 바꿔서 그린 경우

단, 스케일을 같게(단위를 같게) 그리고 데이터 자체의 외곡이 없는 한 데이터의 특징을 최대한 잘 보여주도록 강조하는 것이 좋다.

**게슈탈트의 법칙**
* 근접성 : 인접한 형태들을 같은 집단으로 인지
* 유사성 : 비슷한 형태끼리 같은 집단으로 인지
* 연결성 : 연결된 개체들을 하나의 단위로 인지
* 연속성 : 연속되는 형태를 하나의 집단으로 인지
* 폐쇄성 : 불완전한 형태도 완전한 형태로 인지
* 형과 배경 : 형태와 배경을 분리해서 인지
* 공동성 :  같은 방향으로 물체가 움직인다고 인지
* 대칭성 : 대칭된 그룹을 통합된 하나의 집단으로 인지

**Plot in R**
```
x1 <- 1:5
y1 <- x1^2
z1 <- 5:1
(mat1 <- cbind(x1,y1,z1))
op <- par(no.readonly = TRUE)
par(mfrow=c(2,3))
plot(y1, main="using index")
plot(x=x1, y=y1, main="x")
plot(mat1, main="using matrix")
plot(x=x1, y=y1, type="l", main="line")
plot(x=x1, y=y1, type="h", main="high density")
plot(x=x1, y=y1, type="n", main="no plotting")
par(op)

```

**그래프에 그리는 선이 중요한 이유**
데이터의 의미를 해석하는데 도움을 준다
예를 들어, 단기적으로 중요한데 장기적으로 안중요하다고 생각하는 사람이 있음을 선으로 그어서 표현
```
# ==================== 소스순번: 003 ==================== 

cars[1:4,]
z <- lm(dist ~ speed, data = cars)
is(z)
z$coef
plot(cars, main = "abline")
# horizontal
abline(h = 20)
abline(h = 30)
# vertical
abline(v = 20, col="blue")
# y = a + bx
abline(a = 40, b = 4, col="red")
# reg 인수
abline(z, lty = 2, lwd = 2, col="green")
# coef 인수
abline(z$coef, lty = 3, lwd = 2, col="red")
```

R그래프 함수가 각각 어떤 역할을 하는지가 시험문제로 출제된다
예를 들어 코드와 그래프를 매칭시키기

## ggplot 설치하기
```
my_packages = c("tidyverse","broom","coefplot","cowplot","gapminder","GGally",
                "ggrepel","ggridges","gridExtra","here","interplot","margins",
                "maps","mapproj","mapdata","MASS","quantreg","rlang","scales",
                "survey","srvyr","viridis","viridisLite","devtools")

install.packages(my_packages,repos="https://cran.rstudio.com")
devtools::install_github("kjhealy/socviz")

```
## ggplot 
```
library(ggplot2)
library(gapminder)

p <- ggplot(data=gapminder,
            mapping = aes(x=gdpPercap,y=lifeExp))

p + geom_point()

p <- ggplot(data = gapminder, mapping = aes (x=gdpPercap, y = lifeExp))
p + geom_point()
p + geom_smooth()
p + geom_point() + geom_smooth()
p + geom_point() + geom_smooth(method="lm")
p + geom_point() + geom_smooth(method="gam")+scale_x_log10()

p + geom_point() + 
  geom_smooth(method="gam")+
  scale_x_log10(labels=scales::dollar) # scale을 달러로 해서 라벨을 달러로 변환한 값을 적어줌 
```
### mapping
```
# mapping -> 데이터 사상만 바꿈?
p <- ggplot(data=gapminder,mapping=aes(x=gdpPercap, y=lifeExp,
                                       color=continent))

p <- ggplot(data=gapminder,mapping=aes(x=gdpPercap, y=lifeExp,
                                       color='purple'))

p + geom_point() + geom_smooth(method="loess")+scale_x_log10()
```

### 시간에 따른 국가별 그래프
```
p <- ggplot(data=gapminder, mapping=aes(x = year, y=gdpPercap))
p + geom_line(aes(group=country))

# 국가별로 그래프를 나눈다 
p + geom_line(aes(group=country)) + facet_wrap(~continent) 

p <- ggplot(data=gapminder, mapping = aes(x=year,y=gdpPercap))
p + geom_line(color="gray70",aes(group=country))+
  geom_smooth(size=1.1,method="loess",se=FALSE)+
  scale_y_log10(labels=scales::dollar)+
  facet_wrap(~continent,ncol=5)+
  labs(x = "Year",
       y = "GDP per capita",
       title = "GDP per capita on Five Continents")

```

##  관련 사이트
[https://github.com/andrewheiss/fancy-minard](https://github.com/andrewheiss/fancy-minard)

# 공부해야하는것
* ggplot을 그리기 위해 데이터형식을 어떻게 해야하는가
* ggplot에 있는 명령어의 의미를 이해하기

<!--stackedit_data:
eyJoaXN0b3J5IjpbNDQ1MDQ3MDg3LDExNTgxMzg5NzAsLTQ3Nz
MwNjcyNCwzMjcyMDg1MDUsLTc1OTY3MTM3MCwtMzUxMTMyOTk1
LC04NjgzODkwNzUsLTM0OTMzODcwOSwtODAwMDA3MTk2LC0yMD
Q5MDMyMjM2LC0zNDI0NjI0NDldfQ==
-->