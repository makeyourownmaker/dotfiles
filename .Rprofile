
# Set preferred mirror
# r <- getOption("repos")
# r["CRAN"] <- "http://cran.mirrors.hoobly.com"
# options(repos = r)
# rm(r)
options("repos" = c(CRAN = "http://cran.uk.r-project.org/"))

# Make the screen wide (really necessary??)
# options(width=160)

# Print max 200 lines
options(max.print=200)


# Short for headtail - Show the first and last 10 items of an object
ht <- function(d) rbind(head(d, 10), tail(d, 10))


# Show the first 5 rows and first 5 columns of a data frame or matrix
rc <- function(d) d[1:5, 1:5]


# Sample rows from a dataframe or matrix
randomRows = function(x, size=10, replace=FALSE, prob=NULL){
  if (size > nrow(x)) {
    stop("`size` must be smaller then nrows in `x`.", call. = FALSE)
  }
  x[sample(nrow(x), size, replace, prob),]
}


# Skewness
skew <- function(x){
  ((sum(((x - mean(x))/(sd(x)))^3))/(length(x) - 1))
}


# Kurtosis
kurt <- function(x, k.type=1){
  ifelse(k.type == 2,
         ((sum(((x - mean(x))/(sd(x)))^4))/(length(x) - 1)),      # older definition
         (((sum(((x - mean(x))/(sd(x)))^4))/(length(x) - 1)) - 3) # fourth cumulant aka excess kurtosis
        )
}


# Sigma clipping
sigma.clip <- function(vec, nclip=3, N.max=5) {
  mean <- mean(vec)
  sigma <- sd(vec)
  clip.lo <- mean - (nclip*sigma)
  clip.up <- mean + (nclip*sigma)
  vec <- vec[vec < clip.up & vec > clip.lo]    # Remove outliers
  
  if ( N.max > 0 ) {
    N.max <- N.max - 1
    # Note the use of recursion here (i.e. the function calls itself):
    vec <- Recall(vec, nclip=nclip, N.max=N.max)
  }
  
  return(vec)
}


# Gross outlier removal 
# median or IQR would probably be better
outlierReplace = function(df, col, nclip=4, newValue = NA) {
  col.mean <- mean(df[, get(col)])
  col.sd <- sd(df[, get(col)])
  clip.lo <- col.mean - nclip*col.sd
  clip.hi <- col.mean + nclip*col.sd

  rows <- which( df[, get(col)] < clip.lo | df[, get(col)] > clip.hi )

  if (any(rows)) {
    set(df, rows, col, newValue)
  }
}

# Check for outliers - want row number returned
# TODO finish later - got deadlines now
#outlierCols <- function(x) {
#      out <- lapply(x, function(y) { abs(y-mean(y,na.rm=TRUE)) > 3*sd(y,na.rm=TRUE) }
#      # abs(x-mean(x,na.rm=TRUE)) > 3*sd(x,na.rm=TRUE)
#}



mse <- function(obs, pred) mean((obs-pred)^2)
rmse <- function(obs, pred) sqrt(mean((obs-pred)^2))

# root mean square error
rmse.fit <- function(fit, newdata, outcome_var){
  pred <- predict(fit, newdata=newdata)
  sqrt(mean((newdata[, outcome_var]-pred)^2, na.rm=TRUE))
}

# mean absolute percentage error
mape <- function(fit, newdata, outcome_var){
  pred <- predict(fit, newdata=newdata)
  mean(abs(newdata[, outcome_var]-pred)/mean(newdata[, outcome_var], na.rm=TRUE)*100, na.rm=TRUE)
}

# Get the proportion variation explained. See this website for more details: http://goo.gl/jte8X
rsq <- function(predicted, actual) 1-sum((actual-predicted)^2)/sum((actual-mean(actual))^2)



# Divide the data into training  and test sets
test.train.split <- function(data, seed = NULL, prob = 0.7) {
  if (!is.null(seed)) set.seed = 123
  index <- 1:nrow(data)
  train.index <- sample(index, trunc(length(index))*prob)
  train.set <- data[train.index, ]
  test.set <- data[-train.index, ]
  return(list(train = train.set, test = test.set))
}


hogs <- function() {
  as.data.frame(tail(sort( sapply(ls(),function(x){object.size(get(x))})), n=10))
}

# Improved list of objects
# http://stackoverflow.com/questions/1358003/tricks-to-manage-the-available-memory-in-an-r-session
lsos <- function(..., n=10) {
  .ls.objects(..., order.by="Size", decreasing=TRUE, head=TRUE, n=n)
}
.ls.objects <- function (pos = 1, pattern, order.by,
                         decreasing=FALSE, head=FALSE, n=5) {
  napply <- function(names, fn) sapply(names, function(x)
    fn(get(x, pos = pos)))
  names <- ls(pos = pos, pattern = pattern)
  obj.class <- napply(names, function(x) as.character(class(x))[1])
  obj.mode <- napply(names, mode)
  obj.type <- ifelse(is.na(obj.class), obj.mode, obj.class)
  obj.size <- napply(names, object.size)
  obj.dim <- t(napply(names, function(x)
    as.numeric(dim(x))[1:2]))
  vec <- is.na(obj.dim)[, 1] & (obj.type != "function")
  obj.dim[vec, 1] <- napply(names, length)[vec]
  out <- data.frame(obj.type, obj.size, obj.dim)
  names(out) <- c("Type", "Size", "Rows", "Columns")
  if (!missing(order.by))
    out <- out[order(out[[order.by]], decreasing=decreasing), ]
  if (head)
    out <- head(out, n)
  out
}

