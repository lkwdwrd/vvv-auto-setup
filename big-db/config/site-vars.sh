# Modify the variables below to match your project.

# This specifies the main site name in provisioning.
site_name='Example Site'

# This sets up the name of the DB and the user and password for the DB.
database='example_db'
dbuser='example_user'
dbpass='example_pass'

# After importing, any old domain in the DB will be updated with the new domain.
# Note that in this version of the script, a direct replace is done from the
# old domain to the new domain. Doing a direct replacement of the domains allows
# this script to execute much faster which makes it ideal of large databases.
# However, the downfall is you need to make sure the old_domain and new_domain
# contain exactly the same number of characters or it will cause corruption and
# data loss in serialized data.
old_domain='example.com'
new_domain='example.dev'