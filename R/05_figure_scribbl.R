

library(ggplot2)
df <- data.frame(dose = c("D0.5", "D1", "D2"),
                 len = c(4.2, 10, 29.5))
df



bar1 = ggplot(data = df, mapping = aes(x = dose, y = len)) +
  geom_bar(stat = 'identity')

bar1


# Data and mapping can be given both as global (in ggplot()) or per layer
bar1 <- ggplot() +
  geom_bar(data = df, mapping = aes(x = dose, y = len),
           stat = "identity")
bar1

bar1 + coord_flip()

ggplot(data = df, mapping = aes(x = dose, y = len)) +
  geom_bar(stat = "identity", fill = "red")


ggplot(data = df, mapping = aes(x = dose, y = len)) +
  geom_bar(stat = "identity", fill = "#A70000") +
  theme_classic()



title_size <- 18
text_size <- 16
my_theme <- theme_classic() +
  theme(axis.title.x = element_text(size = title_size),
        axis.text.x = element_text(size = text_size),
        axis.title.y = element_text(size = title_size),
        axis.text.y = element_text(size = text_size))


ggplot(data = df, mapping = aes(x = dose, y = len)) +
  geom_bar(stat = "identity", fill = "#A70000") +
  labs(x = "Dose", y = "Tooth length (cm)") +
  my_theme


ggplot(data = df, aes(x = dose, y = len, fill = dose)) +
  geom_bar(stat = "identity") +
  labs(x = "Dose", y = "Tooth length (cm)") +
  scale_fill_manual(values = c("#E69F00", "#56B4E9", "#CC79A7")) +
  my_theme



df2 <- data.frame(supp = rep(c("VC", "OJ"), each = 3),
                  dose = rep(c("D0.5", "D1", "D2"), 2),
                  len = c(6.8, 15, 33, 4.2, 10, 29.5))
head(df2)


ggplot(data = df2, aes(x = dose, y = len, fill = supp)) +
  geom_bar(stat = "identity") +
  scale_fill_brewer(palette = "Paired") +
  my_theme


data("faithful")
# Basic scatterplot
ggplot(data = faithful,
       mapping = aes(x = eruptions, y = waiting)) +
  geom_point() + my_theme


# Data and mapping can be given both as global (in ggplot()) or per layer
ggplot() +
  geom_point(mapping = aes(x = eruptions, y = waiting),
             data = faithful) + my_theme


ggplot(faithful) +
  geom_point(aes(x = eruptions, y = waiting, colour = eruptions < 3)) +
  my_theme


ggplot(faithful) +
  geom_point(aes(x = eruptions, y = waiting),
             colour = 'steelblue') +
  my_theme

ggplot(faithful) +
  geom_histogram(aes(x = eruptions), bins = 40) +
  my_theme

ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  scale_x_continuous(breaks = c(3, 5, 6)) +
  scale_y_continuous(trans = 'log10') +
  my_theme


ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_wrap(~ class) + my_theme

ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(year ~ drv) + my_theme


msleep <- na.omit(msleep)
p1 <- ggplot(msleep) +
  geom_boxplot(aes(x = sleep_total, y = vore, fill = vore)) +
  my_theme
p1


p2 <- ggplot(msleep) +
  geom_bar(aes(y = vore, fill = vore)) +
  my_theme
p2


p3 <- ggplot(msleep) +
  geom_point(aes(x = bodywt, y = sleep_total, colour = vore)) +
  scale_x_log10() +
  my_theme
p3

library(patchwork)
p1 + p2 + p3

(p1 | p2) / p3 + plot_layout(guides = 'collect') +
  plot_annotation(title = 'Mammalian sleep patterns',
                  tag_levels = 'A')

library(ggridges)
df_diamonds <- diamonds[1:100, c("color", "depth")]
ggplot(df_diamonds, aes(x = depth, y = color)) +
  geom_density_ridges() + my_theme




