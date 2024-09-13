/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Product;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.ResultSet;
import model.DAOProducts;
import java.sql.SQLException;
import java.util.Vector;

/**
 *
 * @author Admin
 */
@WebServlet(name = "DashboardController", urlPatterns = {"/dashboard"})
public class DashboardController extends HttpServlet {

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
        DAOProducts dao = new DAOProducts();

        User account = (User) session.getAttribute("account");

        if (account == null || account.getIsAdmin() != 1) {
            response.sendRedirect("home");
        } else {

            ResultSet rsSummary = dao.getData("""
                                          select SUM( oi.quantity*oi.price ),SUM(oi.quantity),
                                          \t(select COUNT(o.order_id) from orders o),
                                          \t(select COUNT(user_id) from users where isAdmin = 0)
                                          from order_items oi
                                          join products p on p.product_id = oi.product_id""");

            ResultSet rsChart = dao.getData("""
                                            select b.brand_id,b.brand_name,SUM(oi.price*oi.quantity),SUM(oi.quantity)
                                            from brands b
                                            left join products p on p.brand_id = b.brand_id
                                            left join order_items oi on oi.product_id = p.product_id
                                            group by b.brand_id,b.brand_name""");

            String labels = "[";
            String dataRevenue = "[";
            String dataProduct = "[";
            try {
                while (rsChart.next()) {

                    if (rsChart.isLast()) {
                        labels += "'" + rsChart.getString(2) + "']";
                        dataRevenue += rsChart.getDouble(3) + "]";
                        dataProduct += rsChart.getInt(4) + "]";
                    } else {
                        labels += "'" + rsChart.getString(2) + "',";
                        dataRevenue += rsChart.getDouble(3) + ",";
                        dataProduct += rsChart.getInt(4) + ",";
                    }
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }

            Vector<Product> bestSellerProducts = dao.getProducts("""
                                                                 select top 5 p.*
                                                                 from products p
                                                                 join order_items oi on p.product_id = oi.product_id
                                                                 order by oi.quantity desc""");

            ResultSet rsRecentOrder = dao.getData("""
                                                  select top 5 o.order_id,u.username,SUM(oi.quantity*oi.price),o.status,o.order_date
                                                  from orders o 
                                                  join users u on o.user_id = u.user_id
                                                  join order_items oi on oi.order_id = o.order_id
                                                  join products p on p.product_id = oi.product_id
                                                  group by o.order_id,u.username,o.status,o.order_date
                                                  order by o.order_date desc, o.order_id desc""");

            ResultSet rsTopUsers = dao.getData("""
                                               select top 5 u.user_id,u.username,SUM(oi.quantity*oi.price) as total,COUNT(DISTINCT(o.order_id))
                                               from users u
                                               join orders o on o.user_id = u.user_id
                                               join order_items oi on oi.order_id = o.order_id
                                               join products p on p.product_id = oi.product_id
                                               group by u.user_id,u.username
                                               order by total desc
                                               """);

            ResultSet rsNewCustomer = dao.getData("""
                                                  select COUNT(t.user_id)
                                                  from (
                                                  select u.user_id,COUNT(o.order_id) as numOrder
                                                  from users u
                                                  join orders o on o.user_id = u.user_id
                                                  group by u.user_id) t
                                                  where numOrder <= 1""");
            
            ResultSet rsReturnCustomer = dao.getData("""
                                                     select COUNT(t.user_id)
                                                     from (
                                                     select u.user_id,COUNT(o.order_id) as numOrder
                                                     from users u
                                                     join orders o on o.user_id = u.user_id
                                                     group by u.user_id) t
                                                     where numOrder > 1""");
            
            String dataCustomer = "[";
            
            try {
                if (rsNewCustomer.next()) {
                    dataCustomer += rsNewCustomer.getInt(1);
                }
                dataCustomer += ",";
                if(rsReturnCustomer.next()){
                    dataCustomer += rsReturnCustomer.getInt(1);
                }
                dataCustomer += "]";
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            
            request.setAttribute("dataCustomer", dataCustomer);
            request.setAttribute("rsTopUsers", rsTopUsers);
            request.setAttribute("rsRecentOrder", rsRecentOrder);
            request.setAttribute("bestSellerProducts", bestSellerProducts);
            request.setAttribute("labels", labels);
            request.setAttribute("dataRevenue", dataRevenue);
            request.setAttribute("dataProduct", dataProduct);
            request.setAttribute("rsSummary", rsSummary);

            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
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
