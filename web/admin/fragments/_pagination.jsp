<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="pager">
    <a class="${page.first ? 'disabled':''}" href="${!page.first ? page.url(0) : '#'}">«</a>
    <a class="${!page.hasPrevious ? 'disabled':''}" href="${page.hasPrevious ? page.url(page.number-1) : '#'}">?</a>
    <span>Trang <b>${page.number+1}</b> / ${page.totalPages}</span>
    <a class="${!page.hasNext ? 'disabled':''}" href="${page.hasNext ? page.url(page.number+1) : '#'}">?</a>
    <a class="${page.last ? 'disabled':''}" href="${!page.last ? page.url(page.totalPages-1) : '#'}">»</a>
</nav>