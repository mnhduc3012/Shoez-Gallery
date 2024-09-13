
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.ResultSet" %>

<!DOCTYPE html>
<html lang="en">
    <%
    ResultSet rsOrderDetail = (ResultSet) request.getAttribute("rsOrderDetail");
    double total = 0;
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Detail</title>
        <%@include file="css.jsp" %>
    </head>

    <body>
        <div class="site-wrap">
            <%@include file="header.jsp" %>

            <div class="bg-light py-3">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 mb-0">
                            <a href="home">Home</a> <span class="mx-2 mb-0">/</span>
                            <c:if test="${sessionScope.account.isAdmin == 1}">
                                <a href="orderManager">Order manager</a> 
                            </c:if>
                            <c:if test="${sessionScope.account.isAdmin == 0}">
                                <a href="orderManager?service=listOrderHistory&userId=${sessionScope.account.user_id}">Order history</a> 
                            </c:if>
                            <span class="mx-2 mb-0">/</span>
                            <strong class="text-black">Order detail</strong>
                        </div>
                    </div>
                </div>
            </div>

            <div class="site-section">
                <div class="container">
                    <div class="row mb-5">
                        <div class="col-md-12">
                            <div class="site-blocks-table" style="overflow-x: hidden">
                                <table class="table table-bordered" >
                                    <p style="color: ${color}"> ${message}</p>

                                    <%rsOrderDetail.next();%>
                                    <c:if test="${sessionScope.account.isAdmin == 1}">
                                        <div class="text-black" style="font-size: large">
                                            <p>Order ID: ${rsOrderDetail.getInt(1)}</p>
                                            <p>Username: ${rsOrderDetail.getString(3)}</p>
                                            <p>Order date: ${rsOrderDetail.getString(4)}</p>
                                            <p>Order status: ${rsOrderDetail.getString(5)}</p>
                                        </div>
                                    </c:if>
                                    <table class="table table-bordered" >
                                        <thead>
                                            <tr>
                                                <th>Item ID</th>
                                                    <c:if test="${sessionScope.account.isAdmin == 1}">
                                                    <th>Product ID</th>
                                                    </c:if>
                                                <th>Image</th>
                                                <th>Product name</th>
                                                <th>Price</th>
                                                <th>Quantity</th>
                                                <th>SubTotal</th>

                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%do{%>
                                            <tr>
                                                <td>${rsOrderDetail.getInt(6)}</td>
                                                <c:if test="${sessionScope.account.isAdmin == 1}">
                                                    <td>${rsOrderDetail.getInt(7)}</td>
                                                </c:if>
                                                <td><img style="width: 50%" src="img/${rsOrderDetail.getString(8)}" /> </td>

                                                <td>${rsOrderDetail.getString(9)}</td>

                                                <td>${rsOrderDetail.getDouble(10)}$</td>

                                                <td>${rsOrderDetail.getInt(11)}</td>

                                                <td>${rsOrderDetail.getDouble(10)*rsOrderDetail.getInt(11)}$</td>
                                                <% total += rsOrderDetail.getDouble(10)*rsOrderDetail.getInt(11); %>
                                            </tr>
                                            <%}while(rsOrderDetail.next());%>
                                        </tbody>

                                    </table>
                                    <div class="row" >

                                        <div class="col-md-7">

                                            <table>
                                                <form action="orderManager" method="POST">
                                                    <input type="hidden" name="service" value="changeStatus">
                                                    <%rsOrderDetail.first();%>
                                                    <input type="hidden" name="orderId" value="${rsOrderDetail.getInt(1)}">
                                                    <tr style="font-size: large">
                                                        <td colspan="4">Change Status of this Order To:</td>
                                                
                                                        <td><button class="btn btn-danger btn-sm btn-block" type="submit" name="orderStatus" value="canceled" >Canceled</button></td>    
                                                        <c:if test="${sessionScope.account.isAdmin == 1}">
                                                        <td><button class="btn btn-secondary btn-sm btn-block" type="submit" name="orderStatus" value="process" >Process</button></td>
                                                            <td><button class="btn btn-primary btn-sm btn-block" type="submit" name="orderStatus" value="done" >Done</button></td>
                                                        </c:if>
                                                    </tr>
                                                </form>
                                            </table>

                                        </div>

                                        <div class="text-black text-right col-md-5">
                                            <h2>Grand total: <%=total%>$</h2>
                                        </div>
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
