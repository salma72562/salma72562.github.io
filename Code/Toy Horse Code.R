rm(list = ls())
library(ggplot2)
library(gtools)
require("cluster")
require("fpc")
require("factoextra")
require("gridExtra")
library(cluster)
library(fpc)
library(factoextra)
library(gridExtra)



###### functions needed later on in the code
##Evaluate number of clusters to use on data with visualizations
##Arguments: 
##  toClust, the data to do kmeans cluster analysis
##  maxClusts=15, the max number of clusters to consider
##  seed, the random number to initialize the clusters
##  iter.max, the max iterations for clustering algorithms to use
##  nstart, the number of starting points to consider
##Results:
##  a list of weighted sum of squares and the pamk output including optimal number of clusters (nc)
##  to create visualizations need to print tmp
clustTest = function(toClust,print=TRUE,scale=TRUE,maxClusts=15,seed=12345,nstart=20,iter.max=100){
  if(scale){ toClust = scale(toClust);}
  set.seed(seed);   # set random number seed before doing cluster analysis
  wss <- (nrow(toClust)-1)*sum(apply(toClust,2,var))
  for (i in 2:maxClusts) wss[i] <- sum(kmeans(toClust,centers=i,nstart=nstart,iter.max=iter.max)$withinss)
  ##gpw essentially does the following plot using wss above. 
  #plot(1:maxClusts, wss, type="b", xlab="Number of Clusters",ylab="Within groups sum of squares")
  gpw = fviz_nbclust(toClust,kmeans,method="wss",iter.max=iter.max,nstart=nstart,k.max=maxClusts) #alternative way to get wss elbow chart.
  pm1 = pamk(toClust,scaling=TRUE)
  ## pm1$nc indicates the optimal number of clusters based on 
  ## lowest average silhoutte score (a measure of quality of clustering)
  #alternative way that presents it visually as well.
  gps = fviz_nbclust(toClust,kmeans,method="silhouette",iter.max=iter.max,nstart=nstart,k.max=maxClusts) 
  if(print){
    grid.arrange(gpw,gps, nrow = 1)
  }
  list(wss=wss,pm1=pm1$nc,gpw=gpw,gps=gps)
}

##Runs a set of clusters as kmeans
##Arguments:
##  toClust, data.frame with data to cluster
##  nClusts, vector of number of clusters, each run as separate kmeans 
##  ... some additional arguments to be passed to clusters
##Return:
##  list of 
##    kms, kmeans cluster output with length of nClusts
##    ps, list of plots of the clusters against first 2 principle components
runClusts = function(toClust,nClusts,print=TRUE,maxClusts=15,seed=12345,nstart=20,iter.max=100){
  if(length(nClusts)>4){
    warning("Using only first 4 elements of nClusts.")
  }
  kms=list(); ps=list();
  for(i in 1:length(nClusts)){
    kms[[i]] = kmeans(toClust,nClusts[i],iter.max = iter.max, nstart=nstart)
    ps[[i]] = fviz_cluster(kms[[i]], geom = "point", data = toClust) + ggtitle(paste("k =",nClusts[i]))
    
  }
  library(gridExtra)
  if(print){
    tmp = marrangeGrob(ps, nrow = 2,ncol=2)
    print(tmp)
  }
  list(kms=kms,ps=ps)
}

##Plots a kmeans cluster as three plot report
##  pie chart with membership percentages
##  ellipse plot that indicates cluster definitions against principle components
##  barplot of the cluster means
plotClust = function(km,toClust,discPlot=FALSE){
  nc = length(km$size)
  if(discPlot){par(mfrow=c(2,2))}
  else {par(mfrow=c(3,1))}
  percsize = paste(1:nc," = ",format(km$size/sum(km$size)*100,digits=2),"%",sep="")
  pie(km$size,labels=percsize,col=1:nc)
  
  clusplot(toClust, km$cluster, color=TRUE, shade=TRUE,
           labels=2, lines=0,col.clus=1:nc); #plot clusters against principal components
  
  if(discPlot){
    plotcluster(toClust, km$cluster,col=km$cluster); #plot against discriminant functions ()
  }
  rng = range(km$centers)
  dist = rng[2]-rng[1]
  locs = km$centers+.05*dist*ifelse(km$centers>0,1,-1)
  bm = barplot(km$centers,beside=TRUE,col=1:nc,main="Cluster Means",ylim=rng+dist*c(-.1,.1))
  text(bm,locs,formatC(km$centers,format="f",digits=1))
}

#############################################################################
load("GBA424 - Toy Horse Case Data.RData")


##### PART A #####

## Produce part-utilities to pass to part B
partUtil = data.frame(ID = seq(1,200), intercept = seq(1,200), price = seq(1,200), size = seq(1,200),
                      motion = seq(1,200), style = seq(1,200))

