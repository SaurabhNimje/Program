#Install required packages (if not installed)
install.packages("ggplot2")
install.packages("caret")
install.packages("class")
install.packages("gridExtra")

# Load libraries
library(ggplot2)
library(caret)
library(class)
library(gridExtra)

# Load IRIS dataset
data(iris)

# Data Visualization - Scatter Plot
plot1 <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) + 
  geom_point(size = 3) + ggtitle("Sepal Length vs Width")

plot2 <- ggplot(iris, aes(x = Petal.Length, y = Petal.Width, color = Species)) + 
  geom_point(size = 3) + ggtitle("Petal Length vs Width")

grid.arrange(plot1, plot2, nrow = 1) # Display plots side by side

# Splitting dataset into training (80%) and testing (20%)
set.seed(123)
trainIndex <- createDataPartition(iris$Species, p = 0.8, list = FALSE)
trainData <- iris[trainIndex, ]
testData <- iris[-trainIndex, ]

# Applying K-Nearest Neighbors (KNN) Algorithm
trainLabels <- trainData$Species
testLabels <- testData$Species

knn_model <- knn(train = trainData[, 1:4], test = testData[, 1:4], cl = trainLabels, k = 5)

# Confusion Matrix - Model Evaluation
conf_matrix <- confusionMatrix(knn_model, testLabels)
print(conf_matrix)

# Accuracy Calculation
accuracy <- sum(knn_model == testLabels) / length(testLabels)
print(paste("Accuracy:", round(accuracy * 100, 2), "%"))

