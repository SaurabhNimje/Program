# Load the built-in mtcars dataset
data(mtcars)

# Perform PCA (scale the data to standardize variables)
pca_result <- prcomp(mtcars, scale. = TRUE)

# Display PCA summary (shows variance explained)
summary(pca_result)

# View the principal component loadings
pca_result$rotation

# Plot the PCA biplot
biplot(pca_result, main = "PCA Biplot", scale = 0)

# Calculate the proportion of variance explained
variance <- pca_result$sdev^2
prop_variance <- variance / sum(variance)

# Plot the Scree Plot (Proportion of Variance Explained)
plot(prop_variance, type = "b", 
     xlab = "Principal Component", 
     ylab = "Proportion of Variance Explained", 
     main = "Scree Plot")

# Plot the Cumulative Variance Explained
plot(cumsum(prop_variance), type = "b", 
     xlab = "Principal Component", 
     ylab = "Cumulative Proportion of Variance Explained", 
     main = "Cumulative Variance Explained")

