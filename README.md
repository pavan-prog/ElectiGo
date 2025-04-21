# ElectiGo (Monolithic Application)

**ElectiGo** is an online-based election management system where **Super Admin**, **Sub Admin**, and **Voters** interact within a role-based access control scheme. The application allows Super Admins to create and manage elections, Sub Admins to oversee the elections and candidates, and Voters to securely cast their votes after authorization.

---

## 🚀 Features

- **Role-Based Access Control (RBAC)**:
  - Super Admin: Manages elections and assigns subadmins.
  - Sub Admin: Manages elections, adds candidates, and authorizes registered voters.
  - Voter: Casts a vote only once for election after registration and authorization.
  
- **Election Management**: Super Admins can create and manage elections, which are assigned to Sub Admins for further processing.

- **Secure Voting**: Voters can register and vote securely after being authorized by Sub Admins.

- **Role-Based Authentication**: Different access levels for different users to ensure secure and controlled access.

---

## 🛠️ Tech Stack

- **Java 17+**
- **Spring Boot**
- **MySQL** (for data storage)
- **REST API** (for the front-end and back-end)

---

## ⚙️ Setup Instructions

### Clone the repository
```
git clone https://github.com/pavan-prog/ElectiGo.git
```
### Configure the Database
```
spring.datasource.url=jdbc:mysql://localhost:3306/electigo_db
spring.datasource.username=root
spring.datasource.password=your_password
```

### Build the Docker image
```
docker build -t electigo-app .
```
### Pull the MYSQL Docker image
```
docker pull mysql:latest
```
### Create a Docker network
```
docker network create electigo-network
```

### Run the MYSQL container 
connect it to the created network
```
docker run --name mysql-container --network electigo-network -e MYSQL_ROOT_PASSWORD=yourpassword -e MYSQL_DATABASE=electigo_db -p 3306:3306 -d mysql:latest
```
### Copy the SQL Dump File to the Container
Ensure you are in the directory where Dump20250421.sql is located (e.g., your Downloads folder)
```
cd ~/Downloads
```
```
docker cp Dump20250421.sql my_mysql_container:/dump.sql
```
### Import the SQL Dump into the MySQL Container
```
docker exec -i my_mysql_container mysql -u root -pmy-secret-pw electi_go < /dump.sql
```
### Verify the Data Import
Connect to the MySQL container and check the tables
```
docker exec -it my_mysql_container mysql -u root -pmy-secret-pw
```
once inside the MYSQL shell, run:
```
USE electi_go;
SHOW TABLES;
```
```
SELECT * FROM admin;
```
```
SELECT * FROM candidates;
```

### Run the ElectiGo Application container
connect it to the created network

```
docker run --name electigo-app-container --network electigo-network -p 8080:8080 -d electigo-app
```

### Access the Application
Once both containers are running, you can access the ElectiGo application at 
```
http://localhost:8080
```
