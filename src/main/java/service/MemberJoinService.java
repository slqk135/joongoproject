package service;

import java.util.Base64;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import Controller.PageAction;
import command.MemberCommand;
import model.AuthInfoDTO;
import model.BoardDTO;
import model.GoodsPaymentDTO;
import model.MemberDTO;
import model.PaymentDTO;
import model.StartEndPageDTO;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;
import repository.BoardRepository;
import repository.MemberRepository;

public class MemberJoinService {
	
	@Autowired
	MemberRepository memberRepository;
	@Autowired
	BoardRepository boardRepository;
	
	
	public void memJoin(MemberCommand memberCommand) {
		MemberDTO dto = new MemberDTO();
		
		dto.setMemAddress(memberCommand.getMemAddress());
		dto.setMemBalance(memberCommand.getMemBalance());
		dto.setMemEmail(memberCommand.getMemEmail());
		dto.setMemId(memberCommand.getMemId());
		dto.setMemIdCard(memberCommand.getMemIdCard());
		dto.setMemName(memberCommand.getMemName());
		dto.setMemPhone(memberCommand.getMemPhone());
		// 비밀번호 Base64 암호화
		String pass = memberCommand.getMemPw();
		dto.setMemPw(Base64.getEncoder().encodeToString(pass.getBytes()));
		
		memberRepository.memJoin(dto);
	}
	

	
	public void memDetail(HttpSession session, Model model) {
		AuthInfoDTO authInfo = (AuthInfoDTO)session.getAttribute("authInfo");
		String memId = authInfo.getMemId();
		MemberDTO dto = memberRepository.memDetail(memId);
		model.addAttribute("Mdto", dto);
	}
	
	public void memQuit(HttpSession session) {
		AuthInfoDTO authInfo = (AuthInfoDTO)session.getAttribute("authInfo");
		String memId = authInfo.getMemId();
		memberRepository.memQuit(memId);
	}
	
	public void memModifyCfm(MemberCommand memberCommand,HttpSession session) {
		MemberDTO dto = new MemberDTO();
		AuthInfoDTO authInfo = (AuthInfoDTO)session.getAttribute("authInfo");
		
		dto.setMemId(authInfo.getMemId());
		dto.setMemEmail(memberCommand.getMemEmail());
		dto.setMemAddress(memberCommand.getMemAddress());
		dto.setMemPhone(memberCommand.getMemPhone());
		
		memberRepository.memModifyCfm(dto);
		
	}
	
	public void memPwChangCfm(MemberCommand memberCommand, HttpSession session) {
		MemberDTO dto = new MemberDTO();
		AuthInfoDTO authInfo = (AuthInfoDTO)session.getAttribute("authInfo");
		
		dto.setMemId(authInfo.getMemId());
		String pass = memberCommand.getMemPw();
		dto.setMemPw(Base64.getEncoder().encodeToString(pass.getBytes()));
		
		memberRepository.memPwChangCfm(dto);

	}
	
	public void certifiedPhoneNumber(String userPhoneNumber, int radomNumber) {
		String api_key = "NCSUBP3D3AB3Y8GS";
		String api_secret = "H9W9YVRHZBNOAL3JVK1JFHSBQJRNCU4T";
		Message coolsms = new Message(api_key, api_secret);
		
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", userPhoneNumber);
		params.put("from", "01054960903");
		params.put("type", "SMS");
		params.put("text", "[TEXT]인증번호는" + "["+ radomNumber+"]" + "입니다.");
		params.put("app_version", "test app 1.2");
		
		try {
			JSONObject obj = (JSONObject) coolsms.send(params);
			System.out.println(obj.toString());
		}catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
	}
	
	public void paymentSuccess(int price, String memId) {
		MemberDTO dto = new MemberDTO();
		dto.setMemId(memId);
		int Cprice = memberRepository.CheckBalance(memId);
		int Pprice = Cprice += price;
		dto.setMemBalance(Pprice);
		
		memberRepository.paymentSuccess(dto);
		
	}
	
