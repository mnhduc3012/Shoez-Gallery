 package controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Vector;
import model.DAOUser;

/**
 *
 * @author Admin
 */
@WebServlet(urlPatterns = {"/userManager"})
public class UserManagerController extends HttpServlet {

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

        DAOUser daoUser = new DAOUser();
        String service = request.getParameter("service");

        if (service == null) {
            service = "listUsers";
        }

        if (service.equals("updateProfile")) {
            String submit = request.getParameter("submit");

            if (submit == null) {
                if (account == null) {
                    request.getRequestDispatcher("login").forward(request, response);
                } else {
                    User user = daoUser.getUsers("select * from users where user_id = " + account.getUser_id()).get(0);
                    request.setAttribute("user", user);
                    request.getRequestDispatcher("profile.jsp").forward(request, response);
                }
            } else {
                int user_id = Integer.parseInt(request.getParameter("user_id"));
                String username = request.getParameter("username"),
                        password = request.getParameter("password"),
                        fullname = request.getParameter("fullname"),
                        email = request.getParameter("email"),
                        phone = request.getParameter("phone"),
                        address = request.getParameter("address");
                if (password.equals("") || email.equals("") || phone.equals("")) {
                    String message = "Password, email and phone can not be empty!";
                    request.setAttribute("message", message);
                    request.setAttribute("color", "red");
                } else {
                    daoUser.updateUser(new User(user_id, username, password, fullname, email, phone, address, user_id, user_id));
                    String message = "Updated Successfully!";
                    request.setAttribute("message", message);
                    request.setAttribute("color", "green");
                }

                User user = daoUser.getUsers("select * from users where user_id = " + account.getUser_id()).get(0);
                request.setAttribute("user", user);
                request.getRequestDispatcher("profile.jsp").forward(request, response);

            }
        }

        if (account == null || account.getIsAdmin() == 0) {
            response.sendRedirect("home");
        } else {

            if (service.equals("banUser")) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                User user = daoUser.getUsers("select * from users where user_id = " + userId).get(0);
                if (user.getIsBanned() == 0) {
                    if(daoUser.checkLastAdminNotBanned(userId)){
                        //do nothing
                    }else{
                       daoUser.changeIsBanned(userId, 1);
                    }
                } else {
                    daoUser.changeIsBanned(userId, 0);
                }
                response.sendRedirect("userManager");
            }

            if (service.equals("makeAdmin")) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                User user = daoUser.getUsers("select * from users where user_id = " + userId).get(0);
                if (user.getIsAdmin() == 0) {
                    daoUser.changeIsAdmin(userId, 1);
                } else {
                    if(daoUser.checkLastAdminNotBanned(userId)){
                        //do nothing
                    }else{
                       daoUser.changeIsAdmin(userId, 0);
                    }
                    
                }
                response.sendRedirect("userManager");

            }
            if (service.equals("listUsers")) {
                String search = request.getParameter("search");
                Vector<User> listUsers;
                if (search == null) {
                    listUsers = daoUser.getUsers("select * from users");
                } else {
                    listUsers = daoUser.getUsers("select * from users where username like '%" + search + "%'");
                }

                request.setAttribute("listUsers", listUsers);

                request.getRequestDispatcher("userManager.jsp").forward(request, response);
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
