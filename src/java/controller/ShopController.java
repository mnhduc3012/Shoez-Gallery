/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Brand;
import entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Vector;
import model.DAOProducts;
import model.DAOBrands;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ShopController", urlPatterns = {"/shop"})
public class ShopController extends HttpServlet {

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
        
        DAOProducts daoProduct = new DAOProducts();
        DAOBrands daoBrand = new DAOBrands();
        
        String service = request.getParameter("service");
        if (service == null) {
            service = "listProducts";
        }
        if (service.equals("productDetail")) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            Product product = daoProduct.getProductById(productId);
            Brand brand = daoBrand.getBrands("select * from brands where brand_id = " + product.getBrand_id()).get(0);
            Vector<Product> relatedProducts = daoProduct.getProducts("select * from products "
                    + "where brand_id = " + product.getBrand_id() + " and product_id <> " + productId);
            
            request.setAttribute("brand", brand);
            request.setAttribute("product", product);
            request.setAttribute("relatedProducts", relatedProducts);
            request.getRequestDispatcher("productDetail.jsp").forward(request, response);
        }
        
        if (service.equals("listProducts")) {
            Vector<Brand> vectorBrand = daoBrand.getBrands("select * from brands");
            request.setAttribute("brands", vectorBrand);
            
            Vector<Product> vectorProduct;
            String search = request.getParameter("search");
            
            String sortOption = request.getParameter("sortOption");
            request.setAttribute("sortOption", sortOption);
            
            String filterBrand = request.getParameter("filterBrand");
            request.setAttribute("filterBrand", filterBrand);
            
            if (search == null) {
                vectorProduct = daoProduct.getProducts("select * from products");
            } else {
                vectorProduct = daoProduct.getProducts("select * from products where product_name like '%" + search + "%'");
            }
            
            vectorProduct = daoProduct.sortProduct(sortOption, vectorProduct);
            
            vectorProduct = daoProduct.filterByBrand(filterBrand, vectorProduct);
            
            request.setAttribute("listProducts", vectorProduct);
            
            request.getRequestDispatcher("shop.jsp").forward(request, response);
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
