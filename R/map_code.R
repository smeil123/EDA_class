library(socviz)
library(dplyr)
library(ggplot2)
library(maps)


election %>% select(state, total_vote,
                    r_points, pct_trump, party, census) %>%
  sample_n(5)

us_states = map_data("state")

party_colors = c("#2E74C0", "#CB454A")
p0 = ggplot(data = subset(election, st %nin% "DC"),
            mapping = aes(x = r_points,
                          y = reorder(state, r_points),
                          color = party))
p1 = p0 + geom_vline(xintercept = 0, color = "gray30") +
  geom_point(size = 2)
p2 = p1 + scale_color_manual(values = party_colors)
p3 = p2 + scale_x_continuous(breaks = c(-30, -20, -10, 0, 10, 20, 30, 40),
                             labels = c("30\n (Clinton)", "20", "10", "0",
                                        "10", "20", "30", "40\n(Trump)"))
p3 + facet_wrap(~ census, ncol=1, scales="free_y") +
  guides(color=FALSE) + labs(x = "Point Margin", y = "") +
  theme(axis.text=element_text(size=8))



p = ggplot(data = us_states, mapping = aes(x = long, y = lat,
                                           group = group))
p + geom_polygon(fill = "white", color = "black")


p = ggplot(data = us_states, aes(x = long, y = lat, group = group,
                                 fill = region))
p + geom_polygon(color = "gray90", size = 0.1) + guides(fill = FALSE)


library(mappproj)

p = ggplot(data = us_states,
           mapping = aes(x = long, y = lat,
                         group = group, fill = region))
p + geom_polygon(color = "gray90", size = 0.1) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) +
  guides(fill = FALSE)

election$region = tolower(election$state)
us_states_elec = left_join(us_states, election)


p = ggplot(data = us_states_elec,
           aes(x = long, y = lat,
               group = group, fill = party))
p + geom_polygon(color = "gray90", size = 0.1) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45)

install.packages('ggthemes')
library(ggthemes)

p0 = ggplot(data = us_states_elec,
            mapping = aes(x = long, y = lat,
                          group = group, fill = party))
p1 = p0 + geom_polygon(color = "gray90", size = 0.1) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45)
p2 = p1 + scale_fill_manual(values = party_colors) +
  labs(title = "Election Results 2016", fill = NULL)
p2 + theme_map()


p0 = ggplot(data = us_states_elec,
            mapping = aes(x = long, y = lat, group = group, fill = pct_trump))
p1 = p0 + geom_polygon(color = "gray90", size = 0.1) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45)
p1 + labs(title = "Trump vote") + theme_map() + labs(fill = "Percent")


p0 = ggplot(data = us_states_elec,
            mapping = aes(x = long, y = lat, group = group, fill = d_points))
p1 = p0 + geom_polygon(color = "gray90", size = 0.1) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45)
p2 = p1 + scale_fill_gradient2() + labs(title = "Winning margins")
p2 + theme_map() + labs(fill = "Percent")
p3 = p1 + scale_fill_gradient2(low = "red", mid = scales::muted("purple"),
                               high = "blue", breaks = c(-25, 0, 25, 50, 75)) +
  labs(title = "Winning margins")
p3 + theme_map() + labs(fill = "Percent")



county_full = left_join(county_map, county_data, by = "id")

p = ggplot(data = county_full,
           mapping = aes(x = long, y = lat, fill = pct_black,
                         group = group))
p1 = p + geom_polygon(color = "gray90", size = 0.05) + coord_equal()
p2 = p1 + scale_fill_brewer(palette="Greens")


p2 + labs(fill = "US Population, Percent Black") +
  guides(fill = guide_legend(nrow = 1)) +
  theme_map() + theme(legend.position = "bottom")







