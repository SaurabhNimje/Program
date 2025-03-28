# Load necessary libraries
library(ggplot2)
library(dplyr)
library(corrplot)
library(summarytools)

# Load the dataset
# Replace `mtcars` with your dataset. Use read.csv() or read_excel() if importing from a file.
data <- mtcars

# 1. Basic Information about the Dataset
cat("Dataset Overview:\n")
print(dim(data))          # Dimensions of the dataset
print(str(data))          # Structure of the dataset
print(summary(data))      # Summary statistics

# 2. Checking for Missing Values
cat("\nMissing Values Summary:\n")
print(sapply(data, function(x) sum(is.na(x))))  # Count missing values in each column

# 3. Detecting Outliers using Boxplots
cat("\nOutliers Analysis:\n")
par(mfrow = c(2, 2))  # Arrange plots in a 2x2 grid
for (col in names(data)) {
  if (is.numeric(data[[col]])) {
    boxplot(data[[col]], main = paste("Boxplot of", col), col = "skyblue", horizontal = TRUE)
  }
}

# 4. Correlation Matrix for Numeric Variables
cat("\nCorrelation Matrix:\n")
numeric_data <- select_if(data, is.numeric)  # Select numeric columns
cor_matrix <- cor(numeric_data)             # Calculate correlation matrix
print(cor_matrix)
corrplot(cor_matrix, method = "circle", type = "upper", tl.cex = 0.8)

# 5. Visualizing Pairwise Relationships (Scatterplot Matrix)
cat("\nScatterplot Matrix:\n")
pairs(numeric_data, col = "darkgreen", pch = 19)

# 6. Distribution of Each Column
cat("\nDistribution of Each Column:\n")
par(mfrow = c(2, 2))  # Reset plot layout
for (col in names(numeric_data)) {
  hist(numeric_data[[col]], main = paste("Histogram of", col), col = "lightblue", xlab = col)
}

# 7. Summary Report
cat("\nDetailed Summary Report:\n")
print(dfSummary(data))

# 8. Grouped Analysis (e.g., by a categorical variable, if present)
if ("cyl" %in% names(data)) {
  cat("\nGrouped Analysis by 'cyl':\n")
  print(data %>%
          group_by(cyl) %>%
          summarise(across(everything(), mean, na.rm = TRUE)))
}

