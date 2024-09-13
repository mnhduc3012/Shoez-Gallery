<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Product</title>
        <%@include file="css.jsp" %>
    </head>

    <body>
        <div class="site-wrap">
            <%@include file="header.jsp" %>

            <div class="bg-light py-3">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 mb-0"><a href="home">Home</a> <span class="mx-2 mb-0">/</span> <a href="productManager">Product manager</a> <span class="mx-2 mb-0">/</span><strong
                                class="text-black">Edit product</strong></div>
                    </div>
                </div>
            </div>

            <div class="site-section">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <h2 class="h3 mb-3 text-black">Product information</h2>
                        </div>
                        
                        <div class="col-md-7">
                            <form action="productManager" method="post">
                                <div class="p-3 border">
                                    <div class="form-group row">
                                        <div class="col-md-12">
                                            <label for="" class="text-black">
                                                Product ID <span class="text-danger">*</span>
                                            </label>
                                            <input name="product_id" type="text" class="form-control"
                                                   id="" value="${product.product_id}" readonly>
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <div class="col-md-12">
                                            <label for="" class="text-black">
                                                Name <span class="text-danger">*</span>
                                            </label>

                                            <input name="product_name" type="text" class="form-control"
                                                   id="" value="${product.product_name}">
                                        </div>
                                    </div>



                                    <div class="form-group row">
                                        <div class="col-md-12">
                                            <label for="" class="text-black">
                                                Price <span class="text-danger">*</span>
                                            </label>

                                            <input name="price" type="number" step="0.1" class="form-control"
                                                   id="" value="${product.price}">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-md-12">
                                            <label for="" class="text-black">
                                                Quantity <span class="text-danger"></span>
                                            </label>

                                            <input name="quantity" type="number" class="form-control"
                                                   id="" value="${product.quantity}">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-md-12">
                                            <label for="" class="text-black">
                                                Description 
                                            </label>
                                            <textarea name="description" id=""
                                                      cols="30" rows="7"
                                                      class="form-control">${product.description}</textarea>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-md-12">
                                            <label for="" class="text-black">
                                                Image <span class="text-danger"></span>
                                            </label>

                                            <input name="image_url" type="file" id="" class="form-control">
                                            <input type="hidden" name="oldImage_url"  value="${product.image_url}" >
                                        </div>
                                    </div>



                                    <div class="form-group row">
                                        <div class="col-md-12">
                                            <label for="" class="text-black">
                                                Brand <span class="text-danger"></span>
                                            </label>

                                            <select name="brand_id" id=""
                                                    class="form-control">
                                                <c:forEach items="${brands}" var="o">
                                                    <option  value="${o.brand_id}" <c:if test="${product.brand_id eq o.brand_id}">selected</c:if> >${o.brand_name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-md-12">
                                            <label for="" class="text-black">
                                                Release date <span class="text-danger"></span>
                                            </label>

                                            <input name="release_date" type="text" class="form-control"
                                                   id="" value="${product.release_date}">
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <div class="col-lg-6">
                                            <input type="reset" class="btn btn-primary btn-lg btn-block" value="Reset">

                                        </div>
                                        <div class="col-lg-6">
                                            <input type="submit" name="submit" class="btn btn-primary btn-lg btn-block" value="Edit">
                                            <input type="hidden" name="service" value="editProduct">
                                        </div>
                                    </div>


                                </div>

                            </form>
                        </div>

                        <div class="col-md-5 ml-auto">
                            <div class="p-3 border">
                                <img src="img/${product.image_url}" alt="image" width="100%">
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