#!/bin/bash

# Start mysql
/etc/init.d/mysql start

# Start apache
apachectl -DFOREGROUND

