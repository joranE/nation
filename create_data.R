# library(statskier)
# 
# con <- db_xc()
# x <- query(con,"select * from main")
# 
# x$cat2[x$cat2 == ""] <- NA
# 
# out <- subset(x,cat1 %in% c('WC','WSC','OWG','TDS','WJC','U23'))
# 
# write.table(x = out,
#             file = "fis.csv",
#             sep = ",",
#             row.names = FALSE,
#             col.names = TRUE)