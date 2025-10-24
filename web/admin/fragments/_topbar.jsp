<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="topbar-wrap">
<form class="search" method="get" action="${pageContext.request.contextPath}/admin/products">
<input type="text" name="q" placeholder="Tìm ki?m s?n ph?m, ??n hàng..." value="${param.q}">
</form>
<div class="actions">
<a class="btn" href="${pageContext.request.contextPath}/admin/products/new">+ Thêm s?n ph?m</a>
<div class="user">
<span><c:out value="${sessionScope.username != null ? sessionScope.username : 'admin@pharmative.com'}"/></span>
<a class="btn-outline" href="${pageContext.request.contextPath}/logout">??ng xu?t</a>
</div>
</div>
</div>