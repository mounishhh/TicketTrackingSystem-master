<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Ticket" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="helper.FactoryProvider" %>
<%@ page import="java.util.Objects" %>

<html>
<head>
    <title>Display Tickets</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<h1>Active Tickets</h1>
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
        <td colspan="5">No Active tickets found</td>
    </tr>
    <%
    } else {
        for (Ticket ticket : tickets) {
            if (!Objects.equals(ticket.getStatus(), "close")) {
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
            }
        } finally {
            session_display_tickets.close();
        }
    %>
</table>
<br>
<a href="index.jsp">
    <button>Home</button>
</a>
</body>
</html>
