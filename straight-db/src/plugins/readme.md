#The Plugins Folder

This folder allows you to add any plugins that you are working on or are not available via the WordPress.org repository to the project. Add any plugin folder or file to this folder and it will be linked into the `wp-content/plugins` folder the next time your project is provisioned.

I've found a good way to work is to add a plugin project to your setup using a git submodule. By pulling your plugin into this folder as a git submodule, you can continue keeping your plugin under it's own version control while ensuring new members of the project can get everything they need to get started by grabbing a copy of your setup project and adding it to their VVV install.