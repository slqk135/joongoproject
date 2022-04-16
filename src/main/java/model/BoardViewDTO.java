package model;

import java.sql.Date;

public class BoardViewDTO {
	String memId;
	String memEmail;
	String memPhone;
	Integer boardNum;
	String boardTitle;
	String boardContent;
	Date boardDate;
	String goodsPrice;
	String goodsImg;
	String boardCategory;
	Integer boardCount;
	String boardPay;
	String visible;
	String goodsName;
	String goodsState;
	String boardState;
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memID) {
		this.memId = memID;
	}
	public Integer getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(Integer boardNum) {
		this.boardNum = boardNum;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBardTitle(String bardTitle) {
		this.boardTitle = bardTitle;
	}
	public String getBoardContent() {
		return boardContent;
	}
	public void setBardContent(String bardContent) {
		this.boardContent = bardContent;
	}
	public Date getBoardDate() {
		return boardDate;
	}
	public void setBoardDate(Date boardDate) {
		this.boardDate = boardDate;
	}
	public String getGoodsPrice() {
		return goodsPrice;
	}
	public void setGoodsPrice(String goodsPrice) {
		this.goodsPrice = goodsPrice;
	}
	public String getGoodsImg() {
		return goodsImg;
	}
	public void setGoodsImg(String goodsImg) {
		this.goodsImg = goodsImg;
	}
	public String getBoardCategory() {
		return boardCategory;
	}
	public void setBoardCategory(String boardCategory) {
		this.boardCategory = boardCategory;
	}
	public Integer getBoardCount() {
		return boardCount;
	}
	public void setBoardCount(Integer boardCount) {
		this.boardCount = boardCount;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}
	public String getMemEmail() {
		return memEmail;
	}
	public void setMemEmail(String memEmail) {
		this.memEmail = memEmail;
	}
	public String getMemPhone() {
		return memPhone;
	}
	public void setMemPhone(String memPhone) {
		this.memPhone = memPhone;
	}
	public String getBoardPay() {
		return boardPay;
	}
	public void setBoardPay(String boardPay) {
		this.boardPay = boardPay;
	}
	public String getVisible() {
		return visible;
	}
	public void setVisible(String visible) {
		this.visible = visible;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public String getGoodsState() {
		return goodsState;
	}
	public void setGoodsState(String goodsState) {
		this.goodsState = goodsState;
	}
	public String getBoardState() {
		return boardState;
	}
	public void setBoardState(String boardState) {
		this.boardState = boardState;
	}
	

}
