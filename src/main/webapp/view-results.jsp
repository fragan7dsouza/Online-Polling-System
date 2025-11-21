<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.polling.dao.PollDAO"%>
<%@page import="com.polling.dao.OptionDAO"%>
<%@page import="com.polling.dao.VoteDAO"%>
<%@page import="com.polling.model.Poll"%>
<%@page import="com.polling.model.Option"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<!DOCTYPE html>
<html>
<head>
    <title>Poll Results</title>
    <link rel="stylesheet" href="style.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.2/dist/chart.umd.min.js"></script>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .error { color: red; }
        canvas { max-width: 400px; margin: 20px 0; }
        a { color: #007BFF; text-decoration: none; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <h1>Poll Results</h1>
    <%
        String pollIdStr = request.getParameter("pollId");
        if (pollIdStr != null && !pollIdStr.trim().isEmpty()) {
            try {
                int pollId = Integer.parseInt(pollIdStr);
                PollDAO dao = new PollDAO();
                Poll poll = dao.getPoll(pollId);
                if (poll != null) {
                    OptionDAO optionDAO = new OptionDAO();
                    VoteDAO voteDAO = new VoteDAO();
                    List<Option> options = optionDAO.getOptionsByPoll(pollId);
                    Map<Integer, Integer> voteCounts = voteDAO.getVoteCounts(pollId);
    %>
    <h2><%= poll.getQuestion() %></h2>
    <ul>
        <%
            for (Option option : options) {
                int votes = voteCounts.getOrDefault(option.getOptionId(), 0);
        %>
        <li><%= option.getOptionText() %> (<%= votes %> votes)</li>
        <%
            }
        %>
    </ul>
    <canvas id="chart-<%= poll.getPollId() %>"></canvas>
    <script>
        const ctx<%= poll.getPollId() %> = document.getElementById('chart-<%= poll.getPollId() %>').getContext('2d');
        new Chart(ctx<%= poll.getPollId() %>, {
            type: 'bar',
            data: {
                labels: [<% for (Option option : options) { %>'<%= option.getOptionText() %>',<% } %>],
                datasets: [{
                    label: 'Votes',
                    data: [<% for (Option option : options) { %><%= voteCounts.getOrDefault(option.getOptionId(), 0) %>,<% } %>],
                    backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0']
                }]
            },
            options: {
                scales: { y: { beginAtZero: true, ticks: { stepSize: 1 } } },
                plugins: { title: { display: true, text: '<%= poll.getQuestion() %> Results' } }
            }
        });
    </script>
    <%
                } else {
                    out.println("<p class='error'>Poll not found.</p>");
                }
            } catch (SQLException e) {
                out.println("<p class='error'>Error retrieving poll results: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } catch (NumberFormatException e) {
                out.println("<p class='error'>Invalid poll ID.</p>");
            }
        } else {
            out.println("<p class='error'>Please select a poll to view results.</p>");
        }
    %>
    <p><a href="manage-polls.jsp">Back to Manage Polls</a></p>
</body>
</html>