for (i in 1:200){
  reg <- summary(lm(ratings~., data = conjointData[!is.na(conjointData$ratings) & conjointData$ID == i, 3:7]))
  partUtil[i, ] <- c(i, reg$coefficients)
}


## Produce predictions for missing profiles to pass to part D 
fullConjoint <- conjointData

for (i in 1:200){
  for (j in 1:16){
    if (is.na(fullConjoint$ratings[fullConjoint$profile==j & fullConjoint$ID==i])){
      reg <- lm(ratings~., data = conjointData[!is.na(conjointData$ratings) & conjointData$ID == i, 3:7])
      fullConjoint$ratings[fullConjoint$profile==j & fullConjoint$ID==i] <- predict(reg, fullConjoint[fullConjoint$profile==j & fullConjoint$ID==i, ])
    }
  }
}

##### PART B #####

clustTest(partUtil[2:6]) ## optimal number of clusters = 3
runClusts(partUtil[2:6], 2) ## combines two different segments into one cluster
runClusts(partUtil[2:6], 3)
runClusts(partUtil[2:6], 4) ## clusters 1 and 2 are overlapping

clust <- runClusts(partUtil[2:6], 3)
for(i in 1:4) plotClust(clust[[1]][[i]],partUtil[2:6])

## Clustering the crowd into 3 groups provides the best segmentation based on part-utilities
cluster <- kmeans(partUtil[2:6],3,iter.max = 100, nstart=20)
partUtil$cluster <- cluster$cluster

partUtil <- merge(partUtil, respondentData, by = "ID")

## Results:
## 40% market share: 26 inch size, bouncing, racing at 119.9 (most price sensitive) - 3
## 26% market share: 18 inch size, rocking, indifferent between styles for 119.9 - 1 (2 year olds)
## 34% market share: 26 inch size, rocking & glamour for 139.9 (least price sensitive) - 2 (females)

cluster$centers
max(fullConjoint$ratings)

table(partUtil$cluster, partUtil$age)
table(partUtil$cluster, partUtil$gender)
table(partUtil$age, partUtil$gender)

##### PART C #####

segmentData <- merge(conjointData, respondentData, by = "ID")
segmentData <- segmentData[!is.na(segmentData$ratings), ]

segUtil <- data.frame(segment = c("age", "age", "gender", "gender"), value = c("2yr" , "3-4 yr", "male", "female"), intercept = seq(1,4), price = seq(1,4),
                      size = seq(1,4), motion = seq(1,4), style = seq(1,4))

summary(lm(ratings~(price + size+ motion + style) * (age + gender), data = segmentData))
## no significant difference between different age groups in price and style.

#gender
reg_gender=lm(ratings~factor(price)+factor(size)+factor(motion)+factor(style)+factor(gender)+factor(age)+factor(price)*factor(gender)+factor(size)*factor(gender)+factor(motion)*factor(gender)+factor(style)*factor(gender),data = segmentData)
summary(reg_gender)

#age
reg_age=lm(ratings~factor(price)+factor(size)+factor(motion)+factor(style)+factor(gender)+factor(age)+factor(gender)+factor(age)+factor(price)*factor(age)+factor(size)*factor(age)++factor(motion)*factor(age)+factor(style)*factor(age),data = segmentData)
summary(reg_age)

reg_male=summary(lm(ratings~factor(price)+factor(size)+factor(motion)+factor(style),data = segmentData[segmentData$gender==0, ]))
segUtil[3, 3:7] <- reg_male$coefficient
reg_female=summary(lm(ratings~factor(price)+factor(size)+factor(motion)+factor(style),data = segmentData[segmentData$gender==1, ]))
segUtil[4, 3:7] <- reg_female$coefficient
## parents who have daughters are willing to pay higher price for the horse.

reg_2age=summary(lm(ratings~factor(price)+factor(size)+factor(motion)+factor(style),data = segmentData[segmentData$age==0, ]))
segUtil[1, 3:7] <- reg_2age$coefficient
reg_3age=summary(lm(ratings~factor(price)+factor(size)+factor(motion)+factor(style),data = segmentData[segmentData$age==1, ]))
segUtil[2, 3:7] <- reg_3age$coefficient

lm(ratings~factor(price)+factor(size)+factor(motion)+factor(style), data = segmentData)

## Ideal Products for A  priori Segments:
## Females: 26 inch, rocking motion in glamorous style for 139.9
## Males: 18 inch, bouncing motion in racing style for 119.9
## 2 year olds: 18 inch, rocking motion. price and style are insignificant attributes.
## 3 - 4 year olds: 26 inch, bouncing motion. price and style are insignificant attributes.
