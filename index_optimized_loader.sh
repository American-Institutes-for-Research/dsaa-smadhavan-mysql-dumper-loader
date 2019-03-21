#! /bin/bash
set -e
conf_file="$1"

complete_arguments="$@"
getopts d: DIRNAME
data_dir="${OPTARG%/}"

getopts s: dbname
dbname="${OPTARG%/}"

temp_dir="${data_dir}_temp"
mkdir -p "$temp_dir"

echo $dbname
echo "Moving step 1"
mv "${data_dir}/"*.sql "${temp_dir}/"
echo "$?"

echo "Moving step 2"
mv "${temp_dir}/"*schema*.sql "${data_dir}/"
echo "$?"

echo "Load DB Struct"
echo "$complete_arguments"
myloader --defaults-file="$conf_file" $complete_arguments
echo "$?"

echo "Export index creation"
mysql --defaults-file="$conf_file"  -NBe "set @db='${dbname}'; source index_generator.sql;" >"${temp_dir}/add_index.sql"
echo "$?"

echo "Export index drop"
mysql --defaults-file="$conf_file"  -NBe "use ${dbname}; source drop_generator.sql;" >"${temp_dir}/drop_index.sql"
echo "$?"

echo "Run Drop"
mysql --defaults-file="$conf_file"  -NBe "use ${dbname}; source ${temp_dir}/drop_index.sql"
echo "$?"

echo "Moving step 3"
mv "${temp_dir}/"*.sql "${data_dir}/"
echo "$?"

echo "Moving step 4"
mv "${data_dir}/"*schema*.sql "${temp_dir}/"
echo "$?"

echo "Load Data"
myloader --defaults-file="$conf_file"  $complete_arguments
echo "$?"

echo "Moving step 5"
mv "${temp_dir}/"*.sql "${data_dir}/"
echo "$?"

echo "Load Index"
mysql --defaults-file="mysql.conf"  -NBe "use ${dbname}; source ${temp_dir}/add_index.sql;"
echo "$?"


