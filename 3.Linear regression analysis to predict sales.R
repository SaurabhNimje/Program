# Load required libraries
library(tidyverse)
library(caret)

# Load the marketing dataset (you can replace it with your own dataset)
data("marketing", package = "datarium")

# Inspect the data
head(marketing)

# Split the data into training and test sets
set.seed(123) # Set seed for reproducibility
training.samples <- marketing$sales %>% createDataPartition(p = 0.8, list = FALSE)
train.data <- marketing[training.samples, ]
test.data <- marketing[-training.samples, ]

# Build the multiple linear regression model
model <- lm(sales ~ youtube + facebook + newspaper, data = train.data)

# Summarize the model
summary(model)

# Make predictions on the test set
predictions <- predict(model, newdata = test.data)

# Model performance: RMSE (Root Mean Square Error)
rmse <- RMSE(predictions, test.data$sales)
print(paste("RMSE: ", round(rmse, 2)))

# R-squared value
r_squared <- R2(predictions, test.data$sales)
print(paste("R-squared: ", round(r_squared, 2)))

# Example prediction for new data (change the values as needed)
new_data <- data.frame(youtube = c(500), facebook = c(200), newspaper = c(100))
predicted_sales <- predict(model, newdata = new_data)
print(paste("Predicted Sales: ", round(predicted_sales, 2)))

