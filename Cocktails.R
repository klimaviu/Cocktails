library(readr)
library(tidyverse)
library(tidyr)
library(dplyr)
library(ggplot2)
library(janitor)
library(wesanderson)
library(png)
library(ggimage)
library(cowplot)

#@JacobHakim2

cocktails <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-26/cocktails.csv')
boston_cocktails <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-26/boston_cocktails.csv')

clean_vec <- function (x, refactor=FALSE) {
  
  require(magrittr, quietly=TRUE)
  
  if (!(is.character(x) || is.factor(x))) return(x)
  
  x_is_factor <- is.factor(x)
  
  old_names <- as.character(x)
  
  new_names <- old_names %>%
    tolower(.)
  
  if (x_is_factor && refactor) factor(new_names) else new_names
  
}

#fixing groups
cocktails <- cocktails %>% 
  mutate(
    alcoholic = fct_recode(factor(alcoholic),
                           "Non alcoholic" = "Non Alcoholic"),
    ingredient = clean_vec(ingredient),
    drink = clean_vec(drink)
  )

theme_set(theme_light())

#The distribution of alcoholic vs non-alcoholic drinks
cocktails %>% 
  ggplot()+
  geom_bar(aes(alcoholic, fill = alcoholic))

cocktails %>% 
  group_by(ingredient) %>% 
  summarise(ingredient_total = sum(n())) %>% 
  arrange(desc(ingredient_total)) %>% 
  top_n(10) %>% 
  ggplot()+
  geom_col(aes(reorder(ingredient, -ingredient_total), ingredient_total, fill = ingredient))+
  labs(x ="Ingredient", y = "Count")

top <- cocktails %>% 
  group_by(ingredient) %>% 
  summarise(count = sum(n())) %>% 
  arrange(desc(count)) %>% 
  top_n(30)

top_angle <-  90 - 360 * (c(1:nrow(top)) - 0.5)/nrow(top)

top %>% 
  ggplot(aes(reorder(ingredient, -count), count))+
  geom_bar(position="stack", stat="identity", aes(fill = ingredient), show.legend = FALSE) +
  scale_x_discrete()+
  ylim(-180, 100) +
  theme_void()+
  coord_polar(direction = 1,
              clip = "off")+
  geom_text(data=top, aes(x=ingredient, y=count, label=ingredient), 
            color="#000000", family="Calibri",
            alpha= 0.8 , size=3, inherit.aes = FALSE,
            angle = top_angle, hjust = -0.1)+
  theme(panel.background = element_rect( color = "white"))+
  scale_fill_manual(values = wes_palette("Zissou1", type = "continuous", n = nrow(top)))+
  annotate(geom = "text",
           x=0,y=-175,
           hjust=.5, vjust=.25,
           label="ingredients",
           size=12, lineheight=.8,
           family="serif",
           color="#100404")

categories <- cocktails %>% 
  group_by(category) %>% 
  summarise(count = sum(n()))

top_angle_cocktails <-  90 - 360 * (c(1:nrow(categories)) - 0.5)/nrow(categories)

categories %>% 
  ggplot(aes(reorder(category, -count), count))+
  geom_col(aes(fill = category), show.legend = FALSE)+
  theme(axis.text.x = element_text(angle = 90))

cocktails %>% 
  ggplot(aes(category, ingredient_number))+
  geom_col(aes(fill = category), show.legend = FALSE)+
  theme(axis.text.x = element_text(angle = 90))

#Who puts alcohol in cocoa? Is there alcohol in cocoa?

cocktails %>%
  filter(category == "Cocoa")%>% 
  ggplot()+
  geom_bar(aes(alcoholic, fill = alcoholic))

#Ok, thank god

cocktails %>%
  filter(category == "Ordinary Drink")%>% 
  ggplot()+
  geom_bar(aes(alcoholic, fill = alcoholic))

#use kable()
cocktails %>%
  filter(category == "Ordinary Drink") %>% 
  group_by(ingredient) %>% 
  summarise(sum = sum(n())) %>% 
  arrange(desc(sum)) %>% 
  top_n(10)

#Which category uses the most ingredients?
cocktails %>%
  group_by(category) %>% 
  summarise(avg_ingredients = mean(ingredient_number)) %>% 
  arrange(desc(avg_ingredients))

cocktails %>%
  group_by(category) %>% 
  summarise(avg_ingredients = mean(ingredient_number)) %>% 
  ggplot()+
  geom_col(aes(reorder(category, -avg_ingredients), avg_ingredients, fill = category),
           show.legend = FALSE)+
  theme(axis.text.x = element_text(angle = 90))+
  labs(x ="Category", y = "Average ingredient count")+
  scale_fill_manual(values = wes_palette("Zissou1", type = "continuous", n = 11))

