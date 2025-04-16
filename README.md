# ElectiGo

**ElectiGo** is an online-based election management system where **Super Admin**, **Sub Admin**, and **Voters** interact within a role-based access control scheme. The application allows Super Admins to create and manage elections, Sub Admins to oversee the elections and candidates, and Voters to securely cast their votes after authorization.

---

## 🚀 Features

- **Role-Based Access Control (RBAC)**:
  - Super Admin: Manages elections and assigns subadmins.
  - Sub Admin: Manages elections, adds candidates, and authorizes registered voters.
  - Voter: Casts a vote only once after registration and authorization.
  
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

**Clone the repository:**

```bash
git clone https://github.com/your-username/ElectiGo.git

# Example for MySQL
spring.datasource.url=jdbc:mysql://localhost:3306/electigo_db
spring.datasource.username=root
spring.datasource.password=yourpassword

# JWT Configuration
jwt.secret=yourSecretKey
