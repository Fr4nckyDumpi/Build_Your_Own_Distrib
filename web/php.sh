#!/bin/bash

apt-get install -y php && apt-get install -y php-mysql && apt-get install -y libapache2-mod-php
a2nmod php
service apache2 reload

indexhtml()
{
    echo "<html>"
    echo "<head>"
    echo "  <title>"
    echo "  EzPage"
    echo "  </title>"
    echo "</head>"
    echo ""
    echo "<body>"
    echo "<?php phpinfo(); ?>"
    echo "</body>"
    echo "</html>"  
}

DIRECTORY=/var/www/html/

rm -f ${DIRECTORY}index.html
rm -f ${DIRECTORY}index.php

indexhtml > ${DIRECTORY}index.php

service apache2 restart
        
