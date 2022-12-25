echo "This script creates a new user and install Jupyter and Julia together with some packages, so that Jupyter could be ran on the server under the new user and accessible from a client via web browser."

echo "Please note the prerequisite for this server: nginx, Python3, and Jupyter should already be installed by the root user."

echo "This script needs to be run with administrator right."

echo "Enter new username:"

read NEWUSER

echo "New username is $NEWUSER"

echo

echo "Enter domain name to be used for the Jupyter service:"

read DOMAINNAME

echo "Enter port number for Jupyter notebook of the new user (port should be free in this server, e.g. no Jupyter notebook used it):"

read PORTNUMBER

adduser $NEWUSER

cp jupyter.toiuu.net /etc/nginx/sites-available/$DOMAINNAME

sed -i "s/jupyter.toiuu.net/$DOMAINNAME/g" /etc/nginx/sites-available/$DOMAINNAME

sed -i "s/8888/$PORTNUMBER/g" /etc/nginx/sites-available/$DOMAINNAME

rm /etc/nginx/sites-enabled/$DOMAINNAME

ln -s /etc/nginx/sites-available/$DOMAINNAME /etc/nginx/sites-enabled/

nginx -t

systemctl restart nginx

cp -r .jupyter /home/$NEWUSER/

sed -i "s/8888/$PORTNUMBER/g" /home/$NEWUSER/.jupyter/jupyter_notebook_config.py

chown -R $NEWUSER:$NEWUSER /home/$NEWUSER/.jupyter/

cp install_julia.sh /home/$NEWUSER/

chown $NEWUSER:$NEWUSER /home/$NEWUSER/install_julia.sh

chmod +x /home/$NEWUSER/install_julia.sh

cp setup_julia.ij /home/$NEWUSER/

chown $NEWUSER:$NEWUSER /home/$NEWUSER/setup_julia.ij

cp run_jupyter_in_background.sh /home/$NEWUSER/

chown $NEWUSER:$NEWUSER /home/$NEWUSER/run_jupyter_in_background.sh

chmod +x /home/$NEWUSER/run_jupyter_in_background.sh

runuser -l $NEWUSER -c "mkdir ~/webdata"

cp test_julia.ipynb /home/$NEWUSER/webdata

chown $NEWUSER:$NEWUSER /home/$NEWUSER/webdata/test_julia.ipynb

runuser -l $NEWUSER -c "/home/$NEWUSER/install_julia.sh"

runuser -l $NEWUSER -c "/home/$NEWUSER/julia-1.8.3/bin/julia setup_julia.ij"

echo "Setup finished, remember to point your chosen domain name $DOMAINNAME to this server. Login the server via SSH as user $NEWUSER, type run_jupyter_in_background to start the jupyter notebook, it is accessible at $DOMAINNAME with password 'PyOpt1', its data is stored in /home/$NEWUSER/webdata"

echo "To change password of Jupyter notebook on web browser, you need to run command: 'jupyter notebook password', enter new password, then copy the encrypted password in file .jupyter/jupyter_notebook_config.json to the password setting in file .jupyter/jupyter_notebook_config.py; all these steps should be executed under the user $NEWUSER"
