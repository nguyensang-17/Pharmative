<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/common/header.jsp" />

<div class="bg-light py-3">
  <div class="container">
    <div class="row">
      <div class="col-md-12 mb-0">
        <a href="${pageContext.request.contextPath}/home">Home</a>
        <span class="mx-2 mb-0">/</span>
        <strong class="text-black">Account Verification</strong>
      </div>
    </div>
  </div>
</div>

<div class="site-section">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-md-6">
        <form action="${pageContext.request.contextPath}/verify" method="post">
          <div class="p-3 p-lg-5 border text-center">
            <h2 class="h3 mb-3 text-black">Enter Verification Code</h2>
            <c:if test="${not empty error}">
              <div class="alert alert-danger">${error}</div>
            </c:if>
            <div class="form-group row justify-content-center">
              <div class="col-md-8">
                <label for="code" class="text-black">Verification Code</label>
                <input type="text" class="form-control" id="code" name="code" required>
              </div>
            </div>
            <div class="form-group row justify-content-center mt-4">
              <div class="col-md-8">
                <input type="submit" class="btn btn-primary btn-lg btn-block" value="Verify Account">
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/common/footer.jsp" />