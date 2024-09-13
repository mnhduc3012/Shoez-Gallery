<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
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
                            <strong class="text-black">Profile</strong></div>
                    </div>
                </div>
            </div>

            <div class="site-section">
                <div class="container">
                    <form class="row" action="userManager" method="post" >
                        <div class="col-md-2">

                        </div>

                        <div class="col-md-8 mb-5 mb-md-0">
                            <h2 class="h3 mb-3 text-black">Profile Information</h2>

                            <div class="p-3 p-lg-5 border">
                                <p><h5 style="color: ${color};">${message}</h5></p>
                                <div class="form-group row">
                                    <div class="col-md-6">
                                        <label for="username" class="text-black">
                                            Username <span class="text-danger">*</span>
                                        </label>

                                        <input type="text" class="form-control" id="username" name="username"
                                               value="${user.username}" readonly="">
                                    </div>

                                    <div class="col-md-6">
                                        <label for="password" class="text-black">
                                            Password <span class="text-danger">*</span>
                                        </label>

                                        <input type="text" class="form-control" id="password" name="password"
                                               value="${user.password}">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <div class="col-md-12">
                                        <label for="fullname" class="text-black">
                                            Fullname 
                                        </label>

                                        <input type="text" class="form-control" id="fullname" name="fullname"
                                               value="${user.fullname}">
                                    </div>
                                </div>

                                <div class="form-group row mb-5">
                                    <div class="col-md-6">
                                        <label for="email" class="text-black">
                                            Email <span class="text-danger">*</span>
                                        </label>

                                        <input type="email" class="form-control" id="email" name="email"
                                               value="${user.email}">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="phone" class="text-black">
                                            Phone <span class="text-danger">*</span>
                                        </label>

                                        <input type="text" class="form-control" id="phone" name="phone"
                                               value="${user.phone}">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-md-12">
                                        <label for="address" class="text-black">
                                            Address 
                                        </label>

                                        <input type="text" class="form-control" id="address" name="address"
                                               value="${user.address}">
                                    </div>
                                </div>



                                <div class="form-group">
                                    <input type="submit" name="submit" class="btn btn-primary btn-lg btn-block" value="Update Profile">
                                    <input type="hidden" name="user_id" value="${user.user_id}">
                                    <input type="hidden" name="service" value="updateProfile">
                                </div>


                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <%@include file="footer.jsp" %>
        </div>



        <%@include file="script.jsp" %>
    </body>
</html>