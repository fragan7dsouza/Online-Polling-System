
# 🗳️ Online Polling System

A clean and efficient **Java-based web application** designed to create polls, cast votes, and visualize results in real time.

Built using **JSP, Servlets, JDBC, and MySQL**, and deployed on **Apache Tomcat** for seamless execution.

---

## ⚙️ Features

### ✅ Dynamic Poll Management (`/manage-polls`)
- Admins can **Create, Edit, and Delete** polls with multiple options.
- **Cascade delete** ensures all related options and votes are removed safely.

### ✅ User Voting Interface (`/polls-for-voting`)
- Users can browse available polls and cast a vote using simple radio-button inputs.
- Built-in validation ensures legitimate voting.

### ✅ Real-Time Results Visualization (`/view-results`)
- Results are displayed instantly using **interactive bar charts** (Chart.js).
- Clear visualization for comparing votes across all options.

### ✅ Responsive UI
- Minimal and clean layout built with **HTML5 + CSS3** for both desktop and mobile browsers.

---

## 🧩 Technical Overview

### 🏗️ Architecture Layers

| Layer | Components | Description |
| :--- | :--- | :--- |
| **Presentation (View)** | JSP Pages | Displays UI for voting, managing polls, and viewing results. |
| **Logic / Controller** | Servlets (PollServlet, VoteServlet) | Handles request processing, validation, and routing. |
| **Data Access Layer** | DAO Classes (PollDAO, OptionDAO, VoteDAO) | Manages CRUD operations and JDBC queries. |
| **Database** | MySQL Tables | Stores polls, options, and votes with proper relational mapping. |

---

## 📁 Project Structure

```text
OnlinePollingSystem/
│
├── src/main/java/com/polling/
│   ├── dao/                 (Database Access Layer)
│   ├── model/               (Models: Poll, Option, Vote)
│   └── util/                (DBUtil for MySQL Connection)
│
├── src/main/webapp/
│   ├── index.jsp            (Landing Page)
│   ├── manage-polls.jsp     (Admin Panel)
│   ├── polls-for-voting.jsp (User Voting Page)
│   ├── view-results.jsp     (Results + Chart.js)
│   └── style.css            (Custom Styles)
│
├── pom.xml / build files
└── README.md
````

-----

## ⚙️ Setup & Installation

### 1️⃣ Database Setup

Create a database named `polling_db` and run this schema:

```sql
CREATE DATABASE IF NOT EXISTS polling_db;
USE polling_db;

CREATE TABLE polls (
    poll_id INT PRIMARY KEY AUTO_INCREMENT,
    question VARCHAR(500) NOT NULL
);

CREATE TABLE options (
    option_id INT PRIMARY KEY AUTO_INCREMENT,
    poll_id INT,
    option_text VARCHAR(300) NOT NULL,
    FOREIGN KEY (poll_id) REFERENCES polls(poll_id) ON DELETE CASCADE
);

CREATE TABLE votes (
    vote_id INT PRIMARY KEY AUTO_INCREMENT,
    option_id INT,
    FOREIGN KEY (option_id) REFERENCES options(option_id) ON DELETE CASCADE
);
```

### 2️⃣ Project Configuration

Update your database credentials in `src/main/java/com/polling/util/DBUtil.java`:

```java
private static final String USERNAME = "root";
private static final String PASSWORD = "your_password"; // Update this!
```

### 3️⃣ Running the Application

1.  Import the project as a **Dynamic Web Project** in Eclipse.
2.  Right-click project → **Run As** → **Run on Server**.
3.  Choose **Apache Tomcat v9.0**.
4.  Open in browser:
    ➡️ `http://localhost:8080/OnlinePollingSystem/`

-----

## 🚀 Example Usage

### 🗳️ Cast a Vote

1.  Navigate to **Polls for Voting**.
2.  Choose an option and click **Vote**.
3.  Get a confirmation alert and view results instantly.

### 🛠️ Manage Polls (Admin)

1.  Open **Manage Polls**.
2.  Add a new question with options.
3.  Edit or delete polls as needed.
4.  View results with interactive charts.

-----

## 📌 Notes

  * The system uses **JDBC** for SQL operations.
  * **Chart visualizations** are powered by Chart.js.
  * Ideal for college events, surveys, feedback systems, classrooms, etc.

-----

## 👨‍💻 Author

**Fragan Dsouza**

📎 [LinkedIn](https://linkedin.com/in/fragan-dsouza) <br>
💻 [GitHub](https://github.com/fragan7dsouza)

-----

## 📜 License

This project is open-source under the **MIT License**.
