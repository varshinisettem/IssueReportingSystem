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

            if (url == null || user == null || pass == null) {
                throw new RuntimeException("Missing DB env variables in Railway");
            }

            // 🔥 IMPORTANT FIX: SSL trust added
            url = url + "&trustCertificateKeyStoreUrl=";

            con = DriverManager.getConnection(url, user, pass);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}