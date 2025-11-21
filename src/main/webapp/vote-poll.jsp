<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.polling.dao.*, com.polling.model.*, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cast Your Vote</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="container">
    <h1>Cast Your Vote</h1>
    <div class="card">
        <%
            String pid = request.getParameter("pollId");
            if (pid == null || pid.isEmpty()) {
                out.println("<p class='alert-error'>Invalid poll selected.</p>");
            } else {
                int pollId = Integer.parseInt(pid);
                Poll poll = new PollDAO().getPoll(pollId);
                if (poll == null) {
                    out.println("<p class='alert-error'>Poll not found.</p>");
                } else {
                    List<Option> options = new OptionDAO().getOptionsByPoll(pollId);
        %>
        <h2><%= poll.getQuestion() %></h2>
        <form method="post">
            <input type="hidden" name="pollId" value="<%= pollId %>">
            <div class="radio-group">
                <% for (Option opt : options) { %>
                <label class="radio-option">
                    <input type="radio" name="optionId" value="<%= opt.getOptionId() %>" required>
                    <%= opt.getOptionText() %>
                </label>
                <% } %>
            </div>
            <input type="submit" value="Submit Vote">
        </form>
        
        <% 
                if ("POST".equals(request.getMethod())) {
                    int optionId = Integer.parseInt(request.getParameter("optionId"));
                    new VoteDAO().addVote(optionId);
        %>
        <script>
            alert("Vote casted successfully!");
            window.location.href = "polls-for-voting.jsp";
        </script>
        <% } %>
        <% } } %>
        
        <p class="back-link"><a href="polls-for-voting.jsp">Back to Poll List</a></p>
    </div>
</div>

</body>
</html>