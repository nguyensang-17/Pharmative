// src/java/filter/MenuFilter.java
package filter;

import DAO.CategoryDAO;
import models.Category;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebFilter("/*")
public class MenuFilter implements Filter {
  private CategoryDAO categoryDAO;

  @Override public void init(FilterConfig cfg){ categoryDAO = new CategoryDAO(); }

  @Override
  public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
      throws IOException, ServletException {
    try {
      Map<Category, List<Category>> menu = categoryDAO.getTree2Levels();
      req.setAttribute("menuCategories", menu);
    } catch (Exception e) { e.printStackTrace(); }
    chain.doFilter(req, res);
  }

  @Override public void destroy() {}
}
