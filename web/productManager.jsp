
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.ResultSet" %>

<!DOCTYPE html>
<html lang="en">
    <%
     ResultSet listProducts = (ResultSet) request.getAttribute("listProducts");
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Manager</title>
        <%@include file="css.jsp" %>
    </head>

    <body>
        <div class="site-wrap">
            <%@include file="header.jsp" %>

            <div class="bg-light py-3">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 mb-0"><a href="home">Home</a> <span class="mx-2 mb-0">/</span> <strong
                                class="text-black">Product manager</strong></div>
                    </div>
                </div>
            </div>

            <div class="site-section">
                <div class="container">
                    <p><h5 style="color: ${color};">${message}</h5></p>
                    <div class=" order-2 order-md-1 site-search-icon text-left ">    
                        <form action="productManager" class="site-block-top-search">
                            <span class="icon icon-search2"></span>
                            <input type="text" name="search" class="form-control border-0" placeholder="Search by Name">
                            <input type="hidden" name="service" value="listProducts">
                        </form>                      
                    </div>          
                    <p><a href="productManager"><h5>All Products</h5></a></p>
                    <div class="row mb-5">
                        <div class="col-md-12">
                            <div class="site-blocks-table">
                                <table class="table table-bordered" >
                                    <thead>
                                        <tr>
                                            <th>Image</th>
                                            <th>ID</th>
                                            <th style="max-width: 120px">Product name</th>
                                            <th>Price</th>
                                            <th>Quantity</th>
                                            <th>Brand</th>
                                            <th>Release date</th>
                                            <th style="min-width: 195px">Edit / Remove</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%while(listProducts.next()){%>
                                        <tr>
                                            <td class="product-thumbnail">
                                                <img src="img/${listProducts.getString(7)}" alt="Image" class="img-fluid">
                                            </td>

                                            <td>${listProducts.getInt(1)}</td>

                                            <td>${listProducts.getString(2)}</td>

                                            <td>${listProducts.getDouble(3)}</td>

                                            <td>${listProducts.getInt(4)}</td>

                                            <td>${listProducts.getString(5)}</td>

                                            <td>${listProducts.getString(6)}</td>


                                            <td>
                                                <a href="productManager?service=editProduct&productId=${listProducts.getInt(1)}" class="btn btn-primary btn-sm"
                                                   style="background-color: green ; border-color: green">
                                                    <span class="icon icon-pencil-square-o"></span>
                                                </a>

                                                <a href="productManager?service=deleteProduct&productId=${listProducts.getInt(1)}"
                                                   class="btn btn-primary btn-sm "
                                                   style="background-color: red ; border-color: red">
                                                    <span class="icon icon-trash"></span>
                                                </a>
                                            </td>
                                        </tr>
                                        <%}%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="row mb-5">
                                <div class="col-md-6">
                                    <a class="btn btn-primary btn-lg btn-block" style="color: white" href="productManager?service=addProduct"> Add product</a></button
                                </div>   
                            </div>
                        </div>
                    </div>
                </div>
                <%@include file="footer.jsp" %>
            </div>

            <%@include file="script.jsp" %>
    </body>
</html>
