/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.DAOUser;

/**
 *
 * @author Admin
 */
@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

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
        DAOUser dao = new DAOUser();
        String service = request.getParameter("service");
        HttpSession session = request.getSession();
        if (service == null) {
            service = "login";
        }

        if (service.equals("login")) {
            String submit = request.getParameter("submit");
            if (submit == null) {
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                String username = request.getParameter("user");
                String password = request.getParameter("pass");
                User account = dao.login(username, password);

                if (account == null) {
                    String message = "Incorrect username or password!!!";
                    request.setAttribute("message", message);
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                } else if (account.getIsBanned() == 1) {
                    String message = "Your account is suspended!!!";
                    request.setAttribute("message", message);
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                } else {
                    session.setAttribute("account", account);
                    if (account.getIsAdmin() == 1) {
                        response.sendRedirect("dashboard");
                    } else {
                        response.sendRedirect("home");
                    }
                }
            }
        }
        if (service.equals("logout")) {
            session.invalidate();
            response.sendRedirect("home");
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
