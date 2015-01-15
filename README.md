#SHantDB

Bash command line build and versioning script for MySQL

##USAGE:
./build.sh [database host] [username] [password] [database name] [-r rebuild OPT]

##Confiugration
* create incremental version folders as you make DB changes
* folders and scripts are executed asciibetically
* all SQL scripts should be idempotent - with the first script utilizing a DROP if exists
* script builds by default
	* runs only new scripts that haven't been run on the DB
* add a -r to rebuild the db
	* clears version history, re-runs all scripts
	* key to have first scripts of a table/object to be idempotent

