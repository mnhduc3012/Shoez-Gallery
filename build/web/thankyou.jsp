<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thank you</title>
        <%@include file="css.jsp" %>
    </head
    <body>

        <div class="site-wrap">
            <%@include file="header.jsp" %>

            <div class="bg-light py-3">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 mb-0"><a href="home">Home</a> <span class="mx-2 mb-0">/</span> <strong class="text-black">Cart</strong></div>
                    </div>
                </div>
            </div>  

            <div class="site-section">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <span class="icon-check_circle display-3 text-success"></span>
                            <h2 class="display-3 text-black">Thank you!</h2>
                            <p class="lead mb-5">You order was successfuly completed.</p>
                            <p><a href="shop" class="btn btn-sm btn-primary">Back to shop</a></p>
                        </div>
                    </div>
                </div>
            </div>

            <%@include file="footer.jsp" %>
        </div>

        <%@include file="script.jsp" %>

    </body>
</html>