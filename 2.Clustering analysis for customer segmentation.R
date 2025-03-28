# Load necessary library
library(ggplot2)

# Load the dataset
Mall_Customers <- read.csv("Mall_Customers.csv")

# Data Summary
summary(Mall_Customers)

# Check for missing values
any(is.na(Mall_Customers))

# Select relevant features for clustering
data <- Mall_Customers[, c("Age", "Income", "Spending.Score")]

# Determine the optimal number of clusters using the Elbow Method
set.seed(123)
wss <- sapply(1:10, function(k) {
  kmeans(data, centers = k, nstart = 10)$tot.withinss
})

# Plot the Elbow Method
plot(1:10, wss, type = "b", pch = 19, frame = FALSE,
     xlab = "Number of clusters (k)", ylab = "Total within-cluster sum of squares")

# Apply K-Means Clustering with the optimal number of clusters (e.g., k = 5)
set.seed(123)
kmeans_result <- kmeans(data, centers = 5, nstart = 10)

# Add cluster labels to the original data
Mall_Customers$Cluster <- as.factor(kmeans_result$cluster)

# Visualize clusters
ggplot(Mall_Customers, aes(x = Income, y = Spending.Score, color = Cluster)) +
  geom_point(size = 3) +
  labs(title = "Customer Segments", x = "Annual Income (k$)", y = "Spending Score (1-100)") +
  theme_minimal()


