package com.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DB {

    public static Connection getConnection() {
        Connection con = null;

        try {
            // Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Cloud MySQL connection (InfinityFree)
            String url = "jdbc:mysql://sql309.infinityfree.com:3306/if0_41795861_IssueReportingSystem?useSSL=false&allowPublicKeyRetrieval=true";
            String user = "if0_41795861";
            String pass = "WkHaYYa848en";

            con = DriverManager.getConnection(url, user, pass);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}