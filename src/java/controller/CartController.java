/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Order;
import entity.Order_Item;
import entity.Product;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Enumeration;
import model.DAOOrderItems;
import model.DAOOrders;
import model.DAOProducts;
import model.DAOUser;

/**
 *
 * @author Admin
 */
@WebServlet(name = "CartController", urlPatterns = {"/cart"})
public class CartController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        User account = (User) session.getAttribute("account");
        String service = request.getParameter("service");

        DAOProducts daoProduct = new DAOProducts();
        DAOUser daoUser = new DAOUser();
        DAOOrders daoOrder = new DAOOrders();
        DAOOrderItems daoOrderItem = new DAOOrderItems();

        if (service == null) {
            service = "listCart";
        }

        if (service.equals("checkout")) {

            if (account == null) {
                response.sendRedirect("login");
            } else {

                String submit = request.getParameter("submit");

                if (submit == null) {

                    User user = daoUser.getUsers("select * from users where user_id = " + account.getUser_id()).get(0);
                    request.setAttribute("user", user);
                    request.getRequestDispatcher("checkout.jsp").forward(request, response);

                } else {

                    String address = request.getParameter("address");
                    if (address == null || address.equals("")) {

                        User user = daoUser.getUsers("select * from users where user_id = " + account.getUser_id()).get(0);
                        request.setAttribute("user", user);
                        String message = "Please enter your address!";
                        request.setAttribute("message", message);
                        request.getRequestDispatcher("checkout.jsp").forward(request, response);

                    } else {

                        int userId = account.getUser_id();

                        daoUser.updateAddress(userId, address);

                        String status = "wait";

                        LocalDateTime now = LocalDateTime.now();
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                        String orderDate = now.format(formatter);

                        Integer orderId = daoOrder.addOrder(new Order(userId, status, orderDate));

                        Enumeration enu = session.getAttributeNames();
                        int index = 1;
                        while (enu.hasMoreElements()) {
                            String pid = (String) enu.nextElement();
                            Product product;
                            if (!pid.equals("account") && !pid.equals("numberCartProducts")) {

                                product = (Product) session.getAttribute(pid);
                                Order_Item orderItem = new Order_Item(orderId, index, product.getProduct_id(), product.getQuantity(), product.getPrice());
                                index++;
                                daoOrderItem.addOrderItem(orderItem);
                                daoProduct.updateQuantity(product.getProduct_id(), product.getQuantity());
                                session.removeAttribute(pid);

                            }

                        }
                        request.getRequestDispatcher("thankyou.jsp").forward(request, response);

                    }

                }
            }

        }

        if (service.equals("remove")) {
            int pid = Integer.parseInt(request.getParameter("pid"));
            session.removeAttribute(pid + "");
            response.sendRedirect("cart");
        }
        if (service.equals("removeAll")) {
            Enumeration cart = session.getAttributeNames();
            while (cart.hasMoreElements()) {
                String pid = (String) cart.nextElement();
                if (!pid.equals("account") && !pid.equals("numberCartProducts")) {
                    session.removeAttribute(pid);
                }
            }
            response.sendRedirect("cart");
        }
        if (service.equals("updateCart")) {
            Enumeration cart = session.getAttributeNames();
            String message = "";
            while (cart.hasMoreElements()) {
                String pid = (String) cart.nextElement();
                Product product;

                if (!pid.equals("account") && !pid.equals("numberCartProducts")) {
                    product = (Product) session.getAttribute(pid);
                    
                    int quantity = Integer.parseInt(request.getParameter("quantity" + pid));
                    
                    if (quantity < 1) {
                        quantity = 1;
                    }
                    int availableQuantity = daoProduct.getProductById(Integer.parseInt(pid)).getQuantity();
                    if (quantity > availableQuantity) {
                        
                        product.setQuantity(availableQuantity);
                        
                        message += "There are only " + availableQuantity + " " + product.getProduct_name() + " left in stock!<br>";
                        request.setAttribute("message", message);
                    } else {
                        product.setQuantity(quantity);
                    }

                }
            }
            request.getRequestDispatcher("cart.jsp").forward(request, response);
        }

        if (service.equals("addToCart")) {

            int pid = Integer.parseInt(request.getParameter("pid"));
            Product product;
            
            product = (Product) session.getAttribute(pid + "");

            int quantity = Integer.parseInt(request.getParameter("quantity"));
            if (quantity < 1) {
                quantity = 1;
            }

            int availableQuantity = daoProduct.getProductById(pid).getQuantity();
            if (quantity > availableQuantity || (product != null && (product.getQuantity() + quantity > availableQuantity))) {

                String message = "There are only " + availableQuantity + " available in stock!";
                request.setAttribute("message", message);
                request.getRequestDispatcher("shop?service=productDetail&productId=" + pid).forward(request, response);

            } else {

                if (product == null) {
                    Product p = daoProduct.getProductById(pid);

                    product = new Product(pid, p.getProduct_name(), p.getPrice(), quantity, p.getImage_url());

                    session.setAttribute(pid + "", product);
                } else {
                    product.setQuantity(product.getQuantity() + quantity);
                    session.setAttribute(pid + "", product);
                }
                response.sendRedirect("cart");
            }
        }

        if (service.equals("listCart")) {
            request.getRequestDispatcher("cart.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
