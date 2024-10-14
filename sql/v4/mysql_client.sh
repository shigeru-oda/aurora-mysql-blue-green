sudo yum update -y
sudo yum install mariadb -y
mysql --version

ENDPOINT=$(aws rds describe-db-clusters --db-cluster-identifier aurora-mysql-blue-green-cluster --query 'DBClusters[0].Endpoint' --output text)
PASSWORD=your_password
mysql -h $ENDPOINT -u admin -p$PASSWORD

DROP DATABASE cube;

source 1.databse.sql
source 2.table.sql
source 3.setup_data.sql
source 4.check.sql
source 5.crud.sql
