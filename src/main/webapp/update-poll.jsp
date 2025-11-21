<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.polling.dao.PollDAO"%>
<%@page import="com.polling.dao.OptionDAO"%>
<%@page import="com.polling.model.Poll"%>
<%@page import="com.polling.model.Option"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Poll</title>
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
    <h1>Update Poll</h1>
    <%
        int pollId = Integer.parseInt(request.getParameter("pollId"));
        PollDAO dao = new PollDAO();
        OptionDAO optionDAO = new OptionDAO();
        try {
            Poll poll = dao.getPoll(pollId);
            List<Option> options = optionDAO.getOptionsByPoll(pollId);
            if (poll != null) {
    %>
    <form method="post">
        <label>Poll ID: <%= poll.getPollId() %> (readonly)</label><br>
        <label>Question:</label><br>
        <input type="text" name="question" value="<%= poll.getQuestion() %>" required><br>
        <%
            for (Option option : options) {
        %>
        <label>Option <%= option.getOptionId() %>:</label><br>
        <input type="text" name="option_<%= option.getOptionId() %>" value="<%= option.getOptionText() %>" required><br>
        <%
            }
        %>
        <input type="submit" value="Update Poll">
    </form>
    <%
            if (request.getMethod().equals("POST")) {
                String question = request.getParameter("question");
                Poll updatedPoll = new Poll(pollId, question);
                try {
                    dao.updatePoll(updatedPoll);
                    for (Option option : options) {
                        String optionText = request.getParameter("option_" + option.getOptionId());
                        if (optionText != null && !optionText.trim().isEmpty()) {
                            Option updatedOption = new Option(option.getOptionId(), pollId, optionText);
                            optionDAO.updateOption(updatedOption);
                        }
                    }
                    out.println("<p class='success'>Poll updated successfully!</p>");
                } catch (SQLException e) {
                    out.println("<p class='error'>Error updating poll: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                }
            }
        } else {
            out.println("<p class='error'>Poll not found.</p>");
        }
        } catch (SQLException e) {
            out.println("<p class='error'>Error retrieving poll: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    %>
    <p><a href="manage-polls.jsp">Back to Manage Polls</a></p>
</body>
</html>