# Init script for VVV Auto Site Setup
source config/site-vars.sh
echo "Commencing $site_name Site Setup"

# Make a database, if we don't already have one
echo "Creating $site_name database (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS $database"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON $database.* TO $dbuser@localhost IDENTIFIED BY '$dbpass';"

# Install WordPress if it's not already present.
if [ ! -d htdocs ]
	then
	echo "Installing WordPress using WP-CLI"
	mkdir htdocs
	# Move into htdocs to run 'wp' commands.
	cd htdocs
	wp core download
	wp core config --dbname="$database" --dbuser="$dbuser" --dbpass="$dbpass" --extra-php < ../config/wp-constants
	if [ ! $(wp core is-installed) ]
		then
		wp core install --url="$domain" --title="$site_name" --admin_user="$admin_user" --admin_password="$admin_pass" --admin_email="$admin_email"
	fi
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