package com.polling.dao;

import com.polling.model.Option;
import com.polling.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OptionDAO {
    public List<Option> getOptionsByPoll(int pollId) throws SQLException {
        List<Option> options = new ArrayList<>();
        Connection con = DBUtil.getConnection();
        String query = "SELECT * FROM options WHERE poll_id = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, pollId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Option option = new Option();
            option.setOptionId(rs.getInt("option_id"));
            option.setPollId(rs.getInt("poll_id"));
            option.setOptionText(rs.getString("option_text"));
            options.add(option);
        }
        rs.close();
        ps.close();
        con.close();
        return options;
    }

    public void updateOption(Option option) throws SQLException {
        Connection con = DBUtil.getConnection();
        String query = "UPDATE options SET option_text = ? WHERE option_id = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, option.getOptionText());
        ps.setInt(2, option.getOptionId());
        ps.executeUpdate();
        ps.close();
        con.close();
    }
}