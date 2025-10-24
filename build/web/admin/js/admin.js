document.addEventListener('DOMContentLoaded', () => {
// simple active state for sidebar on first paint if server didn’t set activeMenu
    const path = location.pathname;
    document.querySelectorAll('.sidebar-nav a').forEach(a => {
        if (a.getAttribute('href') === path)
            a.parentElement.classList.add('active');
    });
});