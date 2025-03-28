#Install required packages (if not installed)
install.packages("arules")
install.packages("arulesViz")

# Load libraries
library(arules)
library(arulesViz)

# Load a sample transactional dataset (Groceries dataset)
data("Groceries")

# View summary of dataset
summary(Groceries)

# Apply Apriori algorithm to find association rules
rules <- apriori(Groceries, parameter = list(supp = 0.01, conf = 0.5, minlen = 2))

# Inspect top 10 rules
inspect(head(rules, 10))

# Visualize the rules using scatter plot
plot(rules, method = "scatterplot", measure = c("support", "confidence"), shading = "lift")

# Graph-based visualization of top 5 rules
subrules <- head(rules, 5)
plot(subrules, method = "graph", engine = "igraph")

