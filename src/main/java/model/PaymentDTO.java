package model;

import java.sql.Date;

public class PaymentDTO {

	Integer paymentNum;
	String memId;
	Integer paymentPrice;
	Date paymentDate;
	String paymentState;
	String paymentContent;
	StartEndPageDTO startEndPageDTO;
	public Integer getPaymentNum() {
		return paymentNum;
	}
	public void setPaymentNum(Integer paymentNum) {
		this.paymentNum = paymentNum;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public Integer getPaymentPrice() {
		return paymentPrice;
	}
	public void setPaymentPrice(Integer paymentPrice) {
		this.paymentPrice = paymentPrice;
	}
	public Date getPaymentDate() {
		return paymentDate;
	}
	public void setPaymentDate(Date paymentDate) {
		this.paymentDate = paymentDate;
	}
	public String getPaymentState() {
		return paymentState;
	}
	public void setPaymentState(String paymentState) {
		this.paymentState = paymentState;
	}
	public String getPaymentContent() {
		return paymentContent;
	}
	public void setPaymentContent(String paymentContent) {
		this.paymentContent = paymentContent;
	}
	public StartEndPageDTO getStartEndPageDTO() {
		return startEndPageDTO;
	}
	public void setStartEndPageDTO(StartEndPageDTO startEndPageDTO) {
		this.startEndPageDTO = startEndPageDTO;
	}
	
	
	
}
