#! bin/bash
yum update -y
yum install python3 git -y
pip3 install Flask
cd /home/ec2-user
git clone https://github.com/bluehackrafestefano/Project-001-Roman-Numerals-Converter-08.git app
cd app
python3 app.py
