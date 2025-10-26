<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Pharmative</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/fonts/icomoon/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/magnific-popup.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/owl.carousel.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/aos.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="site-wrap">
    <div class="site-navbar py-2">
        <div class="container">
            <div class="d-flex align-items-center justify-content-between">
                <div class="logo">
                    <div class="site-logo">
                        <a href="${pageContext.request.contextPath}/home" class="js-logo-clone"><strong class="text-primary">Pharma</strong>tive</a>
                    </div>
                </div>
                <div class="main-nav d-none d-lg-block">
                    <nav class="site-navigation text-right text-md-center" role="navigation">
                        <ul class="site-menu js-clone-nav d-none d-lg-block">
                            <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                            <li><a href="${pageContext.request.contextPath}/products">Store</a></li>
                            <li><a href="${pageContext.request.contextPath}/about.jsp">About</a></li>
                            <li><a href="${pageContext.request.contextPath}/contact.jsp">Contact</a></li>
                        </ul>
                    </nav>
                </div>
                <div class="icons">
                    <a href="${pageContext.request.contextPath}/cart" class="icons-btn d-inline-block bag">
                        <span class="icon-shopping-bag"></span>
                        <c:if test="${not empty sessionScope.cart}">
                           <span class="number">${sessionScope.cart.size()}</span>
                        </c:if>
                    </a>
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                             <a href="${pageContext.request.contextPath}/account" class="icons-btn d-inline-block"><span class="icon-user"></span> Hello, ${sessionScope.user.fullname}</a>
                             <a href="${pageContext.request.contextPath}/logout" class="icons-btn d-inline-block"><span class="icon-sign-out"></span></a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login" class="icons-btn d-inline-block"><span class="icon-user"></span></a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>