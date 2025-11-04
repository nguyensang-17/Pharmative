<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Orders Management</title>
    <link rel="stylesheet" href="../css/admin.css">
</head>
<body>
    <!-- Include topbar -->
    <%@ include file="../fragments/topbar.jsp" %>
    
    <div class="container-fluid">
        <div class="row">
            <!-- Include sidebar -->
            <%@ include file="../fragments/sidebar.jsp" %>
            
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <!-- Flash messages -->
                <%@ include file="../fragments/flash.jsp" %>
                
                <h2>Orders Management</h2>
                <!-- Nội dung chính của trang orders -->
                
                <!-- Pagination -->
                <%@ include file="../fragments/pagination.jsp" %>
            </main>
        </div>
    </div>
    
    <script src="../js/admin.js"></script>
</body>
</html>