/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Order;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import java.sql.PreparedStatement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author Admin
 */
public class DAOOrders extends DBConnect {

    public Integer addOrder(Order order) {
        int n = 0;
        Integer orderId = null;
        String sql = """
                     INSERT INTO [dbo].[orders]
                                ([user_id]
                                ,[status]
                                ,[order_date])
                          VALUES
                                (?,?,?)""";

        try {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, order.getUser_id());
            ps.setString(2, order.getStatus());
            ps.setString(3, order.getOrder_date());

            n = ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();

            if (rs.next()) {
                orderId = rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return orderId;
    }

    public int changeStatus(int orderId, String newStatus) {
        int n = 0;
        String sql = "UPDATE [dbo].[orders]\n"
                + "   SET [status] = ?"
                + "   WHERE [order_id] = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, newStatus);
            ps.setInt(2, orderId);
            n = ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public Vector<Order> getOrders(String sql) {
        Vector<Order> vector = new Vector<>();

        try {
            Statement statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = statement.executeQuery(sql);

            while (rs.next()) {
                int order_id = rs.getInt(1),
                        user_id = rs.getInt(2);
                String status = rs.getString(3),
                        order_date = rs.getString(3);

                vector.add(new Order(order_id, user_id, status, order_date));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return vector;
    }

    public static void main(String[] args) {
        DAOOrders dao = new DAOOrders();
//        Vector<Order> vector = dao.getOrders("select * from orders");
//        for (Order order : vector) {
//            System.out.println(order);
//        }
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String orderDate = now.format(formatter);
        int n = dao.addOrder(new Order(2, "process", orderDate));

        System.out.println(n);

    }
}
