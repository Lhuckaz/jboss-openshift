<HTML>
<HEAD>
    <TITLE>JSP snoop page</TITLE>
</HEAD>
<BODY>
  
<H1>JSP Test</H1>
  
  
<h3>Soma</h3>

<p>Resultado:</p>

<p>
<%
try {
int location = 2;
} catch(Exception ex) {}
%>
<%=location==2 ? "Falha" : location%>
</p>
 
</BODY>
<HTML>
