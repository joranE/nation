library(statskier)
library(dplyr)
con <- db_xc()
x <- statskier::query(con,"select * from main")

x$cat2[x$cat2 == ""] <- NA

out <- filter(x,cat1 %in% c('WC','WSC','OWG','TDS','WJC','U23'))
# 
# write.table(x = out,
#             file = "fis.csv",
#             sep = ",",
#             row.names = FALSE,
#             col.names = TRUE)

fis_db <- src_sqlite("fis.sqlite3",create = TRUE)
fis_main <- copy_to(fis_db,
                    out,
                    name = "main",
                    temporary = FALSE,
                    indexes = list("raceid","fisid","cat1","type"))