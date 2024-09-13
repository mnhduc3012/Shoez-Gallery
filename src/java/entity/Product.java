/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Admin
 */
public class Product {

    private int product_id;
    private String product_name;
    private double price;
    private int quantity;
    private String description, image_url;
    private int brand_id;
    private String release_date;

    
    public Product() {
    }

    public Product(int product_id, String product_name, double price, int quantity, String image_url) {
        this.product_id = product_id;
        this.product_name = product_name;
        this.price = price;
        this.quantity = quantity;
        this.image_url = image_url;
    }

    

    public Product(String product_name, double price, int quantity, String description, String image_url, int brand_id, String release_date) {
        this.product_name = product_name;
        this.price = price;
        this.quantity = quantity;
        this.description = description;
        this.image_url = image_url;
        this.brand_id = brand_id;
        this.release_date = release_date;
    }

    public Product(int product_id, String product_name, double price, int quantity, String description, String image_url, int brand_id, String release_date) {
        this.product_id = product_id;
        this.product_name = product_name;
        this.price = price;
        this.quantity = quantity;
        this.description = description;
        this.image_url = image_url;
        this.brand_id = brand_id;
        this.release_date = release_date;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage_url() {
        return image_url;
    }

    public void setImage_url(String image_url) {
        this.image_url = image_url;
    }

    public int getBrand_id() {
        return brand_id;
    }

    public void setBrand_id(int brand_id) {
        this.brand_id = brand_id;
    }

    public String getRelease_date() {
        return release_date;
    }

    public void setRelease_date(String release_date) {
        this.release_date = release_date;
    }

    @Override
    public String toString() {
        return "Product{" + "product_id=" + product_id + ", product_name=" + product_name + ", price=" + price + ", quantity=" + quantity + ", description=" + description + ", image_url=" + image_url + ", brand_id=" + brand_id + ", release_date=" + release_date + '}';
    }

}
