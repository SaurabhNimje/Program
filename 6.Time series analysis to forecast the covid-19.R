# Install required packages (if not installed)
install.packages("tidyverse")
install.packages("ggplot2")
install.packages("forecast")
install.packages("tseries")

# Load libraries
library(tidyverse)
library(ggplot2)
library(forecast)
library(tseries)

# Load COVID-19 dataset
covid_data <- read.csv("https://raw.githubusercontent.com/datasets/covid-19/main/data/countries-aggregated.csv")

# Filter data for a specific country (e.g., India)
india_data <- covid_data %>% filter(Country == "India") %>% select(Date, Confirmed)

# Convert date column to Date format
india_data$Date <- as.Date(india_data$Date)

# Convert Confirmed cases into a time series object
ts_data <- ts(india_data$Confirmed, start = c(2020, 1), frequency = 365)

# Plot the time series
plot.ts(ts_data, main = "COVID-19 Confirmed Cases in India", col = "blue", lwd = 2)

# Check stationarity using Augmented Dickey-Fuller (ADF) test
adf.test(ts_data)

# Differencing if needed
diff_ts <- diff(ts_data)
plot.ts(diff_ts, main = "Differenced COVID-19 Cases", col = "red", lwd = 2)

# Fit ARIMA model
model <- auto.arima(ts_data)
summary(model)

# Forecast next 30 days
forecasted_cases <- forecast(model, h = 30)

# Plot forecasted values
plot(forecasted_cases, main = "Forecasted COVID-19 Cases", col = "darkgreen")


