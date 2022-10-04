library(readr)
library(dplyr)
library(ggplot2)
library(ggtext)# para editar anotaciones y etiquetas
library(gghighlight)# para destacar valores en un gráfico

desarrollo <- read_csv("datos/datos-desarrollo.csv") 

# creamos un subset de los datos: los paises de sudamérica

sudamerica <- filter(desarrollo, pais %in% c("Chile", "Argentina", "Uruguay",
                                             "Paraguay", "Bolivia", "Perú",
                                             "Ecuador", "Colombia", "Venezuela",
                                             "Brasil", "Suriname", "Guyana"))

# ejemplo 1: cómo agregar etiquetas

sudamerica |> 
  filter(anio == 2020) |> 
  ggplot(aes(y = reorder(pais, esperanza_vida), x = esperanza_vida)) +
  geom_col(fill = "turquoise4") +
  geom_text(aes(label = esperanza_vida),
            hjust = 1.5,
            color = "white",
            fontface = "bold") +
  labs(title = "Esperanza de vida en 2020",
       subtitle = "Paises de Sudamérica",
       y = NULL,
       x = "esperanza de vida") +
  theme_bw()

# ejemplo 2

ggplot(sudamerica, aes(anio, pib, color = pais))+
  geom_line(size = 2) +
  gghighlight(pais == "Chile",
              unhighlighted_params = aes(color = "#b2d3c9")) +
  scale_color_manual(values = "#006e4e") +
  labs(title = "Comparación del PIB en Chile con el resto de Sudamérica") +
  theme_bw()

# ejemplo 3: anotaciones

desarrollo |> 
  filter(pais == "Ruanda") |> 
  ggplot(aes(anio, esperanza_vida))+
  geom_line(size = 2, color = "magenta4") +
  geom_label(aes(x = 1995, y = 10, label = "1993: año del genocidio \nde la población Tutsi"),
             hjust = -0.01,
             fill = "magenta4",
             color = "white",
             fontface = "bold") +
  scale_y_continuous(limits = c(0,80)) +
  scale_x_continuous(breaks = seq(1960, 2020, 10)) +
  labs(title = "Esperanza de vida en Ruanda",
       x = NULL,
       y = NULL)+
  theme_bw()

# ejemplo 4: cómo indicar a que corresponde cada cosa del gráfico (una alternativa a la leyenda)

sudamerica |> 
  filter(pais %in% c("Uruguay", "Argentina")) |> 
  ggplot(aes(anio, pib, color = pais))+
  geom_line(size = 2, show.legend = FALSE)+
  scale_color_manual(values = c("Uruguay" = "#0081a7",
                                "Argentina" = "#f07167")) +
  labs(title = "Evolución del PIB en <b style=color:'#f07167'>Argentina</b> y <b style=color:'#0081a7'>Uruguay</b>")+
  theme_bw() +
  theme(plot.title = element_markdown())
  