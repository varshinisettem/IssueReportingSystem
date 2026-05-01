package com.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DB {

    public static Connection getConnection() {
        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = System.getenv("DB_URL");
            String user = System.getenv("DB_USER");
            String pass = System.getenv("DB_PASS");

            // 👉 IF running locally (no env variables)
            if (url == null || user == null || pass == null) {

                url = "jdbc:mysql://localhost:3306/issue_db";
                user = "root";
                pass = "varshi"; // 🔥 put your MySQL password
            }

            con = DriverManager.getConnection(url, user, pass);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}