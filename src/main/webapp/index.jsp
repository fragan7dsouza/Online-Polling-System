<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Online Polling System</title>
    <link rel="stylesheet" href="style.css">
    <style>
        .hero {
            text-align: center;
            padding: 100px 20px;
            background: linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.4)), url('https://source.unsplash.com/random/1600x900/?vote,poll') no-repeat center center/cover;
            color: white;
            border-radius: 15px;
            margin: 40px auto;
            max-width: 1000px;
            
        }
        .hero h1 {
            font-size: 4rem;
            margin-bottom: 20px;
        }
        .hero p {
            font-size: 1.5rem;
            margin-bottom: 50px;
            opacity: 0.9;
        }
        .btn-large {
            display: inline-block;
            padding: 20px 50px;
            font-size: 1.6rem;
            margin: 15px;
            border-radius: 50px;
            transition: all 0.3s;
            min-width: 280px;
        }
        .btn-vote {
            background: #e74c3c;
        }
        .btn-vote:hover {
            background: #c0392b;
            transform: translateY(-5px);
        }
        .btn-manage {
            background: #3498db;
        }
        .btn-manage:hover {
            background: #2980b9;
            transform: translateY(-5px);
        }
    </style>
</head>
<body>

<div class="hero">
    <h1>Online Polling System</h1>
    <p>Cast your vote or manage polls easily and securely</p>
    
    <div class="home-links">
        <a href="polls-for-voting.jsp" class="btn btn-large btn-vote">
            Cast Your Vote
        </a>
        <a href="manage-polls.jsp" class="btn btn-large btn-manage">
            Manage Polls
        </a>
    </div>
</div>
</body>
</html>