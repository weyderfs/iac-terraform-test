#!/bin/bash

yum upgrade -y && sudo yum install httpd -y && systemctl start httpd && systemctl enable httpd