echo "This script creates a new user and sets up nginx and Shiny Server, so that Shiny Server could be ran on the server under the new user and accessible from a client via web browser."

echo "Please note the prerequisite for this server: nginx, Python3, R, and Shiny should already be installed by the root user."

echo "This script needs to be run with administrator right."

echo "Enter new username:"

read NEWUSER

echo "New username is $NEWUSER"

echo

echo "Enter domain name to be used for the Shiny Server service:"

read DOMAINNAME

echo "Enter port number for Shiny Server of the new user (port 3838 is standard, port should be free in this server, e.g. no instance of Shiny Server using it):"

read PORTNUMBER

adduser $NEWUSER

cp domain.name.conf /etc/nginx/sites-available/$DOMAINNAME.conf

sed -i "s/domain.name/$DOMAINNAME/g" /etc/nginx/sites-available/$DOMAINNAME.conf

sed -i "s/3838/$PORTNUMBER/g" /etc/nginx/sites-available/$DOMAINNAME.conf

rm /etc/nginx/sites-enabled/$DOMAINNAME.conf

ln -s /etc/nginx/sites-available/$DOMAINNAME.conf /etc/nginx/sites-enabled/

echo "LC_ALL=en_US.UTF-8" >> /etc/default/locale

nginx -t

cp shiny-server.conf /etc/shiny-server/

sed -i "s/3838/$PORTNUMBER/g" /etc/shiny-server/shiny-server.conf

systemctl restart nginx

systemctl restart shiny-server

runuser -l $NEWUSER -c "mkdir ~/shiny_app"

echo "Setup finished, remember to point your chosen domain name $DOMAINNAME to this server. Login the server via SSH as user $NEWUSER, put your Shiny app in folder /home/$NEWUSER/shiny_app"
