# Install required packages (if not installed)
install.packages("arules")
install.packages("arulesViz")

# Load libraries
library(arules)
library(arulesViz)

# Load dataset (Groceries dataset from arules package)
data("Groceries")

# Inspect the dataset
summary(Groceries)

# Apply Apriori algorithm with support=0.01 and confidence=0.3
rules <- apriori(Groceries, parameter = list(supp = 0.01, conf = 0.3, target="rules"))

# Inspect top 5 association rules
inspect(head(rules, 5))

# Visualize association rules
plot(rules, method = "graph", control = list(type = "items"))

