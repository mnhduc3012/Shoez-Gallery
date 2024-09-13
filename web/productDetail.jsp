<%-- 
    Document   : productDetail
    Created on : Jun 10, 2024, 12:54:23 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Detail</title>
        <%@include file="css.jsp" %>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="bg-light py-3">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 mb-0"><a href="home">Home</a> <span class="mx-2 mb-0">/</span><a href="shop">Shop</a> <span class="mx-2 mb-0">/</span><strong class="text-black">${product.product_name}</strong></div>
                </div>
            </div>
        </div>  

        <div class="site-section">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <img src="img/${product.image_url}" alt="Image" class="img-fluid">
                    </div>
                    <div class="col-md-6">
                        <h2 class="text-black">${product.product_name}</h2>
                        <p>${product.description}</p>

                        <p>
                            Brand: ${brand.brand_name} 
                            <br>
                            Release date: ${product.release_date}
                        </p>
                        <hr>
                        <p><strong class="text-primary h4">$${product.price}</strong></p>
                        <c:if test="${sessionScope.account.isAdmin != 1}">
                            <c:if test="${product.quantity > 0}">
                                <form method="post" action="cart">
                                    <p style="color: red">${message}</p>
                                    <div class="mb-5">
                                        <div class="input-group mb-3" style="max-width: 120px;">
                                            <div class="input-group-prepend">
                                                <button class="btn btn-outline-primary js-btn-minus" type="button">&minus;</button>
                                            </div>
                                            <input type="text" name="quantity" class="form-control text-center" value="1" placeholder="1" aria-label="Example text with button addon" aria-describedby="button-addon1">
                                            <div class="input-group-append">
                                                <button class="btn btn-outline-primary js-btn-plus" type="button">&plus;</button>
                                            </div>
                                        </div>
                                    </div>

                                    <input type="hidden" name="pid" value="${product.product_id}">
                                    <input type="hidden" name="service" value="addToCart">
                                    <button class="buy-now btn btn-sm btn-primary" type="submit">Add To Cart</button>


                                </form>
                            </c:if>

                            <c:if test="${product.quantity == 0}">
                                <button class="buy-now btn btn-sm btn-danger" >Sold Out</button>
                            </c:if>
                        </c:if>
                        
                        <p style="padding-bottom: 50px"></p>
                    </div>

                </div>
            </div>
            <div class="site-section block-3 site-blocks-2 bg-light">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-md-7 site-section-heading text-center pt-4">
                            <h2>RELATED PRODUCTS</h2>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="nonloop-block-3 owl-carousel">


                                <c:forEach items="${relatedProducts}" var="o">
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
