setwd('/Users/averyhill/Desktop/PlashCard/')

photo_files <- list.files('Photos')
pfspace <- gsub('_',' ',photo_files)
pf <- gsub('.png','',pfspace)

nameDic <- read.csv('namDic.csv',sep='\t')
common <- c()
for ( i in 1:length(pf)){
  comNam <- as.character(nameDic[nameDic$binom == pf[i],'common'])
  if(length(comNam)>0){
    common <- c(common, comNam)
  } else{
    common <- c(common," ")
  }
  
}
pd.df <- data.frame(Binom=pf,Common=common,FilePath=photo_files)

binomArray <- paste('"',pd.df$Binom,'"',sep='')
binomText <- paste(binomArray,collapse=',')
binomDone <- paste('var binoms = [',binomText,']',sep='')

commonArray <- paste('"',pd.df$Common,'"',sep='')
commonText <- paste(commonArray,collapse=',')
commonDone <- paste('var commons = [',commonText,']',sep='')

FilePathArray <- paste('"Photos/',pd.df$FilePath,'"',sep='')
FilePathText <- paste(FilePathArray,collapse=',')
FilePathDone <- paste('var filePaths = [',FilePathText,']',sep='')

url <- paste('https://en.wikipedia.org/wiki/',gsub('.png','',photo_files),sep='')
urlArray <- paste('"',url,'"',sep='')
urlText <- paste(urlArray,collapse=',')
urlDone <- paste('var urls = [',urlText,']',sep='')

Done <- paste(binomDone,commonDone,FilePathDone,urlDone,sep='\n')
write(Done,file='CopyPastetoFlashcard.txt')
