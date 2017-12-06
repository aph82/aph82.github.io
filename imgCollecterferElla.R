ell <- list.files("~/Desktop/Scripts/ScriptProjects/WelkinDim/Elluv/")

demand<-c()
for (i in 1:length(ell)){
  print(ell[i])
  d <- paste('<img class="mySlides w3-animate-fading" src="Elluv/',ell[i],'">',sep='')
  demand<-c(demand,d)
}
demand
write(demand,file="~/Desktop/demand")