	public void paymentInsert(int price, String content ,String memId) {
		PaymentDTO dto = new PaymentDTO();
		
		dto.setMemId(memId);
		dto.setPaymentPrice(price);
		int num = memberRepository.Pnum();
		int Pnum = num+1;
		dto.setPaymentNum(Pnum);
		dto.setPaymentContent(content);
		
		memberRepository.paymentInsert(dto);
		
	}
	
	public void paymentDe(HttpSession session ,Integer page, Model model) {
		AuthInfoDTO authInfo = (AuthInfoDTO)session.getAttribute("authInfo");
		String memId = authInfo.getMemId();
		PaymentDTO dto = new PaymentDTO();
		
		int limit = 5;
		int limitPage = 10;
		
		if(page != null) {
			int start = (page -1) * limit +1;
			int end = start + limit -1;
			String startRow = String.valueOf(start);
			String endRow = String.valueOf(end);
			StartEndPageDTO sep = new StartEndPageDTO();
			sep.setStartRow(startRow);
			sep.setEndRow(endRow);
			dto.setStartEndPageDTO(sep);
		}
		dto.setMemId(memId);
		int count = memberRepository.count(memId);
		List<PaymentDTO> Plist = memberRepository.paymentDe(dto);
		model.addAttribute("Plist", Plist);
		model.addAttribute("count",count);
		if(page != null) {
			PageAction pageAction = new PageAction();
			pageAction.page(count, limit, page, limitPage, model, "paymentDe");
		}
		
	}
	
	public void myPage(Integer page,HttpSession session, Model model) {
		AuthInfoDTO authInfo = (AuthInfoDTO)session.getAttribute("authInfo");
		String memId = authInfo.getMemId();
		GoodsPaymentDTO dto = new GoodsPaymentDTO();
		int limit = 10;
		int limitPage = 10;
		
		if(page != null) {
			int start = (page -1) * limit +1;
			int end = start + limit -1;
			String startRow = String.valueOf(start);
			String endRow = String.valueOf(end);
			StartEndPageDTO sep = new StartEndPageDTO();
			sep.setStartRow(startRow);
			sep.setEndRow(endRow);
			dto.setStartEndPageDTO(sep);
		}
		dto.setSellMemId(memId);
		int count = memberRepository.count(memId);
		List<GoodsPaymentDTO> Mlist = memberRepository.myPage(dto);
		model.addAttribute("Mlist", Mlist);
		model.addAttribute("count",count);
		if(page != null) {
			PageAction pageAction = new PageAction();
			pageAction.page(count, limit, page, limitPage, model, "myPageMain");
		}
	}
	
	public void UpPaySuccess(int price, HttpSession session, Model model) {
		AuthInfoDTO authInfo = (AuthInfoDTO)session.getAttribute("authInfo");
		String memId = authInfo.getMemId();
		int memBalance = authInfo.getMemBalance();
		int Balance = memBalance - price;
		MemberDTO dto = new MemberDTO();
		
		dto.setMemId(memId);
		dto.setMemBalance(Balance);
		
		memberRepository.UpPaySuccess(dto);
	}
	
	public void orderpayment(int price,int boardNum,String memId, HttpSession session) {
		AuthInfoDTO authInfo = (AuthInfoDTO)session.getAttribute("authInfo");
		String orderMemId = authInfo.getMemId();
		
		GoodsPaymentDTO dto = new GoodsPaymentDTO();
		int num = memberRepository.Pnum();
		dto.setPaymentNum(num);
		dto.setOrderMemId(orderMemId);
		dto.setSellMemId(memId);
		dto.setBoardNum(boardNum);
		
		MemberDTO mdto = new MemberDTO();
		int balance = memberRepository.CheckBalance(memId);
		int Pbalance = balance + price;
		
		
		mdto.setMemId(memId);
		mdto.setMemBalance(Pbalance);
		
		boardRepository.boardState(boardNum);
		memberRepository.paymentSuccess(mdto);
		memberRepository.orderpayment(dto);
		
	}



}
