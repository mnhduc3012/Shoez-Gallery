
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.ResultSet" %>

<!DOCTYPE html>
<html lang="en">
    <%
    ResultSet rsOrder = (ResultSet) request.getAttribute("rsOrder");
    ResultSet rsStatus = (ResultSet) request.getAttribute("rsStatus");
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Manager</title>
        <%@include file="css.jsp" %>
    </head>

    <body>
        <div class="site-wrap">
            <%@include file="header.jsp" %>

            <div class="bg-light py-3">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 mb-0"><a href="home">Home</a> <span class="mx-2 mb-0">/</span> <strong
                                class="text-black">Order manager</strong></div>
                    </div>
                </div>
            </div>

            <div class="site-section">
                <div class="container">
                    
                    <div class="border p-4 rounded mb-4 col-md-3 ">
                        <h3 class="mb-3 h6 text-uppercase text-black d-block">Filter by Status</h3>
                        <select id="statusFilter" class="form-control text-capitalize" onchange="window.location.href = this.value;">
                            <option value="orderManager" ${status eq null ? 'selected' : ''}>All</option>
                            <%while(rsStatus.next()){%>
                            <option  value="orderManager?status=${rsStatus.getString(1)}" 
                                    ${rsStatus.getString(1) eq status ? 'selected' : ''}>
                                ${rsStatus.getString(1)}
                            </option>
                            <%}%>
                        </select>
                    </div>

                    <div class="row mb-5" >
                        <div class="col-md-12">
                            <div class="site-blocks-table" style="overflow-x: hidden">

                                <table class="table table-bordered" >

                                    <thead>
                                        <tr>

                                            <th>Order ID</th>
                                            <th>Username</th>
                                            <th>Email</th>
                                            <th>Phone</th>
                                            <th>Address</th>
                                            <th>Order date</th>
                                            <th>Total</th>
                                            <th>Status</th>
                                            <th>Show detail</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%while(rsOrder.next()){%>
                                        <tr>


                                            <td>${rsOrder.getInt(1)}</td>

                                            <td>${rsOrder.getString(3)}</td>

                                            <td>${rsOrder.getString(4)}</td>

                                            <td>${rsOrder.getString(5)}</td>

                                            <td>${rsOrder.getString(6)}</td>

                                            <td>${rsOrder.getString(7)}</td>

                                            <td>${rsOrder.getDouble(8)}</td>

                                            <td>${rsOrder.getString(9)}</td>


                                            <td>
                                                <a href="orderManager?service=showDetail&orderId=${rsOrder.getInt(1)}" class="btn btn-primary btn-sm">
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
