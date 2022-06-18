#!/bin/bash

yum upgrade -y && yum install httpd && systemctl start httpd.service && systemctl enable httpd.service