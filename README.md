# setting_server
Script to set up servers

# Setup Julia and Jupyter on a server

Folder: setting_jupyter

On the root account, run script setup_jupyter_user.sh, it will:

- Create user jupyter (you will need to type in password for this new user with prompt in terminal)

- Copy settings for Jupyter to folder ~/.jupyter of user jupyter (note that we assume Python3 and Jupyter are already installed in the server)

- Download Julia, unpack to the folder ~/julia-1.8.3 of user jupyter

- Add path to julia binary to the file ~/.bashrc of user jupyter

- Run julia to install additional packages for solving optimization problems

- Copy setting for the website jupyter.toiuu.net to /etc/nginx/sites-available/ and also make the symbolic link to the sites-enabled folder (note that nginx is assumed to be installed already)

- Copy file run_jupyter_in_background.sh to home folder of user jupyter, so that user just needs to execute that script to run Jupyter. Then the notebook is accessible via website jupyter.toiuu.net (if you use another domain name, please edit the file jupyter.toiuu.net before setting up)

