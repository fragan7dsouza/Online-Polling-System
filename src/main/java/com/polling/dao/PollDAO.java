package com.polling.dao;

import com.polling.model.Poll;
import com.polling.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PollDAO {
    public void addPoll(Poll poll, List<String> options) throws SQLException {
        Connection con = DBUtil.getConnection();
        try {
            con.setAutoCommit(false);
            String pollQuery = "INSERT INTO polls (question) VALUES (?)";
            PreparedStatement ps = con.prepareStatement(pollQuery, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, poll.getQuestion());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            int pollId = rs.next() ? rs.getInt(1) : 0;
            rs.close();
            ps.close();

            String optionQuery = "INSERT INTO options (poll_id, option_text) VALUES (?, ?)";
            PreparedStatement psOption = con.prepareStatement(optionQuery);
            for (String optionText : options) {
                psOption.setInt(1, pollId);
                psOption.setString(2, optionText.trim());
                psOption.executeUpdate();
            }
            psOption.close();
            con.commit();
        } catch (SQLException e) {
            con.rollback();
            throw e;
        } finally {
            con.setAutoCommit(true);
            con.close();
        }
    }

    public List<Poll> getAllPolls() throws SQLException {
        List<Poll> polls = new ArrayList<>();
        Connection con = DBUtil.getConnection();
        String query = "SELECT * FROM polls";
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery(query);
        while (rs.next()) {
            Poll poll = new Poll();
            poll.setPollId(rs.getInt("poll_id"));
            poll.setQuestion(rs.getString("question"));
            polls.add(poll);
        }
        rs.close();
        stmt.close();
        con.close();
        return polls;
    }

    public Poll getPoll(int pollId) throws SQLException {
        Connection con = DBUtil.getConnection();
        String query = "SELECT * FROM polls WHERE poll_id = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, pollId);
        ResultSet rs = ps.executeQuery();
        Poll poll = null;
        if (rs.next()) {
            poll = new Poll();
            poll.setPollId(rs.getInt("poll_id"));
            poll.setQuestion(rs.getString("question"));
        }
        rs.close();
        ps.close();
        con.close();
        return poll;
    }

    public void updatePoll(Poll poll) throws SQLException {
        Connection con = DBUtil.getConnection();
        String query = "UPDATE polls SET question = ? WHERE poll_id = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, poll.getQuestion());
        ps.setInt(2, poll.getPollId());
        ps.executeUpdate();
        ps.close();
        con.close();
    }

    public void deletePoll(int pollId) throws SQLException {
        Connection con = DBUtil.getConnection();
        String query = "DELETE FROM polls WHERE poll_id = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, pollId);
        ps.executeUpdate();
        ps.close();
        con.close();
    }
}