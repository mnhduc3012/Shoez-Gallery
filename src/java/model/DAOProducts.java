/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Product;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.util.Collections;
import java.util.Comparator;
import java.util.Vector;

/**
 *
 * @author Admin
 */
public class DAOProducts extends DBConnect {
    
    public int updateQuantity (int productId, int orderQuantity) {
        int n = 0;
        Product product = getProductById(productId);
        String sql = """
                     UPDATE [dbo].[products]
                      SET [quantity] = ?            
                      WHERE [product_id] = ?""";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            int newQuantity = product.getQuantity() - orderQuantity;
            if(newQuantity < 0){
                return n;
            }
            ps.setInt(1, newQuantity  );           
            ps.setInt(2, productId );
            
            n = ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }
    
    public int deleteProduct(int product_id) {
        int n = 0;
        String sql = "DELETE FROM [dbo].[products]\n"
                + "      WHERE product_id = " + product_id;
        ResultSet rs = getData("select * from order_items where product_id = " + product_id);
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

    public int updateProduct(Product product) {
        int n = 0;
        String sql = """
                     UPDATE [dbo].[products]
                        SET [product_name] = ? 
                           ,[price] = ?
                           ,[quantity] = ?
                           ,[description] = ?
                           ,[image_url] = ?
                           ,[brand_id] = ?
                           ,[release_date] = ?
                      WHERE [product_id] = ?""";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, product.getProduct_name());
            ps.setDouble(2, product.getPrice());
            ps.setInt(3, product.getQuantity());
            ps.setString(4, product.getDescription());
            ps.setString(5, product.getImage_url());
            ps.setInt(6, product.getBrand_id());
            ps.setString(7, product.getRelease_date());
            ps.setInt(8, product.getProduct_id());
            n = ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return n;
    }

    

    public Vector<Product> filterByBrand(String brand_id, Vector<Product> vector) {
        Vector<Product> filteredVector = new Vector<>();
        if (brand_id == null || brand_id.equals("")) {
            return vector;
        } else {
            for (Product product : vector) {
                if (product.getBrand_id() == Integer.parseInt(brand_id)) {
                    filteredVector.add(product);
                }
            }
        }
        return filteredVector;
    }

    public Vector<Product> sortProduct(String sortOption, Vector<Product> vector) {
        if (sortOption == null) {
            return vector;
        }
        if (sortOption.equals("latest")) {
            vector.sort(Comparator.comparing(Product::getRelease_date, Comparator.reverseOrder()));
        }
        if (sortOption.equals("name-asc")) {
            vector.sort(Comparator.comparing(Product::getProduct_name));
        }
        if (sortOption.equals("name-desc")) {
            vector.sort(Comparator.comparing(Product::getProduct_name, Comparator.reverseOrder()));
        }
        if (sortOption.equals("price-asc")) {
            vector.sort(Comparator.comparing(Product::getPrice));
        }
        if (sortOption.equals("price-desc")) {
            vector.sort(Comparator.comparing(Product::getPrice, Comparator.reverseOrder()));
        }
        return vector;
    }

    public Product getProductById(int id) {
        String sql = "select * from products where product_id = " + id;
        Product product = null;
        try {
            Statement statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = statement.executeQuery(sql);

            while (rs.next()) {
                int product_id = rs.getInt(1);
                String product_name = rs.getString(2);
                double price = rs.getDouble(3);
                int quantity = rs.getInt(4);
                String description = rs.getString(5),
                        image_url = rs.getString(6);
                int brand_id = rs.getInt(7);
                String release_date = rs.getString(8);

                product = new Product(product_id, product_name, price, quantity, description, image_url, brand_id, release_date);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return product;
    }

    public Vector<Product> getProducts(String sql) {
        Vector<Product> vector = new Vector<>();

        try {
            Statement statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = statement.executeQuery(sql);

            while (rs.next()) {
                int product_id = rs.getInt(1);
                String product_name = rs.getString(2);
                double price = rs.getDouble(3);
                int quantity = rs.getInt(4);
                String description = rs.getString(5),
                        image_url = rs.getString(6);
                int brand_id = rs.getInt(7);
                String release_date = rs.getString(8);

                vector.add(new Product(product_id, product_name, price, quantity, description, image_url, brand_id, release_date));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return vector;
    }

    public int addProduct(Product product) {
        int n = 0;
        String sql = """
                     INSERT INTO [dbo].[products]
                                ([product_name]
                                ,[price]
                                ,[quantity]
                                ,[description]
                                ,[image_url]
                                ,[brand_id]
                                ,[release_date])
                          VALUES
                                (?,?,?,?,?,?,?)""";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, product.getProduct_name());
            ps.setDouble(2, product.getPrice());
            ps.setInt(3, product.getQuantity());
            ps.setString(4, product.getDescription());
            ps.setString(5, product.getImage_url());
            ps.setInt(6, product.getBrand_id());
            ps.setString(7, product.getRelease_date());

            n = ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public static void main(String[] args) {
        DAOProducts dao = new DAOProducts();
//        Vector<Product> vector = dao.getProducts("""
//                                                        select top 5 * 
//                                                        from products
//                                                        order by release_date desc""");
//        for (Product product : vector) {
//            System.out.println(product);
//        }
//        int n = dao.insertProduct(new Product( "demo", 0, 0, "", "", 1, ""));
//        if(n>0){
//            System.out.println("inserted");
//        }

//        int n = dao.updateProduct(new Product(30, "ASICS Gel-NYC", 125, 60, "", "img/asics-NYC.png", 6, "2023-03-03"));
//        if(n>0){
//            System.out.println("updated");
//        }else{
//            System.out.println("fail");
//        }
    }
}
