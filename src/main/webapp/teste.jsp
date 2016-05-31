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
  
<%
    Enumeration e = request.getHeaderNames();
    if(e != null && e.hasMoreElements()) {
%>
<h3>Request headers</h3>
  
<TABLE border="1">
<TR>
    <TH align=left>Header:</TH>
    <TH align=left>Value:</TH>
</TR>
<%
        while(e.hasMoreElements()) {
            String k = (String) e.nextElement();
%>
<TR>
    <TD><%= k %></TD>
    <TD><%= request.getHeader(k) %></TD>
</TR>
<%
        }
%>
</TABLE>
<%
    }
%>
  
  
<%
    Cookie[] c = request.getCookies();
    if(c !=null) {
%>
<h3>Cookies in this Request</h3>
<TABLE border="1">
<TR valign=top>
    <TH align=left>Parameter:</TH>
    <TH align=left>Value:</TH>
</TR>
<%
        for (int i = 0; i < c.length; i++) {
%>
<TR valign=top>
    <TD><%= c[i].getName() %></TD>
    <TD><%= c[i].getValue() %></TD>
</TR>
<%
        }
%>
</TABLE>
<%
    }
%>
  
  
<%
    e = request.getParameterNames();
    if(e != null && e.hasMoreElements()) {
%>
<h3>Request parameters</h3>
<TABLE border="1">
<TR valign=top>
    <TH align=left>Parameter:</TH>
    <TH align=left>Value:</TH>
    <TH align=left>Multiple values:</TH>
</TR>
<%
        while(e.hasMoreElements()) {
            String k = (String) e.nextElement();
            String val = request.getParameter(k);
            String vals[] = request.getParameterValues(k);
%>
<TR valign=top>
    <TD><%= k %></TD>
    <TD><%= val %></TD>
    <TD><%
            for(int i = 0; i < vals.length; i++) {
                if(i > 0)
                    out.print("<BR>");
                out.print(vals[i]);
            }
        %></TD>
</TR>
<%
        }
%>
</TABLE>
<%
    }
%>
  
<%
    e = getInitParameterNames();
    if(e != null && e.hasMoreElements()) {
%>
<h3>Servlet Init parameters</h3>
<TABLE border="1">
<TR valign=top>
    <TH align=left>Parameter:</TH>
    <TH align=left>Value:</TH>
</TR>
<%
        while(e.hasMoreElements()) {
            String k = (String) e.nextElement();
            String val = getServletConfig().getInitParameter(k);
%>
<TR valign=top>
    <TD><%= k %></TD>
    <TD><%= val %></TD>
</TR>
<%
        }
%>
</TABLE>
<%
    }
%>
  
<%
    e = getServletConfig().getInitParameterNames();
    if(e != null && e.hasMoreElements()) {
%>
<h3>Context Init parameters</h3>
<TABLE border="1">
<TR valign=top>
    <TH align=left>Parameter:</TH>
    <TH align=left>Value:</TH>
</TR>
<%
        while(e.hasMoreElements()) {
            String k = (String) e.nextElement();
            String val = getServletConfig().getInitParameter(k);
%>
<TR valign=top>
    <TD><%= k %></TD>
    <TD><%= val %></TD>
</TR>
<%
        }
%>
</TABLE>
<%
    }
%>
  
<%
    e = getServletContext().getAttributeNames();
    if(e != null && e.hasMoreElements()) {
%>
<h3>Context Attributes</h3>
<TABLE border="1">
<TR valign=top>
    <TH align=left>Parameter:</TH>
    <TH align=left>Value:</TH>
</TR>
<%
        while(e.hasMoreElements()) {
            String k = (String) e.nextElement();
            String val = getServletConfig().getInitParameter(k);
%>
<TR valign=top>
    <TD><%= k %></TD>
    <TD><%= val %></TD>
</TR>
<%
        }
%>
</TABLE>
<%
    }
%>
  
<h3>Datasource Tests</h3>
<table border="1" width="75%">
    <tr>
        <td valign="top">
<h3>JNDI DataSources</h3>
<%
String contextName = "java:/comp/env/jdbc";
try {
    Context initCtx = new InitialContext();
    NamingEnumeration ne = initCtx.listBindings(contextName);
    %>
  
    <TABLE border="1">
    <TR><TH>Name</TH><TH>Type</TH></TR>
    <%  
    while (ne.hasMore()) {
      Binding binding = (Binding) ne.next();
    %>
    <TR>
      <TD><a href="?jndiName=jdbc/<%=binding.getName()%>">
        java:comp/env/jdbc/<%=binding.getName()%></a></TD>
      <TD>Type: <%=binding.getClassName() %></TD>
    </TR>
    <%
    }
    %></table>
<%} catch (NamingException ex) {%>
    Nothing found at: <%=contextName%>
<%}%>
          
        </td>
        <td>
  
