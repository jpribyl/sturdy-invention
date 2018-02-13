##########################
# CREATING A MATRIX
##########################

#you can do pythons range() with : in R
1:10

v <- 1:10

#we can turn a vector into a matrix like this
matrix(v)

#and we can define the shape using nrow
matrix(v, nrow = 2)

#default fill is by columns - we can use byrow to fill by row first
matrix(1:12, byrow=F, nrow=4)
matrix(1:12, byrow=T, nrow=4)

#lets consider some stock prices
goog <- c(450,451,452,445,468)
msft <- c(230,231,232,233,220)
stocks <- c(goog,msft)
#we can put them into a vector
stocks

#we can also put them into a matrix separated by company
stocks.matrix <- matrix(stocks, byrow=T, nrow=2)
stocks.matrix

#if we want to label everything
days <- c('mon', 'tues', 'wed', 'thu', 'fri')
st.names <- c('goog', 'msft')

colnames(stocks.matrix) <- days
rownames(stocks.matrix) <- st.names
stocks.matrix
