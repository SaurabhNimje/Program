# Install required packages (if not installed)
install.packages("tm")
install.packages("caret")
install.packages("e1071")

# Load necessary libraries
library(tm)  # Text mining
library(caret)  # Machine learning
library(e1071)  # Naive Bayes

# Load dataset (SMS Spam Collection)
data <- read.csv("sms_spam.csv", stringsAsFactors = FALSE)
colnames(data) <- c("label", "message")  # Rename columns

data$label <- factor(data$label)  # Convert label to factor


# Text Preprocessing
corpus <- VCorpus(VectorSource(data$message))
corpus <- tm_map(corpus, content_transformer(tolower))  # Convert to lowercase
corpus <- tm_map(corpus, removePunctuation)  # Remove punctuation
corpus <- tm_map(corpus, removeNumbers)  # Remove numbers
corpus <- tm_map(corpus, removeWords, stopwords("en"))  # Remove stopwords
corpus <- tm_map(corpus, stripWhitespace)  # Remove extra spaces

# Create Document-Term Matrix (DTM)
dtm <- DocumentTermMatrix(corpus)
dtm <- removeSparseTerms(dtm, 0.99)  # Remove sparse terms

dataset <- as.data.frame(as.matrix(dtm))
dataset$label <- data$label  # Add label to dataset

# Split data into training and testing sets
set.seed(123)
trainIndex <- createDataPartition(dataset$label, p = 0.8, list = FALSE)
trainData <- dataset[trainIndex, ]
testData <- dataset[-trainIndex, ]

# Train Naïve Bayes Model
model <- naiveBayes(label ~ ., data = trainData)

# Predict on test data
predictions <- predict(model, testData)

# Evaluate model performance
conf_matrix <- confusionMatrix(predictions, testData$label)
print(conf_matrix)

# Display sample output
print("Sample Predictions:")
print(head(data.frame(Actual = testData$label, Predicted = predictions), 10))


