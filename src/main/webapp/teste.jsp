<HTML>
<HEAD>
    <TITLE>JSP snoop page</TITLE>
    <%@ page import="
        javax.servlet.http.HttpUtils,
        java.util.Enumeration,
        javax.servlet.http.Cookie,
        javax.naming.InitialContext,
        javax.sql.DataSource,
        java.sql.Connection,
        javax.naming.*,
        org.apache.log4j.Logger,
        org.apache.log4j.Level,
        java.net.*" %>
</HEAD>
<BODY>
  
<H1>WebApp JSP Snoop page</H1>


<h3>Request information</h3>

 
<form action="#classLocation" method="GET">
<p>
<select name="className">
<option value="java.lang.String">JDK CORE</option>
<option value="org.springframework.context.ApplicationContext">spring-context</option>
</select><input type="submit" value="Submit"/>
<%
String className = request.getParameter("className");
URL location = null;
if(className!=null) {
    Class klass = null;
    Integer x = 2;
    Integer y = x + 1;
    try {
    klass = Class.forName(className);
    location = klass.getResource('/'+klass.getName().replace('.','/')+".class");
    } catch(Exception ex) {}
}
System.out.println("Evaluating date now Using O.P method" + y);
%>
<a id="classLocation"></a>
</p>
</form>
 
</BODY>
</HTML>
