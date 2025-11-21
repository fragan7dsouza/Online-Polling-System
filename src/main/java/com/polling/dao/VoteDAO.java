package com.polling.dao;

import com.polling.util.DBUtil;

import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class VoteDAO {
    public void addVote(int optionId) throws SQLException {
        Connection con = DBUtil.getConnection();
        String query = "INSERT INTO votes (option_id) VALUES (?)";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, optionId);
        ps.executeUpdate();
        ps.close();
        con.close();
    }

    public Map<Integer, Integer> getVoteCounts(int pollId) throws SQLException {
        Map<Integer, Integer> voteCounts = new HashMap<>();
        Connection con = DBUtil.getConnection();
        String query = "SELECT option_id, COUNT(*) as vote_count FROM votes WHERE option_id IN (SELECT option_id FROM options WHERE poll_id = ?) GROUP BY option_id";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, pollId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            voteCounts.put(rs.getInt("option_id"), rs.getInt("vote_count"));
        }
        rs.close();
        ps.close();
        con.close();
        return voteCounts;
    }
}