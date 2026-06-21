# Basic plot()

# Load dataset
data(trees)

# View structure
str(trees)

# x, y
plot(
  x = trees$Girth,
  y = trees$Volume
)

# Plot type
plot(
  x = trees$Girth,
  y = trees$Volume,
  type = "l"
)

# Labels: xlab, ylab, main
plot(
  x = trees$Girth,
  y = trees$Volume,
  xlab = "Girth (Inches)",
  ylab = "Volume (Cubic Feet)",
  main = "Tree Girth and Volume"
)

# Colour, shape, and size
plot(
  x = trees$Girth,
  y = trees$Volume,
  xlab = "Girth (Inches)",
  ylab = "Volume (Cubic Feet)",
  main = "Tree Girth and Volume",
  col = "darkgreen",
  pch = 5,
  cex = 1.5
)

# Regression line
plot(
  x = trees$Girth,
  y = trees$Volume,
  xlab = "Girth (Inches)",
  ylab = "Volume (Cubic Feet)",
  main = "Tree Girth and Volume",
  col = "darkgreen",
  pch = 5,
  cex = 1.5
)

abline(
  lm(Volume ~ Girth, data = trees),
  col = "red",
  lwd = 2
)