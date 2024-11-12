/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.logging.Logger;

public class DBConnect {

    protected Connection connection = null;

    public DBConnect(String url, String userName, String pass) {
        //url: string connection: chua thong tin server,DB
        //acc: user,pass : acc cua server
        try {
            //Driver
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            //Connection
            connection = DriverManager.getConnection(url, userName, pass);
            Logger logger = Logger.getLogger(getClass().getName());
            logger.info("connected");

        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
        }
    }

    public DBConnect() {
        this("jdbc:sqlserver://localhost:1433;databaseName=SHOP", "sa", "123");
    }

    public ResultSet getData(String sql) {
        ResultSet rs = null;
        Statement statement = null;
        try {
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            rs = statement.executeQuery(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        } 
        return rs;
    }

    public static void main(String[] args) {
        new DBConnect();
    }
}
