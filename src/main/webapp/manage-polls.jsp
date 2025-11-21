<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.polling.dao.*, com.polling.model.*, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Polls</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="container">
    <h1>Manage Polls</h1>
    <div class="card">
        <p style="text-align:center;"><a href="add-poll.jsp" class="btn">Add New Poll</a></p>
        
        <table>
            <tr>
                <th>Poll ID</th>
                <th>Question</th>
                <th>Actions</th>
            </tr>
            <%
                List<Poll> polls = new PollDAO().getAllPolls();
                if (polls.isEmpty()) {
                    out.println("<tr><td colspan='3' style='text-align:center;padding:20px;'>No polls created yet.</td></tr>");
                } else {
                    for (Poll p : polls) {
            %>
            <tr>
                <td><%= p.getPollId() %></td>
                <td><%= p.getQuestion() %></td>
                <td class="action-links">
                    <a href="view-results.jsp?pollId=<%= p.getPollId() %>">Results</a>
                    <a href="update-poll.jsp?pollId=<%= p.getPollId() %>">Edit</a>
                    <a href="delete-poll.jsp?pollId=<%= p.getPollId() %>" 
                       onclick="return confirm('Delete this poll permanently?')">Delete</a>
                </td>
            </tr>
            <% } } %>
        </table>
        
        <p class="back-link"><a href="index.jsp">Back to Home</a></p>
    </div>
</div>

</body>
</html>