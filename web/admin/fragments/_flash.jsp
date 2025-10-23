<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${not empty success}"><div class="flash success">${success}</div></c:if>
<c:if test="${not empty error}"><div class="flash error">${error}</div></c:if>