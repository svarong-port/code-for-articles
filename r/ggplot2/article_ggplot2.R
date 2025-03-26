# Code for Data Viz in R With ggplot2


# 1. Install ggplot2
install.packages("ggplot2")

# 2. Load ggplot2
library(ggplot2)

# 3. Load the dataset
install.packages("palmerpenguins")
library(palmerpenguins)

head(penguins)
?penguins



# ----------------------------------



# 4. Basic ggplot2

## 4.1 Basic graph
ggplot(penguins, aes(x = body_mass_g,
                     y = flipper_length_mm)) +
  geom_point()

## 4.2 Adding a variable
ggplot(penguins, aes(x = body_mass_g,
                     y = flipper_length_mm,
                     color = species)) +
  geom_point()

## 4.3 Defining an attribute
ggplot(penguins, aes(x = body_mass_g,
                     y = flipper_length_mm,
                     color = species)) +
  geom_point(shape = 22)



# ----------------------------------



# 5. More Customisations

## 5.1 Theme
ggplot(penguins, aes(x = body_mass_g,
                     y = flipper_length_mm,
                     color = species)) +
  geom_point() +
  
  # Apply classic theme
  theme_classic()


## 5.2 Text
ggplot(penguins, aes(x = body_mass_g,
                       y = flipper_length_mm,
                       color = species)) +
  geom_point() +
  theme_classic() +
  
  # Adjust text size
  theme(plot.title = element_text(size = 16, face = "bold"),
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14),
        legend.title = element_text(size = 14),
        legend.text = element_text(size = 12),
        strip.text = element_text(size = 14, face = "bold")) +
  
  # Add a title, labels, and a legend
  labs(title = "Penguin Body Mass vs. Flipper Length",
       x = "Body Mass (g)",
       y = "Flipper Length (mm)",
       color = "Penguin Species") +
  
  # Add annotation
  annotate("text",
           x = 3000,
           y = 225,
           label = "Larger penguins tend to \n have longer flippers",
           size = 5,
           color = "gray",
           hjust = 0)
  
## 5.3 Facet

### 5.3.1 facet_wrap()
ggplot(penguins, aes(x = body_mass_g,
                     y = flipper_length_mm,
                     color = species)) +
  geom_point() +
  theme_bw() +
  
  # Use facet_wrap()
  facet_wrap(~species)

### 5.3.2 facet_grid()
ggplot(penguins, aes(x = body_mass_g,
                     y = flipper_length_mm,
                     color = species)) +
  geom_point() +
  theme_bw() +
  
  # Use facet_grid()
  facet_grid(sex~species)