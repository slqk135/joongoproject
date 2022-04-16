package command;

import java.sql.Date;

public class QuestionCommand {
	
	String memId;
	Integer boardNum;
	Integer boardQuestionNum;
	Date boardQuestionDate;
	String boardQuestionContent;
	String memName;
	String boardQuestionSecret;
	String state;
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public Integer getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(Integer boardNum) {
		this.boardNum = boardNum;
	}
	public Integer getBoardQuestionNum() {
		return boardQuestionNum;
	}
	public void setBoardQuestionNum(Integer boardQuestionNum) {
		this.boardQuestionNum = boardQuestionNum;
	}
	public Date getBoardQuestionDate() {
		return boardQuestionDate;
	}
	public void setBoardQuestionDate(Date boardQuestionDate) {
		this.boardQuestionDate = boardQuestionDate;
	}
	public String getBoardQuestionContent() {
		return boardQuestionContent;
	}
	public void setBoardQuestionContent(String boardQuestionContent) {
		this.boardQuestionContent = boardQuestionContent;
	}
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public String getBoardQuestionSecret() {
		return boardQuestionSecret;
	}
	public void setBoardQuestionSecret(String boardQuestionSecret) {
		this.boardQuestionSecret = boardQuestionSecret;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	

}
