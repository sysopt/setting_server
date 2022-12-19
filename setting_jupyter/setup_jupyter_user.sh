NEWUSER="jupyter"

adduser $NEWUSER

cp jupyter.toiuu.net /etc/nginx/sites-available/

rm /etc/nginx/sites-enabled/jupyter.toiuu.net

ln -s /etc/nginx/sites-available/jupyter.toiuu.net /etc/nginx/sites-enabled/

nginx -t

systemctl restart nginx

cp -r .jupyter /home/$NEWUSER/

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

echo "Setup finished. Login as user $NEWUSER, type run_jupyter_in_background to start the jupyter notebook, it is accessible at jupyter.toiuu.net with password PyOpt1, its data is stored in /home/$NEWUSER/webdata"

echo "To change password of Jupyter notebook on web browser, you need to run command: 'jupyter notebook password', enter new password, then copy the encrypted password in file .jupyter/jupyter_notebook_config.json to the password setting in file .jupyter/jupyter_notebook_config.py; all these steps should be executed under the user $NEWUSER"