#What are the top 5 most commonly recommended glass types?

cocktails %>% 
  group_by(glass) %>% 
  summarise(sum = sum(n())) %>% 
  arrange(desc(sum)) %>% 
  top_n(5)

#Most common gin combinations?
#Ingredients, naudojami kartu su gin
#Select all cocktails where one of the ingredients is gin
#Group by   ingredient, select all drink_id where gin exists

gin <- cocktails %>% filter(ingredient == "gin")
gin_id <- gin$id_drink

gin_combos <- cocktails %>% 
  filter(id_drink %in% gin_id)

gin_combos %>% 
  filter(ingredient != "gin") %>% 
  group_by(ingredient) %>% 
  summarise(sum = sum(n())) %>% 
  arrange(desc(sum)) %>% 
  top_n(10) %>% 
  ggplot()+
  geom_col(aes(reorder(ingredient,-sum), sum, fill = ingredient))+
  theme(axis.text.x = element_text(angle = 90))

#Longest drink names?

cocktails %>% 
  mutate(name_length = nchar(drink)) %>% 
  group_by(drink) %>% 
  summarise(name_length = mean(name_length)) %>% 
  arrange(desc(name_length)) %>% 
  top_n(10)

weird_drink1 <- cocktails %>% 
  filter(drink == "’57 chevy with a white license plate")

weird_drink1 %>% 
  ggplot()+
  geom_col(aes(ingredient))

#Ingredients that are used in the smallest proportion?

#Drinks that use gin and lemon juice
gin <- cocktails %>% filter(ingredient == "gin")
gin_id <- gin$id_drink

gin_combos <- cocktails %>% 
  filter(id_drink %in% gin_id)

lemon <- cocktails %>% filter(ingredient == "lemon juice")
lemon_id <- lemon$id_drink

lemon_combos <- cocktails %>% 
  filter(id_drink %in% lemon_id)

both_gin_lemon_juice <- inner_join(lemon_combos, gin_combos)

ids <- sample(both_gin_lemon_juice$id_drink, 3, replace = TRUE)

both_gin_lemon_juice %>% 
  filter(id_drink %in% ids) %>% 
  select(drink, ingredient) %>% 
  ggplot()+
  geom_count(aes(drink, ingredient, color = ingredient),
             show.legend= FALSE)+
  facet_wrap(~drink)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  scale_color_manual(values = wes_palette("Zissou1", type = "continuous", n = 10))


test <- function(cocktails, a, b){ #a nd b - characters
  
  a_id <- cocktails[which(cocktails$ingredient == a),]
  
  a_combos <- cocktails %>% 
    filter(id_drink %in% a_id)
  
  b_id <- cocktails[which(cocktails$ingredient == b),]
  
  b_combos <- cocktails %>% 
    filter(id_drink %in% b_id)
  
  both_a_b <- inner_join(a_combos, b_combos)
  
  ab_id <- both_a_b$id_drink
  
  ids <- sample(ab_id, 3, replace = TRUE)
  
  both_a_b %>% 
    filter(id_drink %in% ids) %>% 
    select(drink, ingredient) %>% 
    ggplot()+
    geom_count(aes(drink, ingredient, color = ingredient),
               show.legend= FALSE)+
    facet_wrap(~drink)+
    theme(axis.title.x=element_blank(),
          axis.text.x=element_blank(),
          axis.ticks.x=element_blank())+
    scale_color_manual(values = wes_palette("Zissou1", type = "continuous", n = 20))
  
}

with_champagne <- cocktails %>% 
  filter(ingredient == "champagne")

ids_champagne <- with_champagne$id_drink

cocktails %>% 
  filter(id_drink %in% ids_champagne) %>% 
  ggplot()+
  geom_count(aes(drink, ingredient, color = ingredient),
             show.legend= FALSE)+
  facet_wrap(~drink)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  scale_color_manual(values = wes_palette("Zissou1", type = "continuous", n = 25))

glass_types <- cocktails %>% 
  group_by(glass) %>% 
  summarise(sum = sum(n())) %>% 
  arrange(desc(sum)) %>% 
  top_n(5)

kable(glass_types)

top_glass <- glass_types$glass

cocktails %>% 
  filter(glass %in% top_glass) %>% 
  ggplot()+
  geom_bar(aes(glass))

library(stringr)

boston_cocktails %>% 
  mutate(
    measure = ifelse(grepl("/", measure, fixed = TRUE),
                     str_replace(measure, "[\d\s\d\/\d\/s\w]", "[\d\+\d\/\d]")
                     str_replace(measure, "[\d\s\w]", "[\d]"))
  )

boston_cocktails$measure <- boston_cocktails$measure %>% 
  str_replace_all(" oz", "") %>% 
  str_replace_all("\\s", "+")