<% boolean jndiSuccess = false;
String jndiName = (String)request.getParameter("jndiName");
  
String message = "";
if(jndiName != null && !"".equals(jndiName.trim())) {
    Connection conn = null;
    try {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        if(envCtx!=null){
            DataSource ds = (DataSource)envCtx.lookup(jndiName);
            conn = ds.getConnection();
            if(conn != null) jndiSuccess = true;
            %>
<TABLE border="1">
<TR>
<TH>JDBC URL</TH>
<TD><%=conn.getMetaData().getURL() %> </TD>
</TR>        
<TR>
<TH>JDBC Username</TH>
<TD><%=conn.getMetaData().getUserName() %> </TD>
</TR>        
<TR>
<TH>Database </TH>
<TD><%=conn.getMetaData().getDatabaseProductName() %>
<%=conn.getMetaData().getDatabaseProductVersion() %></TD>
</TR>        
<TR>
<TH>Driver</TH>
<TD><%=conn.getMetaData().getDriverName() %> <%=conn.getMetaData().getDriverVersion() %></TD>
</TR>        
<TR>
<TH>JDBC Version</TH>
<TD><%=conn.getMetaData().getJDBCMajorVersion() %> </TD>
</TR>
<TR>
<TH>JDBC Max Connections</TH>
<TD><%=conn.getMetaData().getMaxConnections() %> </TD>
</TR>        
              
</TABLE>
            <%          
        }
    } catch (Exception ex) {
        message = ex.getMessage();
    } finally {
        try{conn.close();}catch(Exception ex){}
    }
      
}
%>
  
<form action="" method="GET">
<p><label for="jndiName">DataSource JNDI Name: </label> <br/>
java:comp/env/<input name="jndiName" type="text" value="<%=jndiName==null? "" : jndiName%>"></p>
<p>
<%if(jndiSuccess) {%>
Connection Success!
<%} else if (!"".equals(message)) {%>
Connection failed with message: <%=message %>
<%} %>
</p>
<p><input name="submit" type="submit" value="submit"></p>
</form>
          
        </td>
    </tr>
</table>
  
  
<h3>JAX-WS</h3>
  
<TABLE border="1">
<TR valign=top>
    <TH align=left>API</TH>
    <TH align=left>Sun Implementation</TH>
</TR>
<TR valign=top>
    <TD>
<%
    try {
        Class.forName("javax.jws.WebService");
        %>Present<%
    } catch (Exception ex) {
        %>Missing<%
    }
%>  
    </TD>
    <TD>
<%
    try {
        Class.forName("com.sun.istack.Builder");
        %>Present<%
    } catch (Exception ex) {
        %>Missing<%
    }
%>  
    </TD>
</TR>
</TABLE>
  
<h3>Apache Log4j Logging</h3>
  
<%
Logger logger = Logger.getLogger(getClass());
if("submit".equals((String)request.getParameter("log"))) {
    String text = (String)request.getParameter("text");
    String level = (String)request.getParameter("level");
    logger.log(Level.toLevel(level), text);
}
%>
  
<form action="" method="GET">
<TABLE border="1">
<TR valign=top>
    <TH align=left>Level</TH>
    <TH align=left>Test Message</TH>
</TR>
<TR valign=top>
    <TD>
        <select name="level">    
            <option value="ERROR">ERROR</option>
            <option value="WARN">WARN</option>
            <option value="INFO" selected="selected">INFO</option>
            <option value="DEBUG">DEBUG</option>
        </select>
    </TD>
    <TD>
        <input name="text" type="text" size="35" value="<%=new java.util.Date()%>">
        <input name="log" type="submit" value="submit">  
    </TD>
</TR>
</TABLE>
</form>
<h3>Classloader Query</h3>
<p>The form below returns information about where a class is being served from.</p>
 
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
    int x = 2;
    try {
    klass = Class.forName(className);
    location = klass.getResource('/'+klass.getName().replace('.','/')+".class");
    } catch(Exception ex) {}
}
%>
<a id="classLocation"></a><%=location==null ? "Class Not Found in any JAR in classpath." : location%>
</p>
</form>
 
</BODY>
</HTML>
