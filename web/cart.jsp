<%-- 
    Document   : cart.jsp
    Created on : Jun 10, 2024, 11:42:50 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Enumeration,entity.Product" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="css.jsp" %>
    </head>
    <body>
        <div class="site-wrap">
            <%@include file="header.jsp" %>

            <div class="bg-light py-3">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 mb-0"><a href="home">Home</a> <span class="mx-2 mb-0">/</span> <strong class="text-black">Cart</strong></div>
                    </div>
                </div>
            </div>

            <div class="site-section">
                <div class="container">
                    <c:if test="${sessionScope.numberCartProducts != 0}">
                        <p style="color: red">${message}</p>
                        <div class="row mb-5">
                            <form class="col-md-12" method="post" action="cart">
                                <div class="site-blocks-table">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th class="product-thumbnail">Image</th>
                                                <th class="product-name">Product</th>
                                                <th class="product-price">Price</th>
                                                <th class="product-quantity">Quantity</th>
                                                <th class="product-total">Total</th>
                                                <th class="product-remove">Remove</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                double total = 0;
                                                Enumeration enu = session.getAttributeNames();
                                            
                                                while (enu.hasMoreElements()) {
                                                    String pid = (String) enu.nextElement();
                                                    Product product = null;
                                                    if (!pid.equals("account") && !pid.equals("numberCartProducts")) {
                                                        product = (Product) session.getAttribute(pid);
                                                    }
                                                
                                                    if(product!=null){
                                            %>

                                            <tr>
                                                <td class="product-thumbnail">
                                                    <img src="img/<%=product.getImage_url()%>" alt="Image" class="img-fluid">
                                                </td>
                                                <td class="product-name">
                                                    <h2 class="h5 text-black"><%=product.getProduct_name()%></h2>
                                                </td>
                                                <td>$<%=product.getPrice()%></td>
                                                <td style="max-width: 150px">
                                                    <div class="input-group mb-3">
                                                        <div class="input-group-prepend">
                                                            <button class="btn btn-outline-primary js-btn-minus" type="button">&minus;</button>
                                                        </div>
                                                        
                                                        <input type="text" name="quantity<%=product.getProduct_id()%>" class="form-control text-center" value="<%=product.getQuantity()%>" placeholder="" aria-label="Example text with button addon" aria-describedby="button-addon1">
                                                        
                                                        
                                                        <div class="input-group-append">
                                                            <button class="btn btn-outline-primary js-btn-plus" type="button">&plus;</button>
                                                        </div>
                                                    </div>

                                                </td>
                                                <td>$<%=product.getPrice()*product.getQuantity()%></td>
                                                <%total+=product.getPrice()*product.getQuantity();%>
                                                <td><a href="cart?service=remove&pid=<%=product.getProduct_id()%>" class="btn btn-primary btn-sm">X</a></td>
                                            </tr>

                                            <%}}%>
                                        </tbody>
                                    </table>
                                </div>

                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="row mb-5">
                                    <div class="col-md-6 mb-3 mb-md-0">
                                        <input type="hidden" name="service" value="updateCart">
                                        <button class="btn btn-primary btn-sm btn-block">Update Cart</button>
                                    </div>
                                    </form>
                                    <div class="col-md-6 mb-3 mb-md-0">                                       
                                        <a class="btn btn-primary btn-sm btn-block" href="cart?service=removeAll">Remove All</a>
                                    </div>
                                    
                                </div>
                                <div >
                                    <a href="shop" class="btn btn-outline-primary btn-sm btn-block">Continue Shopping</a>
                                </div>
                            </div>
                            <div class="col-md-6 pl-5">
                                <div class="row justify-content-end">
                                    <div class="col-md-7">
                                        <div class="row">
                                            <div class="col-md-12 text-right border-bottom mb-5">
                                                <h3 class="text-black h4 text-uppercase">Cart Totals</h3>
                                            </div>
                                        </div>

                                        <div class="row mb-5" style="font-size: larger">
                                            <div class="col-md-6">
                                                <span class="text-black">Total</span>
                                            </div>
                                            <div class="col-md-6 text-right">
                                                <strong class="text-black">$<%=total%></strong>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-12">
                                                <a href="cart?service=checkout" class="btn btn-primary btn-lg py-3 btn-block" ">Proceed To Checkout</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </c:if>
                    <c:if test="${sessionScope.numberCartProducts == 0}">
                        <div class="col-md-12 text-center">
                            <span class="icon-shopping-cart display-3 text-secondary mb-4">
                                <i class="fas fa-shopping-cart"></i>
                            </span>
                            <h2 class="display-3 text-black">Your Cart is Empty</h2>
                            <p class="lead mb-5">Looks like you haven't added any products to your cart yet.</p>
                            <p><a href="shop" class="btn btn-lg btn-primary ">Shop Now</a></p>
                        </div>
                    </c:if>
                </div>
            </div>

            <%@include file="footer.jsp" %>
        </div>
        <%@include file="script.jsp" %>
    </body>
</html>
