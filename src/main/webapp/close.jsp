<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.Ticket" %>
<%@ page import="java.util.List" %>
<%@ page import="helper.FactoryProvider" %>
<%@ page import="org.hibernate.Session" %>
<html>
<head>
    <title>Close Tickets</title>
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
    <tr>
        <td colspan="5">No tickets found</td>
    </tr>
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
        <td><%= ticket.getCategory() %></td>
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
<h1>Resolve Ticket</h1>
<form action="ResolveTicket" method="post">
    <label for="id">Ticket ID:</label>
    <input type="text" id="id" name="id" required>
    <br>
    <label for="status">Status:</label>
    <select id="status" name="status" required>
        <option value="open">Open</option>
        <option value="in progress">In Progress</option>
        <option value="resolved">Resolved</option>
    </select>
    <br>
    <label for="category">Category:</label>
    <select id="category" name="category">
        <option value="UI">User Interface</option>
        <option value="network issue">Network issue</option>
        <option value="security">security</option>
        <option value="bug">Bug</option>
        <option value="crashing">Crashing</option>
    </select><br>
    <input type="submit" value="Resolve">
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
<a href="index.jsp"><button>Home</button></a>
</body>
</html>
