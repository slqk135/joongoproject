package model;

import java.sql.Date;

public class GoodsPaymentDTO {
	
	Integer paymentNum;
	String boardTitle;
	Integer goodsPrice;
	String sellMemId;
	String orderMemId;
	Integer boardNum;
	Date orderDate;
	String orderState;
	StartEndPageDTO startEndPageDTO;
	public Integer getPaymentNum() {
		return paymentNum;
	}
	public void setPaymentNum(Integer paymentNum) {
		this.paymentNum = paymentNum;
	}
	public String getSellMemId() {
		return sellMemId;
	}
	public void setSellMemId(String sellMemId) {
		this.sellMemId = sellMemId;
	}
	public String getOrderMemId() {
		return orderMemId;
	}
	public void setOrderMemId(String orderMemId) {
		this.orderMemId = orderMemId;
	}
	public Integer getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(Integer boardNum) {
		this.boardNum = boardNum;
	}
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	public String getOrderState() {
		return orderState;
	}
	public void setOrderState(String orderState) {
		this.orderState = orderState;
	}
	public StartEndPageDTO getStartEndPageDTO() {
		return startEndPageDTO;
	}
	public void setStartEndPageDTO(StartEndPageDTO startEndPageDTO) {
		this.startEndPageDTO = startEndPageDTO;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public Integer getGoodsPrice() {
		return goodsPrice;
	}
	public void setGoodsPrice(Integer goodsPrice) {
		this.goodsPrice = goodsPrice;
	}
	
	

}
