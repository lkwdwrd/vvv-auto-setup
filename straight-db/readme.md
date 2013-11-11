#VVV Auto Site Setup for straight DBs

This version of the auto site setup script is intended to help with project that have existing databases which require no modification before being used for development. Take this folder and turn it into a git project. Add any themes or plugins you are working on to the themes and plugins folders as git submodules. Modify all of the config files to match your project and update the vvv-nginx.conf file with your dev domain.

If there are any special project instructions, I'd suggest replacing the contents of this file with those. This could include directions on how to go about getting a database dump for this project, etc.

Once you have everything set up, commit this project to version control and other team members can pull it into their copy of VVV and they will have a setup that mirrors your own.