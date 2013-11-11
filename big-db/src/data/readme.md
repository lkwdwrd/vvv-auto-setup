#The Data Directory

Place any sql dumps here and they will be imported the next time the project is provisioned. If you have specified an old domain and new domain in the `site-vars.sh` file, then prior to importing a find and replace will be performed on your database. Note that the old and new domains should be exactly the same number of characters to ensure there are not issues with serialized data.

After importing, your .sql file will be renamed with a .imported extension. This will prevent it from being re-imported next time you run `vagrant provision`. If you would like to re-import, simply remove the .imported extension. To import a new database set, just drop the .sql file into this folder. Note that the new data will completely replace the old data.