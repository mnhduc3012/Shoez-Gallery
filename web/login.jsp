<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">


    <head>
        <title>Login</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="icon" type="image/png" href="images/icons/favicon.ico" />

        <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">

        <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">

        <link rel="stylesheet" type="text/css" href="fonts/iconic/css/material-design-iconic-font.min.css">

        <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">

        <link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">

        <link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">

        <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">

        <link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">

        <link rel="stylesheet" type="text/css" href="css/util.css">
        <link rel="stylesheet" type="text/css" href="css/login.css">

        <meta name="robots" content="noindex, follow">
    </head>
    <body>
        <div class="limiter">
            <div class="container-login100">
                <div class="wrap-login100">
                    <form action="login" method="post" class="login100-form validate-form">
                        <span class="login100-form-title p-b-26">
                            LOGIN
                        </span>
                        
                        <p><h4 style="color: red">${message}</h4></p>
                        <br>
                        <div class="wrap-input100 validate-input">
                            Username
                            <input class="input100" type="text" name="user">

                        </div>
                        <div class="wrap-input100 validate-input">
                            <span class="btn-show-pass">
                                <i class="zmdi zmdi-eye"></i>
                            </span>
                            Password
                            <input class="input100" type="password" name="pass">

                        </div>
                        <div class="container-login100-form-btn">
                            <div class="wrap-login100-form-btn">
                                <div class="login100-form-bgbtn"></div>
                                <button type="submit" name="submit" value="Login" class="login100-form-btn">
                                    Login
                                </button>
                                <input type="hidden" name="service" value="login">
                            </div>
                        </div>
                        <div class="text-center p-t-115">
                            <span class="txt1" style="font-size: medium">
                                Don’t have an account?
                            </span>
                            <a class="txt2" href="register" style="font-size: medium">
                                Sign Up
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div id="dropDownSelect1"></div>

        <script src="vendor/jquery/jquery-3.2.1.min.js"></script>

        <script src="vendor/animsition/js/animsition.min.js"></script>

        <script src="vendor/bootstrap/js/popper.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.min.js"></script>

        <script src="vendor/select2/select2.min.js"></script>

        <script src="vendor/daterangepicker/moment.min.js"></script>
        <script src="vendor/daterangepicker/daterangepicker.js"></script>

        <script src="vendor/countdowntime/countdowntime.js"></script>

        <script src="js/login.js"></script>

        <script async src="https://www.googletagmanager.com/gtag/js?id=UA-23581568-13"></script>
    </body>


</html>
