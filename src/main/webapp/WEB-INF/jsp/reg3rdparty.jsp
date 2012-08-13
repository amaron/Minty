<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:if test="${not empty message}">
    ${message}</br>
</c:if>

Register Now to user Minty 3rdParty REST APIs!
<form action="/REST/register" method="post">
    Name: <input type="text" name="pname"></br>
    <input type="submit" value="Register">
</form>

