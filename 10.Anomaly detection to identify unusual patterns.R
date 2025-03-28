#Install required packages (if not installed)
install.packages("ggplot2")
install.packages("dplyr")
install.packages("outliers")
install.packages("anomalize")

# Load libraries
library(ggplot2)
library(dplyr)
library(outliers)
library(anomalize)

# Generate a sample dataset with anomalies
set.seed(123)
data <- data.frame(Value = c(rnorm(98, mean = 50, sd = 10), 150, 160)) # Two anomalies added

# Boxplot to visualize anomalies
ggplot(data, aes(y = Value)) +
  geom_boxplot(fill = "skyblue", outlier.color = "red", outlier.shape = 8) +
  ggtitle("Boxplot for Anomaly Detection") +
  ylab("Value")

# Detecting anomalies using Interquartile Range (IQR)
Q1 <- quantile(data$Value, 0.25)
Q3 <- quantile(data$Value, 0.75)
IQR_value <- Q3 - Q1
lower_bound <- Q1 - 1.5 * IQR_value
upper_bound <- Q3 + 1.5 * IQR_value

# Identifying outliers
data$Anomaly <- ifelse(data$Value < lower_bound | data$Value > upper_bound, "Anomaly", "Normal")
print(data)

# Visualization with anomalies highlighted
ggplot(data, aes(x = 1:nrow(data), y = Value, color = Anomaly)) +
  geom_point(size = 3) +
  ggtitle("Anomaly Detection Using IQR") +
  xlab("Index") + ylab("Value") +
  theme_minimal()

