library(tidyverse)
library(lubridate)
library(ggmap)
library(ggrepel)
library(gridExtra)
library(pander)

cities <- read.table("C:\\Users\\dmswl\\Google 드라이브\\2019 2학기\\EDA\\데이터\\cities.txt",
                     header = TRUE, stringsAsFactors = FALSE)

troops <- read.table("C:\\Users\\dmswl\\Google 드라이브\\2019 2학기\\EDA\\데이터\\troops.txt",
                     header = TRUE, stringsAsFactors = FALSE)

temps <- read.table("C:\\Users\\dmswl\\Google 드라이브\\2019 2학기\\EDA\\데이터\\temps.txt",
                     header = TRUE, stringsAsFactors = FALSE) %>% mutate(data=dmy(date))
# troops에는 부대 이동에 관한 위치, 생존자 수, 방향, 그룹 5가지 변수
troops %>% head() %>% pandoc.table(style = "rmarkdown")

ggplot(troops, aes(x = long, y = lat, group = group)) +
  geom_path()

ggplot(troops, aes(x = long, y = lat, group = group, 
                   color = direction, size = survivors)) +
  geom_path()

# 끝을 둥글게 표현해서 이어지도록한다
ggplot(troops, aes(x = long, y = lat, group = group, 
                   color = direction, size = survivors)) +
  geom_path(lineend = "round")

# 생존자 수에 대해 스케일을 조정해서 더 눈에 띄게 만든다
ggplot(troops, aes(x = long, y = lat, group = group, 
                   color = direction, size = survivors)) +
  geom_path(lineend = "round") +
  scale_size(range = c(0.5, 15))

# 범례제거 : lab,guides 를 조정
ggplot(troops, aes(x = long, y = lat, group = group, 
                   color = direction, size = survivors)) +
  geom_path(lineend = "rounded") +
  scale_size(range = c(0.5, 15)) + 
  scale_colour_manual(values = c("#DFC17E", "#252523")) +
  labs(x = NULL, y = NULL) + 
  guides(color = FALSE, size = FALSE)

# geom_point와 geom_text를 추가해서 도시위치 표시
# vjust를 이용해서 수직으로 떨어진 거리에 텍스트를 붙임 (hjust는 수평 )
ggplot() +
  geom_path(data = troops, aes(x = long, y = lat, group = group, 
                               color = direction, size = survivors),
            lineend = "round") +
  geom_point(data = cities, aes(x = long, y = lat)) +
  geom_text(data = cities, aes(x = long, y = lat, label = city), vjust = 1.5) +
  scale_size(range = c(0.5, 15)) + 
  scale_colour_manual(values = c("#DFC17E", "#252523")) +
  labs(x = NULL, y = NULL) + 
  guides(color = FALSE, size = FALSE)

# geom_text_repel을 이용하면 vjust를 안써도 적당히 표
ggplot() +
  geom_path(data = troops, aes(x = long, y = lat, group = group, 
                               color = direction, size = survivors),
            lineend = "round") +
  geom_point(data = cities, aes(x = long, y = lat),
             color = "#DC5B44") +
  geom_text_repel(data = cities, aes(x = long, y = lat, label = city),
                  color = "#DC5B44", family = "Open Sans Condensed Bold") +
  scale_size(range = c(0.5, 15)) + 
  scale_colour_manual(values = c("#DFC17E", "#252523")) +
  labs(x = NULL, y = NULL) + 
  guides(color = FALSE, size = FALSE)

# 위도와 경도로 원하는 지점의 박스를 만들고
march.1812.europe <- c(left = -13.10, bottom = 35.75, right = 41.04, top = 61.86)

# zoom : 3(대륙)~21(건물)
# where : 다운로드한 타일이 캐시된 폴더의 경로 
march.1812.europe.map <- get_stamenmap(bbox = march.1812.europe, zoom = 5,
                                       maptype = "terrain", where = "cache")

