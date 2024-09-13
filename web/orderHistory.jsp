
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.ResultSet" %>

<!DOCTYPE html>
<html lang="en">
    <%
     ResultSet rsOrderHistory = (ResultSet) request.getAttribute("rsOrderHistory");
     ResultSet rsSummary = (ResultSet) request.getAttribute("rsSummary");
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order History</title>
        <%@include file="css.jsp" %>
    </head>

    <body>
        <div class="site-wrap">
            <%@include file="header.jsp" %>

            <div class="bg-light py-3">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 mb-0"><a href="home">Home</a> <span class="mx-2 mb-0">/</span> <strong
                                class="text-black">Order history</strong></div>
                    </div>
                </div>
            </div>

            <div class="site-section">
                <div class="container">
                    <div class="row" style="margin-bottom: 100px">
                        <%rsSummary.next();%>
                        <div class="col-md-6 col-lg-4 mb-4 mb-lg-0">
                            <div class="border p-4 text-center">
                                <span class="flaticon-box display-3 text-primary mb-3 d-block"></span>
                                <h3 class="mb-0 text-primary font-weight-bold">${rsSummary.getInt(1)}</h3>
                                <p class="mb-0">Total Orders Placed</p>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-4 mb-4 mb-lg-0">
                            <div class="border p-4 text-center">
                                <span class="flaticon-users display-3 text-primary mb-3 d-block"></span>
                                <h3 class="mb-0 text-primary font-weight-bold">${rsSummary.getInt(2)}</h3>
                                <p class="mb-0">Total Products Ordered</p>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-4 mb-4 mb-lg-0">
                            <div class="border p-4 text-center">
                                <span class="flaticon-wallet display-3 text-primary mb-3 d-block"></span>
                                <h3 class="mb-0 text-primary font-weight-bold">$${rsSummary.getDouble(3)}</h3>
                                <p class="mb-0">Total Amount Spent</p>
                            </div>
                        </div>

                    </div>



                    <div class="row mb-5" >
                        <div class="col-md-12">
                            <div class="site-blocks-table" style="overflow-x: hidden">

                                <table class="table table-bordered" >

                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Order date</th>
                                            <th>Total quantity</th>
                                            <th>Total price</th>
                                            <th>Status</th>
                                            <th>Show detail</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%int index = 1;%>
                                        <%while(rsOrderHistory.next()){%>
                                        <tr>

                                            <td><%=index++%></td>

                                            <td>${rsOrderHistory.getString(2)}</td>

                                            <td>${rsOrderHistory.getInt(3)}</td>
                                           
                                            <td>${rsOrderHistory.getDouble(4)}</td>
                                         
                                            <td>${rsOrderHistory.getString(5)}</td>
                                            <td>
                                                <a href="orderManager?service=showDetail&orderId=${rsOrderHistory.getInt(1)}" class="btn btn-primary btn-sm">
                                                    <span class="icon icon-arrow-right"></span>
                                                </a>
                                            </td>
                                        </tr>
                                        <%}%>
                           
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>


                </div>
                <%@include file="footer.jsp" %>
            </div>

            <%@include file="script.jsp" %>
    </body>
</html>
