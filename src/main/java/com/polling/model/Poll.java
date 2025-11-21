package com.polling.model;

public class Poll {
    private int pollId;
    private String question;

    public Poll() {}
    public Poll(int pollId, String question) {
        this.pollId = pollId;
        this.question = question;
    }

    public int getPollId() { return pollId; }
    public void setPollId(int pollId) { this.pollId = pollId; }
    public String getQuestion() { return question; }
    public void setQuestion(String question) { this.question = question; }
}