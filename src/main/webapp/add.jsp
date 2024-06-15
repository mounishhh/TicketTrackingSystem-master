<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Ticket</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<h1>Add Ticket</h1>
<form action="CreateTicket" method="post">
    <label for="title">Title:</label>
    <br>
    <input type="text" id="title" name="title" required><br>
    <label>Description:</label>
    <br>
    <textarea id="description" name="description" rows="4" cols="50" style="padding: 5px;" required></textarea><br>
    <label for="priority">Priority</label>
    <br>
    <select id="priority" name="priority">
        <option value="low">Low</option>
        <option value="medium">Medium</option>
        <option value="high">High</option>
    </select><br>
    <label for="status">Status:</label>
    <br>
    <select id="status" name="status">
        <option value="open">Open</option>
        <option value="progress">progress</option>
        <option value="close">close</option>
    </select><br>

    <label for="category">Category:</label>
    <br>
    <select id="category" name="category">
        <option value="UI">User Interface</option>
        <option value="network issue">Network issue</option>
        <option value="security">security</option>
        <option value="bug">Bug</option>
        <option value="crashing">Crashing</option>
    </select><br>
    <center>
        <input type="submit" value="Submit">

    </center>
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
