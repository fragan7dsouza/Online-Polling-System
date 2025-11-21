<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.polling.dao.PollDAO"%>
<%@page import="com.polling.model.Poll"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.Arrays"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Poll</title>
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
    <h1>Add New Poll</h1>
    <form method="post">
        <label>Question:</label><br>
        <input type="text" name="question" required><br>
        <label>Options (comma-separated):</label><br>
        <input type="text" name="options" required><br>
        <input type="submit" value="Add Poll">
    </form>
    <%
        if (request.getMethod().equals("POST")) {
            String question = request.getParameter("question");
            String[] options = request.getParameter("options").split(",");
            if (question != null && !question.trim().isEmpty() && options.length > 0) {
                Poll poll = new Poll();
                poll.setQuestion(question);
                PollDAO dao = new PollDAO();
                try {
                    dao.addPoll(poll, Arrays.asList(options));
                    out.println("<p class='success'>Poll added successfully!</p>");
                } catch (SQLException e) {
                    out.println("<p class='error'>Error adding poll: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                }
            } else {
                out.println("<p class='error'>Please provide a valid question and at least one option.</p>");
            }
        }
    %>
    <p><a href="manage-polls.jsp">Back to Manage Polls</a></p>
</body>
</html>