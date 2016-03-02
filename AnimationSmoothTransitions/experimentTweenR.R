#https://gist.github.com/walkerke/5f7faa8ae10c5991b352
library(idbr) #us census data
library(ggplot2)
library(gganimate) #animations with ggplot #devtools::install_github("dgrtwo/gganimate")
library(tweenr) #In order to create smooth animation between states of data, tweening is necessary
#devtools::install_github("thomasp85/tweenr")
library(countrycode) #standardise country codes
library(dplyr)

idb_api_key("Your API key goes here")

africa_fips <- countrycode(c('Nigeria', 'Uganda', 'Tanzania', 'Ghana'), 
                           origin = 'country.name', destination = 'fips104')

df <- idb5(country = africa_fips, year = 1980:2016, variables = c('TFR', 'IMR'), country_name = TRUE)

df <- df %>%
  select(-FIPS) %>%
  mutate(ease = 'linear')

dt <- tween_elements(df, time = 'time', group = 'NAME', ease = 'ease', nframe = 100)

p <- ggplot(data = dt) + 
  geom_point(aes(x = IMR, y = TFR, color = .group, frame = time), 
             size = 8) + 
  geom_text(aes(x = IMR + 2, y = TFR + 0.2, color = .group, label = .group, frame = time)) + 
  geom_text(aes(x = 105, y = 3.5, frame = time, 
                label = round(time, 0)), color = 'black', size = 14) + 
  guides(color = FALSE) + 
  theme_grey(base_size = 14) + 
  xlab('Infant mortality rate') + 
  ylab('Total fertility rate')

animation::ani.options(interval = 0.000001)

gg_animate(p, title_frame = FALSE, filename = 'imr_tfr.gif')
