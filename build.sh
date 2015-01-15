set -e
db=$1
u=$2
p=$3
d=$4
r=$5

$(mysql -h$db -u$u -p$3 $d -e "create table if not exists version(id int auto_increment not null, script varchar(50), date timestamp default current_timestamp, primary key (id));")

	
if [ "$r" == "-r" ]
then
	echo "rebuild"
	$(mysql -h$db -u$u -p$p $d -se "truncate table version;")
fi


for dir in */
do
	for f in $dir/*.sql
	do 
		go=$(mysql -h$db -u$u -p$p $d -se "select 1 from version where script=\"$f\"")
		#echo "$go"
	
		
		
		if [ "$go" != "1" ] 
		then
		#echo $db $u $p $f
			echo $(mysql -h$db -u$u -p$3 $d < $f -v)
			$(mysql -h$db -u$u -p$p $d -se "insert into version(script) values(\"$f\");")
		else
			echo "skipping $f"
		fi
	done
done