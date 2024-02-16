sudo apt-get update # Update the package list
sudo apt-get install apache2 # Install apache
echo "Installed apache"

sudo a2enmod cgi # Enable the CGI module for apache
echo "Enabled the CGI module for apache"

# Create a new config file for apache
echo '<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html

    <Directory "/var/www/html/cgi-bin">
        Options +ExecCGI"
        AddHandler cgi-script .cgi .pl
        AllowOverride None
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > "/etc/apache2/sites-available/cgi.conf"
echo "Created a new config file for apache"

# Create a directory for the cgi scripts
sudo mkdir /var/www/html/cgi-bin
echo "Created a directory for the cgi scripts"

# Set up permissions for the cgi-bin directory
sudo chmod a+x /var/www/html/cgi-bin
echo "Set up permissions for the cgi-bin directory"

# Set the owner of the directory (and all files in it) to the apache user, www-data
sudo chown -R www-data:www-data /var/www/html/cgi-bin
echo "Set up permissions for the cgi-bin directory"

# Add to the apache config the ability to execute cgi scripts
echo '<Directory "/var/www/html/cgi-bin">
    Options +ExecCGI
    AddHandler cgi-script .cgi .pl
    AllowOverride None
    Require all granted
</Directory>' >> "/etc/apache2/apache2.conf"