# list objects without functions i.e. list data objects only
#ls_data <- function() setdiff(ls(), lsf.str())


# http://alandgraf.blogspot.de/2013/02/copying-data-from-excel-to-r-and-back_24.html
# dat=read.excel()
read.excel <- function(header=TRUE,...) {
  read.table("clipboard",sep="\t",header=header,...)
}

# write.excel(dat)
write.excel <- function(x,row.names=FALSE,col.names=TRUE,...) {
  write.table(x,"clipboard",sep="\t",row.names=row.names,col.names=col.names,...)
}


mean.round <- function(x) {round(mean(x))}


lenuniq <- function(vec, na.rm=TRUE) {
  if(na.rm && !is.null(vec)) vec <- vec[!is.na(vec)]
  length(unique(vec))
}


# Check for columns which contain one or more NA values
naCols <- function(df) {
  colnames(df)[unlist(lapply(df, function(x) any(is.na(x))))]
}

# Check for columns with zero variation
zeroVarCols <- function(x) {
  out <- lapply(x, function(y) length(unique(y)))
  want <- which(!out > 1)
  unlist(want)
}

# Check for columns with near zero variation
nearZeroVarCols <- function(x, n=6) {
  nums <- sapply(x, is.numeric)
  vars <- apply(iwpc[, nums], 2, function(y) var(y, na.rm=T))
  head(sort(vars), n)
}

# Check for columns which contain mostly NAs
mostlyNAcols <- function(x, n=6) {
  tail(sort(apply(iwpc, 2, function(x) sum(is.na(x)))), n)
} 

mostlyNArows <- function(x, n=6) {
  nas <- as.data.frame(apply(iwpc, 1, function(x) sum(is.na(x))))
  names(nas) <- "NAs"
  nas$row <- 1:nrow(nas) # Yes, have to add this to avoid getting NA count list
  tail(nas[order(nas$NAs), ], n)
} 

# Numeric columns with NAs
isGoodCol <- function(col) {
  sum(is.na(col)) == 0 && is.numeric(col) 
}
#goodCols <- sapply(data, isGoodCol)

duplicateCols <- function(x) {
  dupCols <- sapply(1:ncol(x), function(i) which(sapply(x, identical, x[, i])))
  unlist(dupCols[duplicated(dupCols)])
}

# TODO Check for columns with almost perfect correlations
#      Watch out for factor columns
#nearlyDuplicateCols <- function(x) {
#}


# Change factors to strings
unfactorize <- function(df){
  for(i in which(sapply(df, class) == "factor")) df[[i]] = as.character(df[[i]])
  return(df)
}


# Change factors to numeric
as.numeric.factor <- function (x) as.numeric(as.character.factor(x))


# Set R prompt and window title
#windowTitle<-"foobar"
#setPromptWindowTitle(windowTitle)
setPromptWindowTitle <- function(windowTitle) {
  utils::setWindowTitle(windowTitle)
  myPrompt<-paste(windowTitle, '> ', sep='')
  options(prompt=myPrompt)
}


# Inspired by keep function from gdata package
keep <- function(x, sure=FALSE) {
  lsSize  <- length(ls(envir = .GlobalEnv))
  setDiff <- setdiff(ls(envir = .GlobalEnv), deparse(substitute(x)))

  if ( sure == "TRUE" & lsSize > length(setDiff) ) {
    rm(list = setDiff, envir = .GlobalEnv)
  } else if ( lsSize == length(setDiff) ) {
    cat("Nothing to keep!")
  } else {
    cat("Add sure=TRUE to delete: ")
    setDiff
  }
}


plot4 <- function(fit) {
  par(mfrow=c(2,2))
  plot(fit)
}


# Box plot with rug plot
boxAndRugPlots <- function(x) { boxplot(x); rug(x, side=4) }


# Draw a histogram with density overlay
histdensity <- function(x, main=NULL, breaks="FD", ...) {
  if (any(is.na(x))) warning(paste(sum(is.na(x)), "missing values")); x <- na.omit(x) 
  hist(x, col="gray50", probability=TRUE,  breaks=breaks, main=main, ...)
  lines(density(x, na.rm = TRUE), col = "blue", lwd=2)
  rug(x)
}


# Plot scatterplot with trendline and confidence interval (From http://tinyurl.com/3bvrth7)
scatterci <- function(x, y, ...) {
  plot(x, y, ...)
  mylm <- lm(y~x)
  abline(mylm, col="blue")
  x=sort(x)
  prd<-predict(mylm,newdata=data.frame(x=x),interval = c("confidence"), level = 0.95)
  lines(xrd[,2],col="blue",lty=3)
  lines(xrd[,3],col="blue",lty=3)
}


# Prints the currently displayed graph to the
# file 'filename'; suffix within 'filename'
# can be "pdf", "png" or "jpg"
pr2file <- function(filename) {
  origdev <- dev.cur()
  parts   <- strsplit(filename, ".", fixed=TRUE)
  nparts  <- length(parts[[1]])
  suff    <- parts[[1]][nparts]

  if (suff == "pdf") {
    pdf(filename)
  }
  else if (suff == "png") {
    png(filename)
  }
  else jpeg(filename)

  devnum <- dev.cur()
  dev.set(origdev)
  dev.copy(which=devnum)
  dev.set(devnum)
  dev.off()
  dev.set(origdev)
} 


# From here: http://multithreaded.stitchfix.com/blog/2017/06/15/beware-r-in-production/
#.enable_traceback <- function() {
#  options(error = function() { 
#    traceback(2) 
#    if (!interactive()) quit("no", status = 1, runLast = FALSE) 
#  })
#}


#q <- function (save="no", ...) {
#  quit(save=save, ...)
#}


