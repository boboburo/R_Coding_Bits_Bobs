#User defined function to count the number of unique entries in a column and subtract 1
#if any blanks encountered.

columnVariance <- function(columnArg){
	return(length(unique(columnArg))-any(is.na(columnArg)))
}


#Create a data.frame or data.table

library(data.table)
df <- data.table(a=sample(1:5, 1000, replace=T), 
								 b=sample(1:5, 1000, replace=T), 
								 c=sample(1:5, 1000, replace=T), 
								 d=sample(1:5, 1000, replace=T), 
								 grp=sample(1:3, 1000, replace=T))


library(dplyr)

#this summarises one variable only
df %>% group_by(grp) %>% summarise(mean(a))

#this is on them all
system.time(df %>% group_by(grp) %>% summarise_each(funs(mean)))

#Using dplyr idiom applies the user defined function to them all
system.time(summary1<-df %>% group_by(grp) %>% summarise_each(funs(columnVariance)))
object.size(summary1)
#1928 bytes
class(summary1)
#[1] "tbl_dt"     "tbl"        "data.table" "data.frame"

system.time(summary2<-df[, lapply(.SD, columnVariance), by = grp])
object.size(summary2)
#1816 bytes
class(summary2)
#[1] "data.table" "data.frame"

A<-c(NA,NA,"C","C","D","E")
B<-c(NA,NA,NA,NA,NA)

length(unique(A))-all(is.na(A))/length(unique(A))
length(unique(B))
10-all(is.na(B))
