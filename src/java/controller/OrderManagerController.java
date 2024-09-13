/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Order;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.DAOOrders;
import java.sql.ResultSet;

/**
 *
 * @author Admin
 */
@WebServlet(name = "OrderManagerController", urlPatterns = {"/orderManager"})
public class OrderManagerController extends HttpServlet {

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

        DAOOrders dao = new DAOOrders();
        String service = request.getParameter("service");

        User account = (User) session.getAttribute("account");

        if (service == null) {
            service = "listOrders";
        }

        if (service.equals("showDetail")) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String sql = "select o.order_id,u.user_id,u.username,o.order_date,o.status,oi.item_id,p.product_id,p.image_url,p.product_name,oi.price,oi.quantity\n"
                    + "from orders o\n"
                    + "join users u on o.user_id = u.user_id\n"
                    + "join order_items oi on oi.order_id = o.order_id\n"
                    + "join products p on p.product_id = oi.product_id\n"
                    + "where o.order_id = " + orderId;
            ResultSet rsOrderDetail = dao.getData(sql);
            request.setAttribute("rsOrderDetail", rsOrderDetail);

            request.getRequestDispatcher("orderDetail.jsp").forward(request, response);
        }
        
        if (service.equals("changeStatus")) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String orderStatus = request.getParameter("orderStatus");
            Order order = dao.getOrders("select * from orders where order_id = " + orderId).get(0);
            String message;
            String color;
            if (order.getStatus().equals("done")) {
                message = "Status of this Order is done, you can not change it!";
                color = "red";
            } else if (order.getStatus().equals("canceled")) {
                message = "Status of this Order is canceled, you can not change it!";
                color = "red";
            } else {
                dao.changeStatus(orderId, orderStatus);
                message = "Change status of Order(id=" + orderId + ") to " + orderStatus + "!";
                color = "green";
            }
            request.setAttribute("color", color);
            request.setAttribute("message", message);
            request.getRequestDispatcher("orderManager?service=showDetail&orderId=" + orderId).forward(request, response);
        }
        
        if (service.equals("listOrderHistory")) {
            try {
                int user_id = Integer.parseInt(request.getParameter("userId"));

                String sql = "select o.order_id,o.order_date,SUM(oi.quantity),SUM(oi.price*oi.quantity),o.status \n"
                        + "from orders o\n"
                        + "join order_items oi on o.order_id = oi.order_id\n"
                        + "join products p on p.product_id = oi.product_id\n"
                        + "where o.user_id = " + user_id
                        + " group by  o.order_id,o.order_date,o.status ";

                ResultSet rsOrderHistory = dao.getData(sql);

                ResultSet rsSummary = dao.getData("select (select COUNT(order_id) from orders where user_id = " + user_id + " and status <> 'canceled'" + ")"
                        + ",SUM(oi.quantity),SUM(oi.quantity*oi.price)\n"
                        + "from order_items oi\n"
                        + "join products p on oi.product_id= p.product_id\n"
                        + "join orders o on o.order_id = oi.order_id\n"
                        + "where o.user_id = " + user_id + " and status <> 'canceled'");

                request.setAttribute("rsOrderHistory", rsOrderHistory);
                request.setAttribute("rsSummary", rsSummary);
                request.getRequestDispatcher("orderHistory.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                request.getRequestDispatcher("login").forward(request, response);
            }
        }

        if (account == null || account.getIsAdmin() == 0) {
            response.sendRedirect("home");
        } else {

            if (service.equals("listOrders")) {

                ResultSet rsOrder;
                ResultSet rsStatus = dao.getData("select status from orders group by status");

                String status = request.getParameter("status");
                if (status == null) {
                    rsOrder = dao.getData("""
                                      select o.order_id,u.user_id,u.username,u.email,u.phone,u.address,o.order_date,SUM(oi.price*oi.quantity),o.status
                                                                                                           from orders o
                                                                                                           join users u on o.user_id = u.user_id
                                                                                                           join order_items oi on oi.order_id = o.order_id
                                                                                                           join products p on p.product_id = oi.product_id
                                                                                                           group by o.order_id,u.user_id,u.username,u.email,u.phone,u.address,o.order_date,o.status""");
                } else {
                    rsOrder = dao.getData("select o.order_id,u.user_id,u.username,u.email,u.phone,u.address,o.order_date,SUM(oi.price*oi.quantity),o.status\n"
                            + "                                                                     from orders o\n"
                            + "                                                                     join users u on o.user_id = u.user_id\n"
                            + "                                                                     join order_items oi on oi.order_id = o.order_id\n"
                            + "                                                                     join products p on p.product_id = oi.product_id\n"
                            + "                                                                     where o.status = '" + status + "'"
                            + "                                                                     group by o.order_id,u.user_id,u.username,u.email,u.phone,u.address,o.order_date,o.status");
                }

                request.setAttribute("status", status);

                request.setAttribute("rsOrder", rsOrder);
                request.setAttribute("rsStatus", rsStatus);
                request.getRequestDispatcher("orderManager.jsp").forward(request, response);

            }

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
