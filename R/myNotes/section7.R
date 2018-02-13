##########################
# GUIDE TO R STUDIO
##########################

#library(txtplot) 
#txtplot(cars[,1], cars[,2], xlab = "speed", ylab = "distance") 
#a <- 2
#v <- c(1,2,3)
#ls()
#getwd()

#print('First Line')
#print('Second Line')


##########################
# ARITHMETIC WITH R
##########################
1 + 2

100 + 11

1 / 2

2 / 3

2^3

# order of operations is followed
100 * 2 + 50 / 2

#mod with two %'s
5 %% 2


##########################
# VARIABLES
##########################
variable <- 100
variable
bank.account <- 100
bankAccount <- 100

#this one is bad style in R
bank_account <- 100

deposit <- 20
bank.account <- bank.account + deposit
bank.account


##########################
# R DATA TYPES
##########################

#numeric
a <- 2.2

#logical
a <- T

a

#string
a <- 'hello'

class(a)


##########################
# VECTOR BASICS (for the x'teenth time)
##########################

nvec <- c(1,2,3,4,5)
nvec 
class(nvec)

cvec <- c("u", "s", "a")
cvec
class(cvec)

lvec <- c(T, F)
lvec 
class(lvec)

#you can't really mix data types.. R will do things to you
v <- c(T, 20, 40)
v

v <- c('USA', 20, 31)
v
class(v)

temps <- c(72, 71, 68, 73, 69, 75, 76)
temps 

# we can do a kind of dictionary / array type definition
days <- c('mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun')

#and then use names() to apply it to the temps vector
names(temps) <- days
days
temps


##########################
# VECTOR OPERATIONS
##########################
v1 <- c(1,2,3)
v2 <- c(5,6,7)

#operations are done element by element 
v1 - v2
v1 * v2

#we can sum elements in a vector if they're numeric
sum(v1)
sum.of.vec <- sum(v1)
sum.of.vec

#a few more functions that you can use! this is not all of them... google it if you want more
mean(v1)
sd(v1)
max(v1)
prod(v1)
min(v1)


##########################
# VECTOR INDEXING AND SLICING
##########################

v2 = c('a','b','c')

#indexing in R starts at 1, not at 0 and is done with square brackets

v1[1]
v2[2]

#grabbing multiple spots from a vector
v2[c(1,3)]

#we can slice just like in py!
v2[1:3]

temps

#we can also select by names as you would expect
temps['mon']
temps[c('fri','mon')]

#we can select things that meet certain conditions
temps[temps>70]

#or use a filter
my.filter <- temps > 70
temps[my.filter]


##########################
# GETTING HELP IN R
##########################

#you can use help() these are commented to prevent the help buffer from opening
#and needing to be closed

#help('vector')
#??numberic


##########################
# COMPARISON OPERATORS
##########################
5 < 6
5 > 6

2 != 4
2 != 2

v <- 2

#careful with spacing!
v < -1
v <-1 # this will reassign!
v

#with a vector we can return a vector of bools by using comparison operators
v1
v1 < 2

#we can also compare a number to a vector on an element by element basis
v < v1


