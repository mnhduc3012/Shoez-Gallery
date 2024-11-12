<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Brand</title>
        <%@include file="css.jsp" %>
    </head>

    <body>
        <div class="site-wrap">
            <%@include file="header.jsp" %>

            <div class="bg-light py-3">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 mb-0"><a href="/">Home</a> <span class="mx-2 mb-0">/</span> <a href="brandManager">Brand manager</a> <span class="mx-2 mb-0">/</span><strong
                                class="text-black">Edit brand</strong></div>
                    </div>
                </div>
            </div>

            <div class="site-section">
                <div class="container" style="width: 60%">
                    <div class="row">
                        <div class="col-md-12">
                            <h2 class="h3 mb-3 text-black">Brand information</h2>
                        </div>

                        <div class="col-md-12">
                            <form action="brandManager" method="post">
                                <div class="p-3 border">
                                    
                                    <div class="form-group row">
                                        <div class="col-md-12">
                                            <label for="" class="text-black">
                                                Brand ID <span class="text-danger">*</span>
                                            </label>

                                            <input name="brand_id" readonly="" value="${brand.brand_id}" type="text"  class="form-control"
                                                   id="" >
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-md-12">
                                            <label for="" class="text-black">
                                                Brand name <span class="text-danger">*</span>
                                            </label>

                                            <input name="brand_name" value="${brand.brand_name}" type="text"  class="form-control"
                                                   id="" >
                                        </div>
                                    </div>


                                    <div class="form-group row">
                                        <div class="col-lg-6">
                                            <input type="reset" class="btn btn-primary btn-lg btn-block" value="Reset">

                                        </div>
                                        <div class="col-lg-6">
                                            <input type="submit" name="submit" class="btn btn-primary btn-lg btn-block" value="Edit">
                                            <input type="hidden" name="service" value="editBrand">
                                        </div>
                                    </div>


                                </div>

                            </form>
                        </div>


                    </div>
                </div>
            </div>

            <%@include file="footer.jsp" %>
        </div>


        <%@include file="script.jsp" %>
    </body>
</html>