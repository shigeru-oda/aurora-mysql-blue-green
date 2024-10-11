sudo yum update -y
sudo yum install mariadb -y
mysql --version
ENDPOINT=$(aws rds describe-db-clusters --db-cluster-identifier aurora-mysql-blue-green-cluster --query 'DBClusters[0].Endpoint' --output text)
PASSWORD=your_password
mysql -h $ENDPOINT -u admin -p$PASSWORD
