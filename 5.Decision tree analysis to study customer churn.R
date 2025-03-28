#Load required libraries
install.packages("rpart")       # For decision tree
install.packages("rpart.plot")  # For visualizing the tree
library(rpart)
library(rpart.plot)

# Set the working directory to Downloads
setwd("C:/Users/ADMIN/Documents")

# Load the dataset
churn <- read.csv('WA_Fn-UseC_-Telco-Customer-Churn.csv')

# Check for missing values and remove rows with missing data
churn <- churn[complete.cases(churn), ]

# Convert necessary columns to factors
churn$SeniorCitizen <- as.factor(ifelse(churn$SeniorCitizen == 1, "Yes", "No"))
churn$Churn <- as.factor(churn$Churn)

# Simplify tenure into categories
churn$tenure_group <- cut(churn$tenure, 
                          breaks = c(0, 12, 24, 48, 60, Inf), 
                          labels = c("0-12 Month", "12-24 Month", "24-48 Month", "48-60 Month", "> 60 Month"))

# Remove unnecessary columns
churn <- churn[, !(names(churn) %in% c("customerID", "tenure"))]

# Split data into training (70%) and testing (30%) sets
set.seed(123) # For consistent results
train_index <- sample(1:nrow(churn), 0.7 * nrow(churn))
train_data <- churn[train_index, ]
test_data <- churn[-train_index, ]

# Build a decision tree model
tree_model <- rpart(Churn ~ Contract + tenure_group + PaperlessBilling, 
                    data = train_data, method = "class")

# Visualize the decision tree
rpart.plot(tree_model, main = "Decision Tree for Customer Churn")

# Make predictions on the test set
predictions <- predict(tree_model, test_data, type = "class")

# Create a confusion matrix
confusion_matrix <- table(Predicted = predictions, Actual = test_data$Churn)

# Print confusion matrix
print("Confusion Matrix:")
print(confusion_matrix)

# Calculate and display accuracy
accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
print(paste("Decision Tree Accuracy:", round(accuracy * 100, 2), "%"))

