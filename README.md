# mysql-dumper-loader
Wrapper around mydumper/myloader to optimize data loads

## Process Overview
1. Run mydumper without any changes (not part of this projects, happens independently elsewhere)
2. Move data files out of the exported directory
3. Run myloader so database tables are created without data
4. Gather Indexes created and generate the create index statements
5. Drop all the non primary key indexes
6. Move schema files out of exported directory and move data files back in
7. Run myloader to load data
8. Run create index statements generated from #4
9. Move schema files back in for archival purpose

## Execution
Required parameters:
Path to config file with database credentials
`-d` Data directory path
`-s` Name of the database to run on

Optional parameters:
`-t` Number of threads to use
`-v` Verbosity level 

Run Command
`./index_optimized_loader {Path to config file with database credentials}  -d {Path to database schema and data files} -s {Name of the database} -v {Verbosity level: 1,2,3} -t {Number of threads to use}` 

