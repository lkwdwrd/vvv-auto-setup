#The Data Directory

Place any sql dumps here and they will be imported the next time the project is provisioned. If you have specified an old domain and new domain in the `site-vars.sh` file. Once the data has been imported, wp-cli will perform a `search-replace` operation on your database to update it with the new domain.

After importing, your .sql file will be renamed with a .imported extension. This will prevent it from being re-imported next time you run `vagrant provision`. If you would like to re-import, simply remove the .imported extension. To import a new database set, just drop the .sql file into this folder. Note that the new data will completely replace the old data.