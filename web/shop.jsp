<%-- 
    Document   : shop.jsp
    Created on : Jun 9, 2024, 11:34:31 AM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shop</title>
        <%@include file="css.jsp" %>

    </head>
    <body>
        <div class="site-wrap">

            <%@include file="header.jsp" %>
            <div class="bg-light py-3">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 mb-0"><a href="home">Home</a> <span class="mx-2 mb-0">/</span> <strong class="text-black">Shop</strong></div>
                    </div>
                </div>
            </div>

            <div class="site-section">
                <div class="container">

                    <div class="row mb-5">
                        <div class="col-md-9 order-2">

                            <div class="row">
                                <div class="col-md-12 mb-5">
                                    <div class="float-md-left mb-4"><h2 class="text-black h5"><a href="shop">Shop All</a> </h2></div>
                                    <div class="d-flex">
                                        <div class="dropdown mr-1 ml-md-auto">

                                        </div>
                                        <div class="btn-group">
                                            <select id="sortOptions" class="form-control form-control-sm bg-light" name="sortOption" onchange="sortProduct(this.value)">
                                                <option value="" selected="">Sort By ...</option>
                                                <option value="latest"  <c:if test="${sortOption == 'latest'}">selected</c:if> >Latest</option>
                                                <option value="name-asc"  <c:if test="${sortOption == 'name-asc'}">selected</c:if> >Name, A to Z</option>
                                                <option value="name-desc" <c:if test="${sortOption == 'name-desc'}">selected</c:if>>Name, Z to A</option>
                                                <option value="price-asc" <c:if test="${sortOption == 'price-asc'}">selected</c:if> >Price, low to high</option>
                                                <option value="price-desc"<c:if test="${sortOption == 'price-desc'}">selected</c:if>> Price, high to low</option>
                                                </select>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row mb-5">
                                <c:forEach items="${listProducts}" var="product">
                                    <div class="col-sm-6 col-lg-4 mb-4" data-aos="fade-up" >
                                        <div class="block-4 text-center border" style="height: 320px; align-content: flex-end" >
                                            <figure class="block-4-image">
                                                <a href="shop?service=productDetail&productId=${product.product_id}"><img src="img/${product.image_url}" alt="placeholder" class="img-fluid"></a>
                                            </figure>
                                            <div class="block-4-text p-4" style="align-content: end">
                                                <h3><a href="shop?service=productDetail&productId=${product.product_id}">${product.product_name}</a></h3>
                                                <p class="text-primary font-weight-bold">$${product.price}</p>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>

                            </div>

                        </div>

                        <div class="col-md-3 order-1 mb-5 mb-md-0">

                            <div class="border p-4 rounded mb-4">
                                <h3 class="mb-3 h6 text-uppercase text-black d-block">Brands</h3>
                                <ul class="list-unstyled mb-0">
                                    <li class="mb-1">
                                        <button value="" class="btn btn-sm btn-light text-left" onclick="filterByBrand(this.value)"
                                                style="
                                                width:100%;
                                                <c:if test="${filterBrand eq ''}">background-color: #5A50E5;color: white</c:if>
                                                <c:if test="${filterBrand eq null}">background-color: #5A50E5;color: white</c:if>
                                                <c:if test="${filterBrand eq 'brand-all'}">background-color: #5A50E5;color: white</c:if>" 
                                                    ><span>All</span>
                                                </button>
                                        </li>
                                    <c:forEach items="${brands}" var="brand"> 
                                        <li class="mb-1">
                                            <button value="${brand.brand_id}" class="btn btn-sm btn-light text-left" onclick="filterByBrand(this.value)"
                                                    style="width:100%;  <c:if test="${brand.brand_id eq filterBrand}">background-color: #5A50E5;color: white</c:if>"
                                                    ><span>${brand.brand_name}</span>
                                            </button>
                                        </li>
                                    </c:forEach>


                                </ul>
                            </div>


<!--                            <div class="border p-4 rounded mb-4">
                                <div class="mb-4">

                                    <h3 class="mb-3 h6 text-uppercase text-black d-block">Filter by Price</h3>

                                    <input type="number" step="0.1" name="minPrice" id="min-price" class="form-control border-0 pl-0 bg-white mb-2" placeholder="Min Price" />
                                    <input type="number" step="0.1" name="maxPrice" id="max-price" class="form-control border-0 pl-0 bg-white mb-2" placeholder="Max Price" />                       

                                    <button type="submit" onclick="filterByPrice(0,1000)" class="btn btn-primary btn-sm btn-block" style="width: fit-content">Filter</button>

                                </div>
                            </div>-->

                        </div>
                    </div>



                </div>
            </div>

            <%@include file="footer.jsp" %>
        </div>
        <script>
            function sortProduct(option) {
                const urlParams = new URLSearchParams(window.location.search);
                let service = urlParams.get('service');
                let search = urlParams.get('search');
                let filterBrand = urlParams.get('filterBrand');
                
                if (service === null) {
                    service = "listProducts";
                }
                if (search === null) {
                    search = "";
                }
                if (filterBrand === null) {
                    filterBrand = "";
                }
                

                window.location.href = "shop?service=" + service + "&search=" + search + "&sortOption=" + option + "&filterBrand=" + filterBrand ;
            }

            function filterByBrand(id) {
                const urlParams = new URLSearchParams(window.location.search);
                let service = urlParams.get('service');
                let search = urlParams.get('search');
                let sortOption = urlParams.get('sortOption');
                

                if (service === null) {
                    service = "listProducts";
                }
                if (search === null) {
                    search = "";
                }
                

                window.location.href = "shop?service=" + service + "&search=" + search + "&sortOption=" + sortOption + "&filterBrand=" + id ;
            }

            
        </script>
        <%@include file="script.jsp" %>

    </body>
</html>
