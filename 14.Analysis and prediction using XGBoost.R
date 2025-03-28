#Install required packages (if not installed)
install.packages("xgboost")
install.packages("caret")
install.packages("ggplot2")
install.packages("Matrix")

# Load libraries
library(xgboost)
library(caret)
library(ggplot2)
library(Matrix)

# Load the dataset (Using Iris dataset as an example)
data(iris)

# Encode species as numeric for XGBoost
iris$Species <- as.numeric(factor(iris$Species)) - 1 

# Split data into training (80%) and testing (20%)
set.seed(123)
trainIndex <- createDataPartition(iris$Species, p = 0.8, list = FALSE)
trainData <- iris[trainIndex, ]
testData <- iris[-trainIndex, ]

# Convert data to matrix format required by XGBoost
trainMatrix <- xgb.DMatrix(data = as.matrix(trainData[, -5]), label = trainData$Species)
testMatrix <- xgb.DMatrix(data = as.matrix(testData[, -5]), label = testData$Species)

# Set XGBoost parameters
params <- list(
  objective = "multi:softmax",  # Multi-class classification
  num_class = 3,  # Number of classes (Setosa, Versicolor, Virginica)
  eval_metric = "mlogloss",
  max_depth = 3,
  eta = 0.3,
  nthread = 2
)

# Train the XGBoost model
xgb_model <- xgboost(params = params, data = trainMatrix, nrounds = 100, verbose = 0)

# Make predictions on test data
predictions <- predict(xgb_model, testMatrix)

# Ensure predictions match actual species levels
predicted_labels <- factor(predictions, levels = levels(testData$Species))

# Convert testData$Species to factor explicitly
testData$Species <- factor(testData$Species, levels = unique(testData$Species))

# Convert predictions to factor with matching levels
predicted_labels <- factor(predictions, levels = levels(testData$Species))

# Create Confusion Matrix
conf_matrix <- confusionMatrix(predicted_labels, testData$Species)

# Print Confusion Matrix
print(conf_matrix)


# Feature Importance Plot
importance_matrix <- xgb.importance(model = xgb_model)
xgb.plot.importance(importance_matrix)

