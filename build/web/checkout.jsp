<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Check out</title>
        <%@include file="css.jsp" %>
    </head
    <body>

        <div class="site-wrap">
            <%@include file="header.jsp" %>

            <div class="bg-light py-3">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 mb-0"><a href="index.html">Home</a> <span class="mx-2 mb-0">/</span> <a href="cart">Cart</a> <span class="mx-2 mb-0">/</span> <strong class="text-black">Checkout</strong></div>
                    </div>
                </div>
            </div>

            <div class="site-section">
                <div class="container">
                    <form action="cart">
                        <div class="row">

                            <div class="col-md-6 mb-5 mb-md-0">
                                <h2 class="h3 mb-3 text-black">Information</h2>
                                <div class="p-3 p-lg-5 border">


                                    <div class="form-group row">
                                        <div class="col-md-12">
                                            <label  class="text-black">Full Name </label>
                                            <input type="text" class="form-control" value="${user.fullname}"  name="fullname" placeholder="Your Name" readonly="">
                                        </div>
                                    </div>

                                    <div class="form-group row">

                                        <div class="col-md-12">
                                            <p style="color: red">${message}</p>
                                            <label class="text-black">Address <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" value="${user.address}" name="address" placeholder="Your Address">
                                        </div>
                                    </div>

                                    <div class="form-group row mb-5">
                                        <div class="col-md-6">
                                            <label  class="text-black">Email<span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" readonly="" value="${user.email}" name="email" placeholder="Email Address">
                                        </div>
                                        <div class="col-md-6">
                                            <label  class="text-black">Phone <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" readonly="" value="${user.phone}"  name="phone" placeholder="Phone Number">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">

                                <div class="row mb-5">
                                    <div class="col-md-12">
                                        <h2 class="h3 mb-3 text-black">Your Order</h2>
                                        <div class="p-3 p-lg-5 border">
                                            <table class="table site-block-order-table mb-5">
                                                <thead>
                                                <th>Product</th>
                                                <th>Total</th>
                                                </thead>
                                                <tbody>
                                                    <%
                                                    double total = 0;
                                                    Enumeration enu = session.getAttributeNames();

                                                    while(enu.hasMoreElements()){
                                                        String key = (String) enu.nextElement();
                                                        Product product = null;
                                                        if(!key.equals("account") && !key.equals("numberCartProducts")){
                                                           product = (Product) session.getAttribute(key);
                                                        }
                                                        if(product != null){
                                                    %>
                                                    <tr>
                                                        <td><%=product.getProduct_name()%> <strong class="mx-2">x</strong> <%=product.getQuantity()%></td>
                                                        <td>$<%=product.getPrice()*product.getQuantity()%></td>
                                                    </tr>
                                                    <%total += product.getPrice()*product.getQuantity();%>
                                                    <%}}%>

                                                    <tr>
                                                        <td class="text-black font-weight-bold"><strong>Order Total</strong></td>
                                                        <td class="text-black font-weight-bold"><strong>$<%=total%></strong></td>
                                                    </tr>
                                                </tbody>
                                            </table>



                                            <div class="form-group">

                                                <button type="submit" name="submit" value="placeOrder" class="btn btn-primary btn-lg py-3 btn-block">Place Order</button>
                                                <input type="hidden" name="service" value="checkout">

                                            </div>

                                        </div>
                                    </div>
                                </div>

                            </div>

                        </div>
                    </form>
                    <!-- </form> -->
                </div>
            </div>

            <%@include file="footer.jsp" %>
        </div>

        <%@include file="script.jsp" %>

    </body>
</html>