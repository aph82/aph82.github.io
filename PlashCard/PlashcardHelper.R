setwd('/Users/averyhill/Desktop/Scripts/ScriptProjects/PlashCard')

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
binomDone <- paste('var SCbinoms = [',binomText,'];',sep='')

commonArray <- paste('"',pd.df$Common,'"',sep='')
commonText <- paste(commonArray,collapse=',')
commonDone <- paste('var SCcommons = [',commonText,'];',sep='')

FilePathArray <- paste('"Photos/',pd.df$FilePath,'"',sep='')
FilePathText <- paste(FilePathArray,collapse=',')
FilePathDone <- paste('var SCfilePaths = [',FilePathText,'];',sep='')

url <- paste('https://en.wikipedia.org/wiki/',gsub('.png','',photo_files),sep='')
urlArray <- paste('"',url,'"',sep='')
urlText <- paste(urlArray,collapse=',')
urlDone <- paste('var SCurls = [',urlText,'];',sep='')

SCDone <- paste(binomDone,commonDone,FilePathDone,urlDone,sep='\n')
# write(Done,file='CopyPastetoFlashcard.js')


####### THIS MAKES JASPER RIDGE, CONTINGENT ON ABOVE
jr <- read.csv('jasperRidge.csv')[-1]
jr <- as.character(jr$x)
remove('JR.df')
JR.df <- ((apply(pd.df,1,function(row){
  bin <- as.character(row['Binom'])
  if(bin %in% jr){
    return(row)
  }else{
    # row <- NA
  }
  # return(row)
})))
JR.df[sapply(JR.df, is.null)] <- NULL
JR.df <- data.frame(matrix(unlist(JR.df), nrow=length(JR.df), byrow=T),stringsAsFactors=FALSE)

names(JR.df) <- names(pd.df)

binomArray <- paste('"',JR.df$Binom,'"',sep='')
binomText <- paste(binomArray,collapse=',')
binomDone <- paste('var JRbinoms = [',binomText,'];',sep='')

commonArray <- paste('"',JR.df$Common,'"',sep='')
commonText <- paste(commonArray,collapse=',')
commonDone <- paste('var JRcommons = [',commonText,'];',sep='')

FilePathArray <- paste('"Photos/',JR.df$FilePath,'"',sep='')
FilePathText <- paste(FilePathArray,collapse=',')
FilePathDone <- paste('var JRfilePaths = [',FilePathText,'];',sep='')

url <- paste('https://en.wikipedia.org/wiki/',gsub('.png','',photo_files),sep='')
urlArray <- paste('"',url,'"',sep='')
urlText <- paste(urlArray,collapse=',')
urlDone <- paste('var JRurls = [',urlText,'];',sep='')

JRDone <- paste(binomDone,commonDone,FilePathDone,urlDone,sep='\n')

SCJRDone <- paste(SCDone,JRDone,sep='\n')

write(SCJRDone,file='plantSets.js')






#jasper ridge The following code mostly cleans up the jasper ridge csv, but it still required some manual stuff.
# jr <- read.csv('jasperRidge.csv',stringsAsFactors = F)
# 
# head(jr)
# jr <- jr[,2]
# 
# jr <- jr[complete.cases(jr)]
# for ( i in 1:length(jr)){ #still have to filter out all hybrids and family names
#   sp <- jr[i]
#   sp_lit <- unlist(strsplit(sp,split=''))
#   if(length(sp_lit)==0) {
#     jr[i] <- NA
#   } else if(sum(grepl('[A-Z]',sp_lit))> 4){
#     jr[i] <- NA
#   }else{ 
#     sp <- gsub('\\*','',sp)
#     sp <- gsub(' var(.*)',"",sp)
#     sp <- gsub(' ssp(.*)',"",sp)
#     sp <- gsub(' sp(.*)',"",sp)
#     sp <- gsub(' \\((.*)',"",sp)
#     sp <- gsub('^ ',"",sp)
#     jr[i] <- sp
#   }
# 
# }
# 
# jr <- jr[complete.cases(jr)]
# write.csv(jr,'jasperRidge.csv')

