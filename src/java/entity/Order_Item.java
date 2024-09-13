/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Admin
 */
public class Order_Item {
    private int order_id,item_id,product_id,quantity;
    private double price;

    public Order_Item() {
    }

    public Order_Item(int order_id, int item_id, int product_id, int quantity, double price) {
        this.order_id = order_id;
        this.item_id = item_id;
        this.product_id = product_id;
        this.quantity = quantity;
        this.price = price;
    }
    
    

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getItem_id() {
        return item_id;
    }

    public void setItem_id(int item_id) {
        this.item_id = item_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "Order_Item{" + "order_id=" + order_id + ", item_id=" + item_id + ", product_id=" + product_id + ", quantity=" + quantity + '}';
    }

    
    
    
}
