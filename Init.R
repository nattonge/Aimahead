system("sudo su -c 'curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/mssql-release.repo && exit'")
system("sudo yum remove unixODBC-utf16 unixODBC-utf16-devel")
system("sudo ACCEPT_EULA=Y yum install -y msodbcsql17")
system("sudo ACCEPT_EULA=Y yum install -y mssql-tools")
system("echo 'export PATH='$PATH:/opt/mssql-tools/bin'' >> ~/.bashrc")
system("source ~/.bashrc")
system("sudo yum install -y unixODBC-devel")

# run this in terminal is odbc can't install
# mkdir ~/R-packages
# export TMPDIR=~/R-packages

# then change the default library path to the new directory
# .libPaths("~/R-packages")

install.packages("odbc")
library(odbc)
install.packages("DBI")
install.packages("rstudioapi")
library(DBI)
library(rstudioapi)

file_path <- '~/db-credentials.txt'

db_creds_df <- read.table(file_path)
db_creds <- db_creds_df

db_creds <- trimws(db_creds)
#db_creds

db <- 'S35' ### ENTER YOUR DB VIEW HERE, for example 'S35'


connection_string = paste0("DRIVER={ODBC Driver 17 for SQL Server};",
                           "SERVER=", db_creds['host'], ',', db_creds['port'], ';',
                           "DATABASE=", db, ';',
                           "UID=", db_creds['username'], ';',
                           "PWD={", db_creds['password'], "};")

#connection_string

db_conn <- DBI::dbConnect(odbc::odbc(), .connection_string = connection_string)

system(command = 'conda install -c conda-forge r-devtools --yes') 
