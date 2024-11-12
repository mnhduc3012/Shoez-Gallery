

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html lang="en">
    <%
    ResultSet rsSummary = (ResultSet) request.getAttribute("rsSummary");
    ResultSet rsRecentOrder = (ResultSet) request.getAttribute("rsRecentOrder");
    ResultSet rsTopUsers = (ResultSet) request.getAttribute("rsTopUsers");
    %>
    <head>
        <title>Admin Dashboard</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Mukta:300,400,700">
        <%@include file="css.jsp" %>
    </head>
    <body>
        <div class="site-wrap">
            <%@include file="header.jsp" %>

            <%rsSummary.next();%>
            <div class="site-section">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6 col-lg-3 mb-4 mb-lg-0">
                            <div class="border p-4 text-center">
                                <span class="flaticon-wallet display-3 text-primary mb-3 d-block"></span>
                                <h3 class="mb-0 text-primary font-weight-bold">$${rsSummary.getDouble(1)}</h3>
                                <p class="mb-0">Total Revenue</p>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-3 mb-4 mb-lg-0">
                            <div class="border p-4 text-center">
                                <span class="flaticon-box display-3 text-primary mb-3 d-block"></span>
                                <h3 class="mb-0 text-primary font-weight-bold">${rsSummary.getInt(2)}</h3>
                                <p class="mb-0">Total Products Sold</p>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-3 mb-4 mb-lg-0">
                            <div class="border p-4 text-center">
                                <span class="flaticon-users display-3 text-primary mb-3 d-block"></span>
                                <h3 class="mb-0 text-primary font-weight-bold">${rsSummary.getInt(3)}</h3>
                                <p class="mb-0">Total Orders</p>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-3 mb-4 mb-lg-0">
                            <div class="border p-4 text-center">
                                <span class="flaticon-envelope-o display-3 text-primary mb-3 d-block"></span>
                                <h3 class="mb-0 text-primary font-weight-bold">${rsSummary.getInt(4)}</h3>
                                <p class="mb-0">Total Customers</p>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-5">
                        <div class="col-md-8">
                            <h2 class="h3 mb-3 text-black">Total Revenue</h2>
                            <div class="border p-4">
                                <canvas id="revenueChart"></canvas>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <h2 class="h3 mb-3 text-black">Total Products Sold</h2>
                            <div class="border p-4">
                                <canvas id="productSoldChart"></canvas>
                            </div>
                        </div>
                    </div>


                    <div class="row mt-5">
                        <div class="col-md-8">
                            <h2 class="h3 mb-3 text-black">Top Users</h2>
                            <div class="border p-4">
                                <table class="table text-center">
                                    <thead >
                                        <tr class="text-primary">

                                            <th>User ID</th>
                                            <th>Username</th>
                                            <th>Total orders</th>
                                            <th>Total amount spent</th>
                                        </tr>
                                    </thead>
                                    <tbody >
                                        <%while(rsTopUsers.next()){%>
                                        <tr class="text-black">                                       
                                            <td><%=rsTopUsers.getInt(1)%></td>
                                            <td><%=rsTopUsers.getString(2)%></td>
                                            <td><%=rsTopUsers.getInt(4)%></td>
                                            <td><span >$<%=rsTopUsers.getDouble(3)%></span></td>
                                        </tr>
                                        <%}%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <h2 class="h3 mb-3 text-black">Customer Distribution</h2>
                            <div class="border p-4">
                                <canvas id="customerChart"></canvas>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-5">
                        <div class="col-md-8">
                            <h2 class="h3 mb-3 text-black">Recent Orders</h2>
                            <div class="border p-4">
                                <table class="table text-center">
                                    <thead>
                                        <tr class="text-primary">

                                            <th>Order ID</th>
                                            <th>Customer</th>
                                            <th>Total</th>
                                            <th>Status</th>
                                            <th>Order Date</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%while(rsRecentOrder.next()){%>
                                        <tr class="text-black">                                       
                                            <td><%=rsRecentOrder.getInt(1)%></td>
                                            <td><%=rsRecentOrder.getString(2)%></td>
                                            <td>$<%=rsRecentOrder.getDouble(3)%></td>
                                            <td><%=rsRecentOrder.getString(4)%></td>
                                            <td><%=rsRecentOrder.getString(5)%></td>
                                        </tr>
                                        <%}%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <h2 class="h3 mb-3 text-black">Top Products</h2>
                            <div class="border p-4">
                                <ul class="list-unstyled">
                                    <c:forEach items="${bestSellerProducts}" var="o">
                                        <li class="mb-2">                    
                                            <div href="#" class="d-flex text-primary">
                                                <span class="mr-3"><img src="img/${o.image_url}" alt="Product" width="70"></span>
                                                <span>${o.product_name}</span>
                                            </div>
                                        </li>
                                        <hr>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%@include file="footer.jsp" %>
        </div>

        <%@include file="script.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <script>

            var customerChart = document.getElementById('customerChart').getContext('2d');
            var customerData = {
                labels: ['New Customers', 'Return Customers'],
                datasets: [{
                        data: ${dataCustomer},
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)'
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)'
                        ],
                        borderWidth: 1
                    }]
            };
            var customerChartConfig = {
                type: 'doughnut',
                data: customerData,
                options: {
                    responsive: true,
                    maintainAspectRatio: false
                }
            };
            var customerChart = new Chart(customerChart, customerChartConfig);

            var productSoldChart = document.getElementById('productSoldChart').getContext('2d');
            var productSoldData = {
                labels: ${labels},
                datasets: [{
                        data: ${dataProduct},
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 206, 86, 0.2)',
                            'rgba(75, 192, 192, 0.2)',
                            'rgba(153, 102, 255, 0.2)',
                            'rgba(255, 159, 64, 0.2)'
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)'
                        ],
                        borderWidth: 1
                    }]
            };
            var productSoldChartConfig = {
                type: 'doughnut',
                data: productSoldData,
                options: {
                    responsive: true,
                    maintainAspectRatio: false
                }
            };
            var productSoldChart = new Chart(productSoldChart, productSoldChartConfig);




            var revenueChart = document.getElementById('revenueChart').getContext('2d');
            var revenueData = {
                labels: ${labels},
                datasets: [{
                        label: 'Revenue',
                        data: ${dataRevenue},
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 206, 86, 0.2)',
                            'rgba(75, 192, 192, 0.2)',
                            'rgba(153, 102, 255, 0.2)',
                            'rgba(255, 159, 64, 0.2)'
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)'
                        ],
                        borderWidth: 1
                    }]
            };
            var revenueChartConfig = {
                type: 'bar',
                data: revenueData,
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    },
                    responsive: true,
                    plugins: {
                        legend: {
                            display: false
                        },
                        title: {
                            display: false

                        }
                    }
                }
            };
            var revenueChart = new Chart(revenueChart, revenueChartConfig);

        </script>
    </body>
</html>
