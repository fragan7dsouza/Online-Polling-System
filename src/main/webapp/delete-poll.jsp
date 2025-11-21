<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.polling.dao.PollDAO"%>
<%@page import="java.sql.SQLException"%>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Poll</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .error { color: red; }
        .success { color: green; }
        a { color: #007BFF; text-decoration: none; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <h1>Delete Poll</h1>
    <form method="post">
        <label>Poll ID:</label><br>
        <input type="number" name="pollId" value="<%= request.getParameter("pollId") != null ? request.getParameter("pollId") : "" %>" required><br>
        <input type="submit" value="Delete Poll">
    </form>
    <%
        if (request.getMethod().equals("POST")) {
            String pollIdStr = request.getParameter("pollId");
            if (pollIdStr != null && !pollIdStr.trim().isEmpty()) {
                try {
                    int pollId = Integer.parseInt(pollIdStr);
                    PollDAO dao = new PollDAO();
                    dao.deletePoll(pollId);
                    out.println("<p class='success'>Poll with ID " + pollId + " deleted successfully!</p>");
                } catch (SQLException e) {
                    out.println("<p class='error'>Error deleting poll: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } catch (NumberFormatException e) {
                    out.println("<p class='error'>Please enter a valid Poll ID.</p>");
                }
            } else {
                out.println("<p class='error'>Please enter a valid Poll ID.</p>");
            }
        } else if (request.getParameter("pollId") != null) {
            try {
                int pollId = Integer.parseInt(request.getParameter("pollId"));
                PollDAO dao = new PollDAO();
                dao.deletePoll(pollId);
                out.println("<p class='success'>Poll with ID " + pollId + " deleted successfully!</p>");
            } catch (SQLException e) {
                out.println("<p class='error'>Error deleting poll: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } catch (NumberFormatException e) {
                out.println("<p class='error'>Invalid Poll ID.</p>");
            }
        }
    %>
    <p><a href="manage-polls.jsp">Back to Manage Polls</a></p>
</body>
</html>