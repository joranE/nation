# library(readr)
# DATA <- read_csv("fis.csv",
# 								col_names = TRUE,
# 								col_types = "iiccccdccccccciiciidd")
#FIS <- src_sqlite("fis.sqlite3",create = FALSE)
FIS <- src_mysql(options()$mysql$dbName,
                 options()$mysql$host,
                 options()$mysql$port,
                 options()$mysql$user,
                 options()$mysql$password)
DATA <- tbl(FIS,"main")