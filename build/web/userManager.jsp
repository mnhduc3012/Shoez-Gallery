
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Manager</title>
        <%@include file="css.jsp" %>
    </head>

    <body>
        <div class="site-wrap">
            <%@include file="header.jsp" %>

            <div class="bg-light py-3">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 mb-0"><a href="home">Home</a> <span class="mx-2 mb-0">/</span> <strong
                                class="text-black">User manager</strong></div>
                    </div>
                </div>
            </div>
            <p style="color: red">${message}</p>
            <div class="site-section">
                <div class="container">
                    <div class=" order-2 order-md-1 site-search-icon text-left ">
                        <form action="userManager" class="site-block-top-search">
                            <span class="icon icon-search2"></span>
                            <input type="text" name="search" class="form-control border-0" placeholder="Search by Username">
                            <input type="hidden" name="service" value="listUsers">
                        </form>                      
                    </div>          
                    <p><a href="userManager"><h5>All User</h5></a></p>
                    <div class="row mb-5">
                        <div class="col-md-12">
                            <div class="site-blocks-table">
                                <table class="table table-bordered" >
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Username</th>
                                            <th >Fullname</th>
                                            <th>Email</th>
                                            <th>Phone</th>
                                            <th>Address</th>
                                            <th>isAdmin</th>
                                            <th>isBanned</th>
                                            <th>Ban/Unban</th>
                                            <th style="min-width: 200px">Make admin/</br>Remove admin</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${listUsers}" var="o">
                                            <tr>


                                                <td>${o.user_id}</td>

                                                <td>${o.username}</td>

                                                <td>${o.fullname}</td>

                                                <td>${o.email}</td>

                                                <td>${o.phone}</td>

                                                <td>${o.address}</td>

                                                <td><c:if test="${o.isAdmin == 1}"><h5>X</h5></c:if></td>
                                                <td><c:if test="${o.isBanned == 1}"><h5>X</h5></c:if></td>


                                                    <td>
                                                        <a class="btn btn-sm btn-primary" style="background: red " href="userManager?service=banUser&userId=${o.user_id}">
                                                        <span class="icon icon-ban"></span>
                                                    </a>
                                                </td>
                                                <td>
                                                    <a class="btn btn-sm btn-primary" href="userManager?service=makeAdmin&userId=${o.user_id}">                                                  
                                                        <span class="icon icon-key"></span>                                                      
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
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
