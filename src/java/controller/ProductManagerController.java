/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Brand;
import entity.Product;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Vector;
import model.DAOBrands;
import model.DAOProducts;
import java.sql.ResultSet;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ProductManagerController", urlPatterns = {"/productManager"})
public class ProductManagerController extends HttpServlet {

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

        DAOProducts daoProduct = new DAOProducts();
        DAOBrands daoBrand = new DAOBrands();
        String service = request.getParameter("service");

        User account = (User) session.getAttribute("account");
        if (account == null || account.getIsAdmin() == 0) {
            request.getRequestDispatcher("home").forward(request, response);
        } else {

            if (service == null) {
                service = "listProducts";
            }
            if (service.equals("deleteProduct")) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                int n = daoProduct.deleteProduct(productId);
                response.sendRedirect("productManager");
            }
            if (service.equals("addProduct")) {
                String submit = request.getParameter("submit");
                if (submit == null) {
                    Vector<Brand> brands = daoBrand.getBrands("select * from brands");

                    request.setAttribute("brands", brands);

                    request.getRequestDispatcher("addProduct.jsp").forward(request, response);
                } else {
                    try {
                        String product_name = request.getParameter("product_name");
                        double price = Double.parseDouble(request.getParameter("price"));
                        if (price < 0) {
                            price = 0;
                        }
                        int quantity = Integer.parseInt(request.getParameter("quantity"));
                        if (quantity < 0) {
                            quantity = 0;
                        }
                        String description = request.getParameter("description"),
                                image_url = request.getParameter("image_url");
                        int brand_id = Integer.parseInt(request.getParameter("brand_id"));
                        String release_date = request.getParameter("release_date");
                        daoProduct.addProduct(new Product(product_name, price, quantity, description, image_url, brand_id, release_date));

                        response.sendRedirect("productManager");

                    } catch (NumberFormatException e) {

                        response.sendRedirect("productManager");
                    }
                }
            }
            if (service.equals("editProduct")) {
                String submit = request.getParameter("submit");
                if (submit == null) {
                    int productId = Integer.parseInt(request.getParameter("productId"));
                    Product product = daoProduct.getProducts("select * from products where product_id = " + productId).get(0);
                    Vector<Brand> brands = daoBrand.getBrands("select * from brands");
                    request.setAttribute("product", product);
                    request.setAttribute("brands", brands);

                    request.getRequestDispatcher("editProduct.jsp").forward(request, response);
                } else {
                    try {
                        int product_id = Integer.parseInt(request.getParameter("product_id"));
                        String product_name = request.getParameter("product_name");
                        double price = Double.parseDouble(request.getParameter("price"));
                        if (price < 0) {
                            price = 0;
                        }
                        int quantity = Integer.parseInt(request.getParameter("quantity"));
                        if (quantity < 0) {
                            quantity = 0;
                        }
                        String description = request.getParameter("description"),
                                image_url = request.getParameter("image_url");
                        if (image_url.equals("")) {
                            image_url = request.getParameter("oldImage_url");
                        }
                        int brand_id = Integer.parseInt(request.getParameter("brand_id"));
                        String release_date = request.getParameter("release_date");

                        daoProduct.updateProduct(new Product(product_id, product_name, price, quantity, description, image_url, brand_id, release_date));
                        response.sendRedirect("productManager");

                    } catch (NumberFormatException e) {
                        response.sendRedirect("productManager");
                    }
                }
            }
            if (service.equals("listProducts")) {
                String search = request.getParameter("search");
                ResultSet listProducts;
                if (search == null) {
                    listProducts = daoProduct.getData("select product_id,product_name,price,quantity,b.brand_name,release_date,image_url "
                            + "from products p join brands b on p.brand_id = b.brand_id ");

                } else {
                    listProducts = daoProduct.getData(""
                            + "select product_id,product_name,price,quantity,b.brand_name,release_date,image_url from products p "
                            + "join brands b on p.brand_id = b.brand_id "
                            + "where p.product_name like '%" + search + "%'");
                }

                request.setAttribute("listProducts", listProducts);
                request.getRequestDispatcher("productManager.jsp").forward(request, response);

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
