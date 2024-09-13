<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.Enumeration,entity.Product" %>
<%@include file="css.jsp" %>

<header class="site-navbar" role="banner">
    <div class="site-navbar-top">
       
        <div class="container">
            <div class="row align-items-center">

                <div class="col-6 col-md-4 order-2 order-md-1 site-search-icon text-left">
                    <form action="shop" class="site-block-top-search">
                        <span class="icon icon-search2"></span>
                        <input type="text" name="search" class="form-control border-0" placeholder="Search">
                        <input type="hidden" name="service" value="listProducts">
                    </form>
                </div>

                <div class="col-12 mb-3 mb-md-0 col-md-4 order-1 order-md-2 text-center">
                    <div class="site-logo">
                        <a href="home" class="js-logo-clone">Shoez Gallery</a>
                    </div>
                </div>

                <div class="col-6 col-md-4 order-3 order-md-3 text-right">
                    <div class="site-top-icons">
                        <ul>
                            <c:if test="${sessionScope.account == null}">
                                <li style="font-size: large">
                                    <a href="login">
                                        <span class="icon icon-person"></span>
                                        Login
                                    </a>
                                    <a href="register">
                                        Register
                                    </a>
                                </li>
                            </c:if>
                            <c:if test="${sessionScope.account != null}">
                                <li class="dropdown">
                                    <a href="#" style="color: black" class="dropdown-toggle" data-toggle="dropdown">
                                        Welcome ${sessionScope.account.username} <span class="caret"></span>
                                    </a>
                                    <ul style="margin-left: -25px" class="dropdown-menu" >
                                        <c:if test="${sessionScope.account.isAdmin == 0}">
                                            <li style="margin-left: 25px"  ><a  href="orderManager?service=listOrderHistory&userId=${sessionScope.account.user_id}">Order history</a></li>
                                            </c:if>
                                        <li style="margin-left: 25px"  ><a  href="userManager?service=updateProfile">Update profile</a></li>

                                        <li style="margin-left: 25px"><a href="login?service=logout">Logout</a></li>
                                    </ul>
                                </li>
                                </c:if>
                                <%
                                            int numberCartProducts = 0;
                                            Enumeration map = session.getAttributeNames();
                                            
                                            while (map.hasMoreElements()) {
                                                String key = (String) map.nextElement();
                                                Product pro;
                                                if (!key.equals("account") && !key.equals("numberCartProducts")) {
                                                    pro = (Product) session.getAttribute(key);
                                                    numberCartProducts += pro.getQuantity();
                                                }
                                                
                                            } 
                                            session.setAttribute("numberCartProducts",numberCartProducts);
                                %>
                                <c:if test="${sessionScope.account.isAdmin != 1}">
                                    <li>
                                        <a href="cart" class="site-cart">
                                            <span class="icon icon-shopping_cart"></span>
                                            <span class="count">${sessionScope.numberCartProducts}</span>
                                        </a>
                                    </li> 
                                </c:if>
                            
                            <li class="d-inline-block d-md-none ml-md-0"><a href="#" class="site-menu-toggle js-menu-toggle"><span class="icon-menu"></span></a></li>
                        </ul>
                    </div> 
                </div>

            </div>
        </div>
    </div> 
    <nav class="site-navigation text-right text-md-center" role="navigation">
        <div class="container">
            <ul class="site-menu js-clone-nav d-none d-md-block">
                <li>
                    <a href="home">Home</a>

                </li>
                <li >
                    <a href="shop">Shop</a>

                </li>
                <c:if test="${sessionScope.account.isAdmin == 1}">
                    <li class="has-children">
                        <a href="#">Admin Panel</a>
                        <ul class="dropdown">
                            <li><a href="dashboard">Dashboard</a></li>
                            <li><a href="userManager">User Manager</a></li>
                            <li><a href="productManager">Product Manager</a></li>
                            <li><a href="brandManager">Brand Manager</a></li>
                            <li><a href="orderManager">Order Manager</a></li>
                        </ul>
                    </li>
                </c:if>
            </ul>
        </div>
    </nav>
</header>
