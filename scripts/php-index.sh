#!/bin/bash
#update os
yum update -y
#install apache server
yum install -y httpd
# get private ip address of ec2 instance using instance metadata
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H
"X-aws-ec2-metadata-token-ttl-seconds: 21600"` \
&& PRIVATE_IP=`curl -H "X-aws-ec2-metadata-token: $TOKEN"
http://169.254.169.254/latest/meta-data/local-ipv4`
# get public ip address of ec2 instance using instance metadata
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H
"X-aws-ec2-metadata-token-ttl-seconds: 21600"` \
&& PUBLIC_IP=`curl -H "X-aws-ec2-metadata-token: $TOKEN"
http://169.254.169.254/latest/meta-data/public-ipv4`
# get date and time of server
DATE_TIME=`date`
# install composer
yum install composer -y
# set all permissions
chmod -R 777 /var/www/html
# create a custom index.php file
echo "<html>
<head>
    <title> Application Load Balancer</title>
</head>
<body>
    <h1>Testing Application Load Balancer</h1>
    <h2>Congratulations! You have created an instance from Launch Template</h2>
    <h3>This web server is launched from the launch template by YOUR_NAME</h3>
    <p>This instance is created at <b>$DATE_TIME</b></p>
    <p>Private IP address of this instance is <b>$PRIVATE_IP</b></p>
    <p>Public IP address of this instance is <b>$PUBLIC_IP</b></p>
<?php
$host = '$RDS_PUBLIC_IP';
$dbname = 'clarusway'
$username = 'root';
$password = 'mc4nx4uDx54yAt';
try {
    // Create a new PDO instance
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    // Set PDO attributes to handle errors
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    // Display success message if connected
    echo "<p style='color:green;'>Connected successfully to the database.</p>";
} catch (PDOException $e) {
    // Display error message if connection fails
    echo "<p style='color:red'>Connection failed: " . $e->getMessage();
}
?>
</body>
</html>" > /var/www/html/index.php

# start apache server

systemctl start httpd
systemctl enable httpd