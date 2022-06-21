#!/bin/bash

yum upgrade -y && sudo amazon-linux-extras install nginx1 && systemctl start nginx && systemctl enable nginx