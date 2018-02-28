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

#just use rownames and colnames
colnames(stocks.matrix) <- days
rownames(stocks.matrix) <- st.names
stocks.matrix


##########################
# MATRIX ARITHMETIC
##########################

mat <- matrix(1:25, byrow=T, nrow=5)

#operations are done element wise
1 / mat

#we can also return boolean matrices! Just like vectors.
mat > 15

#note that mat*mat is element wise and not true mat multiplcation
mat * mat

#in order to do true matrix multiplication use %'s
mat %*% mat


##########################
# MATRIX OPERATIONS
##########################

#Revisiting the stock matrix - we can do lots of math things easily
colSums(stocks.matrix)
rowSums(stocks.matrix)
rowMeans(stocks.matrix)

#we can bind a new vector to the old matrix! it automatically gives that row a name based on vector name
fb <- c(111,112,113,120,145)
tech.stocks <- rbind(stocks.matrix, fb)
tech.stocks

avg <- rowMeans(tech.stocks)
avg
#adding a column to the matrix is easy as well
tech.stocks <- cbind(tech.stocks, avg)
tech.stocks


##########################
# MATRIX SELECTION AND INDEXING
##########################

#sq bkt notation just like vectors
mat <- matrix(1:50, byrow=T, nrow=5)
mat[1,]
mat[,1]
mat[1:3,]
mat[4:5, 3:6]


##########################
# FACTOR AND CATEGORICAL MATRICES
##########################

#aka creating dummy variablef
