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
import java.io.IOException;
import model.DAOUser;

/**
 *
 * @author Admin
 */
@WebServlet(name = "RegisterController", urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {

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
        String submit = request.getParameter("submit");
        DAOUser dao = new DAOUser();
        if (submit == null) {
            request.getRequestDispatcher("register.jsp").forward(request, response);

        } else {
            String username = request.getParameter("username"),
                    password = request.getParameter("password"),
                    confirm = request.getParameter("confirm"),
                    fullname = request.getParameter("fullname"),
                    email = request.getParameter("email"),
                    phone = request.getParameter("phone"),
                    address = request.getParameter("address");
            if (username.equals("") || password.equals("") || confirm.equals("")
                    || email.equals("") || phone.equals("")) {
                String message = "Please enter username, password, email and phone!";
                request.setAttribute("message", message);
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else if (dao.checkUserExisted(username)) {
                String message = "User is already existed!";
                request.setAttribute("message", message);
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else if (!password.equals(confirm)) {
                String message = "Passwords do not match!";
                request.setAttribute("message", message);
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else {
                User user = new User(username, password, fullname, email, phone, address, 0, 0);
                dao.addUser(user);
                response.sendRedirect("login");
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
