package com.polling.model;

public class Vote {
    private int voteId;
    private int optionId;

    public Vote() {}
    public Vote(int voteId, int optionId) {
        this.voteId = voteId;
        this.optionId = optionId;
    }

    public int getVoteId() { return voteId; }
    public void setVoteId(int voteId) { this.voteId = voteId; }
    public int getOptionId() { return optionId; }
    public void setOptionId(int optionId) { this.optionId = optionId; }
}