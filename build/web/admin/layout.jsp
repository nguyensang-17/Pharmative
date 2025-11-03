<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <jsp:include page="/WEB-INF/views/admin/fragments/_head.jsp"/>
    </head>
    <body>
        <div class="admin-shell">
            <aside class="sidebar">
                <jsp:include page="/WEB-INF/views/admin/fragments/_sidebar.jsp"/>
            </aside>
            <main class="main">
                <header class="topbar">
                    <jsp:include page="/WEB-INF/views/admin/fragments/_topbar.jsp"/>
                </header>
                <section class="content">
                    <jsp:include page="/WEB-INF/views/admin/fragments/_flash.jspf"/>
                    <!-- vùng nội dung động -->
                    <jsp:include page="${contentPage}"/>
                </section>
            </main>
        </div>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://cdn.datatables.net/1.13.8/js/jquery.dataTables.min.js"></script>
        <script src="${pageContext.request.contextPath}/admin/js/admin.js"></script>
    </body>
</html>