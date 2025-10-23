<%@ page contentType="text/html; charset=UTF-8" %>
<div class="card">
    <div class="card-title">Doanh thu 7 ngày</div>
    <canvas id="revenueChart"></canvas>
</div>
<div class="card">
    <div class="card-title">Top 5 sản phẩm bán chạy</div>
    <table class="datatable" id="topProducts">
        <thead><tr><th>Sản phẩm</th><th>SL</th><th>Doanh thu</th></tr></thead>
        <tbody>
        <c:forEach var="p" items="${topProducts}">
            <tr>
                <td>${p.name}</td>
                <td>${p.qty}</td>
                <td>${p.amount}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</div>


<div class="card">
    <div class="card-title">Đơn hàng gần đây</div>
    <table class="datatable">
        <thead><tr><th>Mã</th><th>Khách hàng</th><th>Ngày</th><th>Tổng</th><th>Trạng thái</th></tr></thead>
        <tbody>
        <c:forEach var="o" items="${recentOrders}">
            <tr>
                <td><a href="${pageContext.request.contextPath}/admin/orders?id=${o.id}">${o.code}</a></td>
                <td>${o.customer}</td>
                <td>${o.dateFmt}</td>
                <td>${o.total}</td>
                <td><span class="badge">${o.status}</span></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        if (document.getElementById('revenueChart')) {
            const ctx = document.getElementById('revenueChart');
            new Chart(ctx, {
                type: 'line',
                data: {
                    labels: ${stats.labelsJson}, // e.g. ["T2","T3",...]
                    datasets: [{label: 'Doanh thu', data: ${stats.seriesJson}}]
                },
                options: {responsive: true, maintainAspectRatio: false}
            });
        }
        if (window.$ && $('#topProducts').length) {
            $('#topProducts').DataTable({paging: false, info: false, searching: false});
        }
    });
</script>