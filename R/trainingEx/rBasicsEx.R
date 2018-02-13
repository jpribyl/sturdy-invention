##########################
# 1. 2^5 in R?
##########################
2^5


##########################
# 2. Create a vector called stock.prices with the following data points: 23,27,23,21,34
##########################

stock.prices <- c(23,27,23,21,34)
stock.prices


##########################
# 3. Assign names to the price data points relating to the day of the week, starting with Mon, Tue, Wed, etc...
##########################

days <- c('mon','tues','wed','thurs', 'fri', 'sat', 'sun')

#slice the days to make them the same length as the prices vector
names(stock.prices) <- days[1:5]
stock.prices


##########################
# 4. What was the average (mean) stock price for the week? (You may need to reference a built-in function) 
##########################

mean(stock.prices)


##########################
# 5. Use the over.23 vector to filter out the stock.prices vector and only return the day and prices where the price was over $23
##########################

over.23 <- stock.prices > 23
stock.prices[over.23]


##########################
# 6. Use a built-in function to find the day the price was the highest
##########################

max.day <- stock.prices == max(stock.prices)
max(stock.prices)
stock.prices[max.day]

