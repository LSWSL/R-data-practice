## At first, we initialize two global variable, they cache the matrix that input
## before, and its inverse.
cachematrix<<-NULL
cacheinverse<<-NULL

##The function be used to make the cache list as the input of the second function
makeCacheMatrix <- function(x = matrix()) {
  get<-x
  maintain<-cachematrix
  maintaininverse<-cacheinverse
  
  list(get=get,maintain=maintain,
        maintaininverse=maintaininverse)
}


## The function test if the input equal to the matrix that input before, and if 
## not caculate the inverse.

cacheSolve <- function(x, ...) {
  m<-x$maintaininverse
  if(!is.null(m)){
    if(all(x$maintain==x$get)){
      message("getting cached data")
      return(m)
      }
  }
  ma<-x$get
  cacheinverse<<-solve(ma)
  cachematrix<<-ma
  cacheinverse      
}