# ggmap()을 통해 plot을 그린다
ggmap(march.1812.europe.map)

# 수채화 처럼 표현 : maptype : vatercolor
march.1812.europe.map.wc <- get_stamenmap(bbox = march.1812.europe, zoom = 5,
                                          maptype = "watercolor", where = "cache")
ggmap(march.1812.europe.map.wc)

# Minard plot을 오버레이해서 유럽의 다른 지역과 관련하여 행진이 발생한 위치를 그림
ggmap(march.1812.europe.map.wc) +
  geom_path(data = troops, aes(x = long, y = lat, group = group, 
                               color = direction, size = survivors),
            lineend = "round") +
  scale_size(range = c(0.5, 5)) + 
  scale_colour_manual(values = c("#DFC17E", "#252523")) +
  guides(color = FALSE, size = FALSE) +
  theme_nothing()  # ggamp에서만 주어지는 기능으로 좌표나 lab이 안보이도록

# 북동유럽만 확대하기
# 박스를 다시만들고, zoom을 확대하고 
march.1812.ne.europe <- c(left = 23.5, bottom = 53.4, right = 38.1, top = 56.3)

march.1812.ne.europe.map <- get_stamenmap(bbox = march.1812.ne.europe, zoom = 8,
                                          maptype = "terrain-background", where = "cache")

march.1812.plot <- ggmap(march.1812.ne.europe.map) +
  geom_path(data = troops, aes(x = long, y = lat, group = group, 
                               color = direction, size = survivors),
            lineend = "round") +
  geom_point(data = cities, aes(x = long, y = lat),
             color = "#DC5B44") +
  geom_text_repel(data = cities, aes(x = long, y = lat, label = city),
                  color = "#DC5B44", family = "Open Sans Condensed Bold") +
  scale_size(range = c(0.5, 10)) + 
  scale_colour_manual(values = c("#DFC17E", "#252523")) +
  guides(color = FALSE, size = FALSE) +
  theme_nothing()

march.1812.plot

### 온도와 시간
ggplot(data = temps, aes(x = long, y = temp)) +
  geom_line() +
  geom_text(aes(label = temp), vjust = 1.5)

# 위의 플롯과 연결되도록 해야하는데 이때 X축이 정렬되도록 범위를 제한해야한다 -> scale_x_continuous
ggplot_build(march.1812.plot)$layout$panel_ranges[[1]]$x.range

# 보여줄 txt를 열로 추가한 데이터 생성
temps.nice <- temps %>%
  mutate(nice.label = paste0(temp, "°, ", month, ". ", day))

# scale_x_continuous-> limit : x축의 시작과 끝을 지정(범위 밖에 데이터는 자른다)
# name, breaks, labels, limits가 있다 
# coord_catesian : 범위를 지정해주되 범위 밖의 데이터도 표시(원래 데이터의 일부를 보는 느낌 )
temps.1812.plot <- ggplot(data = temps.nice, aes(x = long, y = temp)) +
  geom_line() +
  geom_label(aes(label = nice.label),
             family = "Open Sans Condensed Bold", size = 2.5) + 
  labs(x = NULL, y = "° Celsius") +
  scale_x_continuous(limits = c(23.5,38.1)) +
  scale_y_continuous(position = "right") +
  coord_cartesian(ylim = c(-35, 5)) +  # Add some space above/below
  theme_bw(base_family = "Open Sans Condensed Light") + # 글씨체? 
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.minor.y = element_blank(),
        axis.text.x = element_blank(), axis.ticks = element_blank(),
        panel.border = element_blank()) # 필요없는 축,정보를 다 제거 

temps.1812.plot


# 위의 지도 그래프와 결함 -> gridExtra
both.1812.plot <- rbind(ggplotGrob(march.1812.plot),
                        ggplotGrob(temps.1812.plot))

grid::grid.newpage()
grid::grid.draw(both.1812.plot)

grid.arrange(march.1812.plot,temps.1812.plot,nrow=2)
