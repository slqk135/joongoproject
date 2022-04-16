package model;

import org.springframework.web.multipart.MultipartFile;

public class SmarteditorDTO {
	MultipartFile filedate;
	String callback;
	String callback_func;
	public MultipartFile getFiledate() {
		return filedate;
	}
	public void setFiledate(MultipartFile filedate) {
		this.filedate = filedate;
	}
	public String getCallback() {
		return callback;
	}
	public void setCallback(String callback) {
		this.callback = callback;
	}
	public String getCallback_func() {
		return callback_func;
	}
	public void setCallback_func(String callback_func) {
		this.callback_func = callback_func;
	}
	

}
