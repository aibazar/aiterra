#!/bin/bash

yum update -y 

# install apache server
yum install httpd -y 

# Start apache server
service httpd start