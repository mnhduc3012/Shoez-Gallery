/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;


public class Order {
    private int order_id,user_id;
    private String status,order_date;

    public Order() {
    }

    public Order(int user_id, String status, String order_date) {
        this.user_id = user_id;
        this.status = status;
        this.order_date = order_date;
    }

    public Order(int order_id, int user_id, String status, String order_date) {
        this.order_id = order_id;
        this.user_id = user_id;
        this.status = status;
        this.order_date = order_date;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getOrder_date() {
        return order_date;
    }

    public void setOrder_date(String order_date) {
        this.order_date = order_date;
    }

    @Override
    public String toString() {
        return "Order{" + "order_id=" + order_id + ", user_id=" + user_id + ", status=" + status + ", order_date=" + order_date + '}';
    }


  
}
