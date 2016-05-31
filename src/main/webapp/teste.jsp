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

<p>
<%
int x = 2;
int y = x + 1;
out.println(x);
%>
</p>
 
</BODY>
</HTML>
