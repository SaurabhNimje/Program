# Install required packages (if not installed)
install.packages("igraph")
install.packages("ggraph")
install.packages("tidyverse")

# Load libraries
library(igraph)
library(ggraph)
library(tidyverse)

# Create a sample dataset (edges representing connections between nodes)
edges <- data.frame(
  from = c("A", "A", "B", "C", "C", "D", "E", "F"),
  to = c("B", "C", "D", "D", "E", "F", "G", "G")
)

# Convert the edge list into a graph object
network_graph <- graph_from_data_frame(edges, directed = FALSE)

# Plot the basic network
plot(network_graph, vertex.size = 20, vertex.color = "skyblue",
     vertex.label.color = "black", edge.color = "gray")

# Calculate centrality measures
degree_centrality <- degree(network_graph)
betweenness_centrality <- betweenness(network_graph)

# Print centrality measures
print(degree_centrality)
print(betweenness_centrality)

# Advanced visualization using ggraph
ggraph(network_graph, layout = "fr") +
  geom_edge_link(aes(edge_alpha = 0.5)) +
  geom_node_point(color = "blue", size = 5) +
  geom_node_text(aes(label = name), repel = TRUE) +
  theme_minimal()

