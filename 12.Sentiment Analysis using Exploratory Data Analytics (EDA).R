# Install required packages (if not installed)
install.packages("tidyverse")
install.packages("tidytext")
install.packages("tm")
install.packages("wordcloud")
install.packages("syuzhet")
install.packages("ggplot2")

# Load necessary libraries
library(tidyverse)
library(tidytext)
library(tm)
library(wordcloud)
library(syuzhet)
library(ggplot2)

# Load dataset (Amazon Reviews dataset example)
data <- read.csv("amazon_reviews.csv", stringsAsFactors = FALSE)
colnames(data) <- c("id", "rating", "text")  # Rename columns

# Convert text to lowercase
data$text <- tolower(data$text)

# Remove punctuation, numbers, and stopwords
corpus <- VCorpus(VectorSource(data$text))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removeWords, stopwords("en"))
corpus <- tm_map(corpus, stripWhitespace)

# Convert to tidy format
text_df <- data.frame(text = sapply(corpus, as.character), stringsAsFactors = FALSE)

# Sentiment Analysis using Syuzhet
sentiments <- get_nrc_sentiment(text_df$text)

# Summarize sentiment scores
sentiment_scores <- colSums(sentiments)
print(sentiment_scores)

# Visualize sentiment scores
sentiment_df <- data.frame(sentiment = names(sentiment_scores), count = sentiment_scores)
ggplot(sentiment_df, aes(x = sentiment, y = count, fill = sentiment)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "Sentiment Analysis using EDA in R", x = "Sentiment", y = "Count")

