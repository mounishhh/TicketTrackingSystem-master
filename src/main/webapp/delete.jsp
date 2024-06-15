<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Ticket" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="helper.FactoryProvider" %>
<html>
<head>
    <title>Delete Ticket</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<h1>Tickets</h1>
<table>
    <tr>
        <th>Id</th>
        <th>Title</th>
        <th>Description</th>
        <th>Priority</th>
        <th>Status</th>
        <th>Category</th>
    </tr>
    <%
        Session session_display_tickets = FactoryProvider.getFactory().openSession();

        try {
            session_display_tickets.beginTransaction();
            List<Ticket> tickets = session_display_tickets.createQuery("from Ticket").getResultList();

            if (tickets.isEmpty()) {
    %>
    <%
    } else {
        for (Ticket ticket : tickets) {
    %>
    <tr>
        <td><%= ticket.getId() %></td>
        <td><%= ticket.getTitle() %></td>
        <td><%= ticket.getDescription() %></td>
        <td><%= ticket.getPriority() %></td>
        <td><%= ticket.getStatus() %></td>
        <td><%=ticket.getCategory()%></td>
    </tr>
    <%
                }
            }
        } finally {
            session_display_tickets.close();
        }
    %>

</table>
<br>
<h1>Delete Ticket</h1>
<form action="DeleteTicket" method="post">
    <label for="id">Ticket ID:</label>
    <br>
    <input type="number" id="id" name="id" required/>
    <br>
    <input type="submit" value="Delete"/>
</form>
<br>
<%
    String message = (String) request.getAttribute("message");
    if (message != null && !message.isEmpty()) {
%>
<script>window.alert("<%=message%>");</script>
<%
    }
%>
<br>
<a href="index.jsp">
    <button>Home</button>
</a>
</body>
</html>
