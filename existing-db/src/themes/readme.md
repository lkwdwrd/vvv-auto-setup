#The Plugins Folder

This folder allows you to add any themes that you are working on to the project. Add any theme folder to this folder and it will be linked into the `wp-content/themes` folder the next time your project is provisioned.

I've found a good way to work is to add a theme project to your setup using a git submodule. By pulling your theme into this folder as a git submodule, you can continue keeping your theme under it's own version control while ensuring new members of the project can get everything they need to get started by grabbing a copy of your setup project and adding it to their VVV install.