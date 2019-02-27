ell <- list.files("~/Desktop/Scripts/ScriptProjects/WelkinDim/Elluv/")

photoArray <- paste('"Elluv/',ell,'"',sep='')
photoText <- paste(photoArray,collapse=',')
photoDone <- paste('var photos = [',photoText,'];',sep='')

write(photoDone,file="~/Desktop/demand.txt")
