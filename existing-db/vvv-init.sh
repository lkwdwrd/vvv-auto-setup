# Init script for VVV Auto Site Setup
source config/site-vars.sh
echo "Commencing $site_name Site Setup"

# Make a database, if we don't already have one
echo "Creating $site_name database (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS $database"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON $database.* TO $dbuser@localhost IDENTIFIED BY '$dbpass';"

# Deal with our database dumps.
first_sql=$(ls src/data | grep -i -E '\.sql$' | head -1)
if [ -f src/data/$first_sql ]
	then
	echo "Importing first found database for $site_name (this can take a while)"
	mysql -u root --password=root $database < src/data/$first_sql
	mv src/data/$first_sql src/data/$first_sql.imported
	if [ -d htdocs ]
		then
		cd htdocs
		wp search-replace "$old_domain" "$new_domain" --skip-columns=guid
		cd ../
		else
		sql_imported="yes"
	fi
fi

# Install WordPress if it's not already present.
if [ ! -d htdocs ]
	then
	echo "Installing WordPress using WP-CLI"
	mkdir htdocs
	# Move into htdocs to run 'wp' commands.
	cd htdocs
	wp core download 
	wp core config --dbname="$database" --dbuser=$dbuser --dbpass=$dbpass --extra-php < ../config/wp-constants

	#Install all WordPress.org plugins in the org_plugins file using CLI
	echo "Installing WordPress.org Plugins"
	if [ -f ../config/org-plugins ]
	then
		while IFS='' read -r line || [ -n "$line" ]
		do
			if [ "#" != ${line:0:1} ]
			then
				wp plugin install $line
			fi
		done < ../config/org-plugins
	fi
	#Update Network Sites
	echo "Updating Network"
	for url in $(wp site list --fields=url --format=csv | tail -n +2)
	do
	  wp --url=$url core update-db
	done
	# Update Database as Needed
	if [[ 'yes' -eq $sql_imported ]]
		then
		wp search-replace "$old_domain" "$new_domain" --skip-columns=guid
	fi
	# Move back to root to finish up shell commands.
	cd ..
fi
# Symlink working directories
# First clear out any links already present
find htdocs/wp-content/ -maxdepth 2 -type l -exec rm -f {} \;
# Next attach symlinks for eacy of our types.
# Plugins
echo "Linking working directory pluins"
find src/plugins/ -maxdepth 1 -mindepth 1 -exec ln -s $PWD/{} $PWD/htdocs/wp-content/plugins/ \;
# Themes
echo "Linking working directory themes"
find src/themes/ -maxdepth 1 -mindepth 1 -exec ln -s $PWD/{} $PWD/htdocs/wp-content/themes/ \;
# Dropins
echo "Linking any available drop-ins"
find src/dropins/ -maxdepth 1 -mindepth 1 -exec ln -s $PWD/{} $PWD/htdocs/wp-content/ \;

# The Vagrant site setup script will restart Nginx for us
echo "$site_name is now set up!";