/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.User;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import java.sql.PreparedStatement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class DAOUser extends DBConnect {
    
    public int updateAddress(int id, String address) {
        int n = 0;
        String sql = """
                     UPDATE [dbo].[users]
                        SET [address] = ?
                      WHERE [user_id] = ?""";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, address);
            ps.setInt(2, id);

            n = ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return n;
    }

    public boolean checkLastAdminNotBanned(int userId) {
        ResultSet rs = getData("select * from users where isAdmin = '1' and isBanned = '0' and user_id <> " + userId);

        try {
            if (rs.next()) {
                return false;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return true;
    }

    public int updateUser(User user) {
        int n = 0;
        String sql = "UPDATE [dbo].[users]\n"
                + "   SET [password] = ?\n"
                + "      ,[fullname] = ?\n"
                + "      ,[email] = ?\n"
                + "      ,[phone] = ?\n"
                + "      ,[address] = ?\n"
                + " WHERE [user_id] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, user.getPassword());
            ps.setString(2, user.getFullname());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            ps.setInt(6, user.getUser_id());

            n = ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return n;
    }

    public int changeIsAdmin(int user_id, int isAdmin) {
        int n = 0;
        String sql = "UPDATE [dbo].[users] "
                + " SET [isAdmin] = " + isAdmin
                + " WHERE [user_id] = " + user_id;
        try {
            Statement statement = connection.createStatement();
            n = statement.executeUpdate(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return n;
    }

    public int changeIsBanned(int user_id, int isBanned) {
        int n = 0;
        String sql = "UPDATE [dbo].[users] "
                + " SET [isBanned] = " + isBanned
                + " WHERE [user_id] = " + user_id;
        try {
            Statement statement = connection.createStatement();
            n = statement.executeUpdate(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return n;
    }

    public boolean checkUserExisted(String username) {
        ResultSet rs = getData("select * from users where username = '" + username + "'");
        try {
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public int addUser(User user) {
        int n = 0;
        String sql = """
                     INSERT INTO [dbo].[users]
                                ([username]
                                ,[password]
                                ,[fullname]
                                ,[email]
                                ,[phone]
                                ,[address]
                                ,[isAdmin]
                                ,[isBanned])
                          VALUES
                                (?,?,?,?,?,?,?,?)""";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullname());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getAddress());
            ps.setInt(7, user.getIsAdmin());
            ps.setInt(8, user.getIsBanned());

            n = ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return n;
    }

    public Vector<User> getUsers(String sql) {
        Vector<User> vector = new Vector<>();

        try {
            Statement statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = statement.executeQuery(sql);

            while (rs.next()) {
                int user_id = rs.getInt(1);
                String username = rs.getString(2),
                        password = rs.getString(3),
                        fullname = rs.getString(4),
                        email = rs.getString(5),
                        phone = rs.getString(6),
                        address = rs.getString(7);
                int isAdmin = rs.getInt(8),
                        isBanned = rs.getInt(9);

                vector.add(new User(user_id, username, password, fullname, email, phone, address, isAdmin, isBanned));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return vector;
    }

    public User login(String user, String pass) {
        String sql = "select * from users where username = ? and password = ? ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, user);
            ps.setString(2, pass);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int user_id = rs.getInt(1);
                String username = rs.getString(2),
                        password = rs.getString(3),
                        fullname = rs.getString(4),
                        email = rs.getString(5),
                        phone = rs.getString(6),
                        address = rs.getString(7);
                int isAdmin = rs.getInt(8),
                        isBanned = rs.getInt(9);
                return new User(user_id, username, password, fullname, email, phone, address, isAdmin, isBanned);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        DAOUser dao = new DAOUser();
        Vector<User> vector = dao.getUsers("select * from users");
        for (User user : vector) {
            System.out.println(user);
        }
    }
}
