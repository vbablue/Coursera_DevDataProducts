#Loading libraries
library(XML)
library(lubridate)
library(dplyr)

#Reading the url, getting the tabel and converting it to a data frame
url <- "http://www.boxofficemojo.com/oscar/"
table=readHTMLTable(url)
movies <- table[4]
movies <- as.data.frame(movies)

#Changing the column names to something readable
colnames(movies) <- c("Year", "Picture", "Studio", "Box_Office", "Nominations", "Wins", "Release_Date")

#New Dataset with the month column 
movies_new <- movies %>% mutate(Full_Date = mdy(paste(Release_Date,"/",Year, sep="")), month=month(Full_Date,label=TRUE ))
plot(movies_new$month)

write.csv(movies_new, "c:/movies_new.csv")

#Dates available from 1982

final = data.frame()

for(year in 1982:2014){
#Form the Url
url_base <- "http://www.boxofficemojo.com/oscar/chart/?yr="
url_tail <- "&p=.htm"
url <- paste0(url_base,year,url_tail)

table2=readHTMLTable(url)
tmp <- table2[2]
tmp  <-  as.data.frame(tmp)
colnames(tmp) <- c("Rank", "Movie", "Studio", "Gross", "Theaters", "PostNom_Gross", "PostNom_Theaters","PostAwd_Gross", "PostAwd_Theaters", "Total_Gross","Release_Date" )
if(year <=2008)
{
  tmp <- tmp[2:(dim(tmp)[1]-2),]
} else {
  if(year >=2009){
    tmp <- tmp[3:(dim(tmp)[1]-2),]
  }
}

tmp <- mutate(tmp, date=mdy(paste0(Release_Date,"/",year)), release_month=month(date,label=TRUE))
final = rbind(final,tmp)
year <- year+1
}

names(final)
plot(final$release_month)