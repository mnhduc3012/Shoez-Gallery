/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Brand;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

/**
 *
 * @author Admin
 */
public class DAOBrands extends DBConnect {

    public int addBrand(Brand brand) {
        int n = 0;
        String sql = """
                     INSERT INTO [dbo].[brands]
                                           ([brand_name])
                                     VALUES
                                           (?)""";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, brand.getBrand_name());
          
            n = ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public int deleteBrand(int brand_id) {
        int n = 0;
        String sql = """
                    DELETE FROM [dbo].[brands]
                                 WHERE brand_id = """ + brand_id;
        ResultSet rs = getData("select * from products where brand_id = " + brand_id);
        try {
            Statement statement = connection.createStatement();
            if (rs.next()) {
                return n;
            }
            n = statement.executeUpdate(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return n;
    }

    public int updateBrand(Brand brand) {
        int n = 0;
        String sql = """
                     UPDATE [dbo].[brands]
                         SET [brand_name] = ?
                       WHERE [brand_id] = ?""";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, brand.getBrand_name());
            ps.setInt(2, brand.getBrand_id());

            n = ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return n;
    }

    public Vector<Brand> getBrands(String sql) {
        Vector<Brand> vector = new Vector<>();

        try {
            Statement statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = statement.executeQuery(sql);

            while (rs.next()) {
                int brand_id = rs.getInt(1);
                String brand_name = rs.getString(2);

                vector.add(new Brand(brand_id, brand_name));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return vector;
    }

    public static void main(String[] args) {
        DAOBrands dao = new DAOBrands();
        Vector<Brand> vector = dao.getBrands("select * from brands");
        for (Brand brand : vector) {
            System.out.println(brand);
        }
    }
}
