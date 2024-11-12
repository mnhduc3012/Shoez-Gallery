
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Brand Manager</title>
        <%@include file="css.jsp" %>
    </head>

    <body>
        <div class="site-wrap">
            <%@include file="header.jsp" %>

            <div class="bg-light py-3">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 mb-0"><a href="home">Home</a> <span class="mx-2 mb-0">/</span> <strong
                                class="text-black">Brand manager</strong></div>
                    </div>
                </div>
            </div>

            <div class="site-section">
                <div class="container">
                    <div class=" order-2 order-md-1 site-search-icon text-left ">
                        <form action="brandManager" class="site-block-top-search">
                            <span class="icon icon-search2"></span>
                            <input type="text" name="search" class="form-control border-0" placeholder="Search by Name">
                            <input type="hidden" name="service" value="listBrands">
                        </form>                      
                    </div>          
                    <p><a href="brandManager"><h5>All Brands</h5></a></p>
                    <div class="row mb-5">
                        <div class="col-md-12">
                            <div class="site-blocks-table">
                                <table class="table table-bordered" >
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Brand name</th>
                                            <th style="min-width: 195px">Edit / Remove</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${listBrands}" var="o">
                                            <tr>

                                                <td>${o.brand_id}</td>

                                                <td>${o.brand_name}</td>

                                                <td>
                                                    <a href="brandManager?service=editBrand&brandId=${o.brand_id}" class="btn btn-primary btn-sm"
                                                       style="background-color: green ; border-color: green">
                                                        <span class="icon icon-pencil-square-o"></span>
                                                    </a>

                                                    <a href="brandManager?service=deleteBrand&brandId=${o.brand_id}"
                                                       class="btn btn-primary btn-sm "
                                                       style="background-color: red ; border-color: red">
                                                        <span class="icon icon-trash"></span>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="row mb-5">
                                <div class="col-md-6">
                                    <a class="btn btn-primary btn-lg btn-block" style="color: white" href="brandManager?service=addBrand"> Add brand</a></button
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
