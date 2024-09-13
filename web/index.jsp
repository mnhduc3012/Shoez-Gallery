<%-- 
    Document   : index.jsp
    Created on : Jun 9, 2024, 11:05:51 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector,entity.Product" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
        <%@include file="css.jsp" %>

    </head>
    <body>

        <div class="site-wrap">
            <%@include file="header.jsp" %>

            <div class="site-blocks-cover" style="background-image: url(img/banner.png);" data-aos="fade">
                <div class="container">
                    <div class="row align-items-start align-items-md-center ">
                        <div class="col-md-5 text-center text-md-left pt-5 pt-md-0">
                            <h1 class="mb-2">Finding Your Perfect Shoes</h1>
                            <div class="intro-text text-center text-md-left">
                                <p>
                                    <a href="shop" class="btn btn-sm btn-primary">Shop Now</a>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>




            <div class="site-section block-3 site-blocks-2 bg-light">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-md-7 site-section-heading text-center pt-4">
                            <h2>NEW ARRIVALS</h2>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="nonloop-block-3 owl-carousel">

                                
                                <c:forEach items="${newProducts}" var="o">
                                    <div class="item">
                                        <div class="block-4 text-center " style="height: 320px; align-content: flex-end">
                                            <figure class="block-4-image">
                                                <a href="shop?service=productDetail&productId=${o.product_id}"><img style="max-height: 190px" src="img/${o.image_url}"  alt="Image placeholder" class="img-fluid "></a>
                                            </figure>
                                            <div class="block-4-text p-4">
                                                <h3><a href="shop?service=productDetail&productId=${o.product_id}">${o.product_name}</a></h3>

                                                <p class="text-primary font-weight-bold">$${o.price}</p>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

            <div class="site-section block-3 site-blocks-2 bg-light">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-md-7 site-section-heading text-center pt-4">
                            <h2>BEST SELLERS</h2>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="nonloop-block-3 owl-carousel">

                                
                                <c:forEach items="${bestSellerProducts}" var="o">
                                    <div class="item">
                                        <div class="block-4 text-center " style="height: 320px; align-content: flex-end">
                                            <figure class="block-4-image">
                                                <a href="shop?service=productDetail&productId=${o.product_id}"><img style="max-height: 190px" src="img/${o.image_url}"  alt="Image placeholder" class="img-fluid "></a>
                                            </figure>
                                            <div class="block-4-text p-4"style="align-content: end">
                                                <h3><a href="shop?service=productDetail&productId=${o.product_id}">${o.product_name}</a></h3>

                                                <p class="text-primary font-weight-bold">$${o.price}</p>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
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
