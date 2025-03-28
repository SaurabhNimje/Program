#Install required packages (if not installed)
install.packages("tm")
install.packages("SnowballC")
install.packages("wordcloud")
install.packages("ggplot2")

# Load libraries
library(tm)
library(SnowballC)
library(wordcloud)
library(ggplot2)

# Sample text dataset
text_data <- c("Text mining is a powerful technique to analyze unstructured data.",
               "Machine learning algorithms enhance text analysis.",
               "Data preprocessing improves text mining outcomes.")

# Convert text data into a corpus
corpus <- Corpus(VectorSource(text_data))

# Text preprocessing: Convert to lowercase, remove punctuation, numbers, and stopwords
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, stripWhitespace)

# Stemming (reducing words to root form)
corpus <- tm_map(corpus, stemDocument)

# Create a Term-Document Matrix (TDM)
tdm <- TermDocumentMatrix(corpus)
tdm_matrix <- as.matrix(tdm)
word_freq <- sort(rowSums(tdm_matrix), decreasing = TRUE)

# Convert to data frame for visualization
word_freq_df <- data.frame(word = names(word_freq), freq = word_freq)

# Generate a Word Cloud
wordcloud(words = word_freq_df$word, freq = word_freq_df$freq, min.freq = 1,
          max.words = 50, random.order = FALSE, colors = brewer.pal(8, "Dark2"))

# Bar plot of top words
ggplot(word_freq_df[1:10,], aes(x = reorder(word, freq), y = freq)) +
  geom_bar(stat = "identity", fill = "blue") +
  coord_flip() +
  labs(title = "Top 10 Frequent Words", x = "Words", y = "Frequency")

