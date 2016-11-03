user <- read.delim("u.user",sep = "|",stringsAsFactors=FALSE,na.strings="")
#names(user) <- c("")   可以修改列名
#head(user[which(user$zipCode == NA),5])
#head(user[which(nchar(user$zipCode) != 4),5])  查看一下数据是否合适
#也可以使用 summary decribe and str...查看

uData <- read.delim("u.data",sep = "\t",header = FALSE, stringsAsFactors=FALSE,na.strings="")
names(uData) <- c("userId","itemId","rating","timestamp")
uData <- uData[,1:3]
#uItem <- read.delim("u.item",sep = "|",stringsAsFactors=FALSE,na.strings="")
#uData$date <- as.Date(uData$, tz = "UTC")
#uData$date <- as.Date(uData$timestamp, tz = "UTC",origin="1970-01-01")
#uData$date <- as.POSIXct(as.numeric(as.character(uData$timestamp)),origin="1970-01-01",tz="GMT")

user.package.matrix <- cast(uData, userId ~ itemId, value = 'rating', fill =0)
row.names(user.package.matrix) <- user.package.matrix[,1]
user.package.matrix <- user.package.matrix[,-1]
similarities <- cor(user.package.matrix)
#把相似度 1 转化为距离0 把相似度-1转化为距离无穷大
distances <- -log((similarities / 2) + 0.5)

k.nearest.neighbors <- function(i , distances, k = 25){
    return(order(distances[i,])[2:(k+1)])
}


installation.probability <- function(user,package,user.package.matrix,distances,k=25)
{
    neighbors <- k.nearest.neighbors(package,distances, k=k)
    return (mean(sapply(neighbors,function(neighbor){user.package.matrix[user,neighbor]})))
}

most.probable.packages <- function(user, user.package.matrix, distances, k = 25)
{
    return(order(sapply(1:ncol(user.package.matrix),
    function (package)
{
    installation.probability(user,
    package,
    user.package.matrix,
    distances,
    k = k)
}),
    decreasing = TRUE))
}

user <- 1   #设置用户
listing <- most.probable.packages(user, user.package.matrix, distances)
colnames(user.package.matrix)[listing[1:10]]








