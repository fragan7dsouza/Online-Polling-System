<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.polling.dao.PollDAO, com.polling.model.Poll, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Available Polls - Online Polling System</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="container">
    <h1>Available Polls</h1>
    <div class="card">
        <h2>Select a poll to vote</h2>
        
        <table>
            <tr>
                <th>Poll ID</th>
                <th>Question</th>
                <th>Action</th>
            </tr>
            <%
                PollDAO dao = new PollDAO();
                List<Poll> polls = dao.getAllPolls();
                if (polls.isEmpty()) {
                    out.println("<tr><td colspan='3' style='text-align:center; padding:20px;'>No polls available yet.</td></tr>");
                } else {
                    for (Poll p : polls) {
            %>
            <tr>
                <td><%= p.getPollId() %></td>
                <td><%= p.getQuestion() %></td>
                <td><a href="vote-poll.jsp?pollId=<%= p.getPollId() %>">Vote Now</a></td>
            </tr>
            <% } } %>
        </table>
        
        <p class="back-link"><a href="index.jsp">Back to Home</a></p>
    </div>
</div>

</body>
</html>