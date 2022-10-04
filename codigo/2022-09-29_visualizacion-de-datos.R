library(readr)
library(dplyr)
library(ggplot2)
library(forcats)

# Importando los datos ----

desarrollo <- read_csv("datos/datos-desarrollo.csv")

# Gráfico 1 : PIB Chile ----

desarrollo |> 
  filter(pais == "Chile", anio >= 2000) |> 
  ggplot(aes(x = anio, y = pib)) +
  geom_line(color = "#27e3de", size = 1) + #para colores color-hex.com
  geom_point(color = "#178885", size = 2) +
  scale_y_continuous(limits = c(0,14000),
                     labels = scales::dollar) +
  labs(title = "Producto Interno Bruto (PIB) de Chile",
       subtitle = "periodo entre 2000 y 2020",
       y = "PIB en dólares",
       x = NULL,
       caption = "Elaboración propia a partir de datos 
       del Banco Mundial") +
  theme_bw()

# guardar el gráfico con un comando

ggsave("figuras/linea-pib-chile.png", width = 10, height = 7)

# Gráfico 2

colores <- c("Chile" = "#1007fb", "Argentina" = "#fdf41f",
             "Uruguay" = "#dd4300")

desarrollo |> 
  filter(pais %in% c("Chile", "Argentina", "Uruguay")) |> 
  ggplot(aes(x = anio, y = esperanza_vida, 
             color = fct_reorder2(pais, anio, esperanza_vida)))+
  geom_line(size = 0.75) +
  scale_y_continuous(limits = c(0, 85)) +
  scale_x_continuous(breaks = seq(1960, 2020,by = 10))+
  scale_color_manual(values = colores) +
  labs(title = "Evolución de la esperanza de vida en Chile, Argentina y Uruguay",
       subtitle = "(1960-2020)",
       x = NULL,
       y = "esperanza de vida",
       color = NULL)+
  theme_bw() +
  theme(legend.position = "bottom")

