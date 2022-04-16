package Controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import command.MemberCommand;
import service.MemberJoinService;

@Controller
@RequestMapping("member")
public class MemberController {
	

	@Autowired
	MemberJoinService memberJoinService;
	


	@RequestMapping(value ="memJoin", method = RequestMethod.POST)
	public String join(MemberCommand memberCommand) {
		
		memberJoinService.memJoin(memberCommand);
		return "main/main";
	}
	
	
	@RequestMapping("memDetail")
	public String memDetail(HttpSession session, Model model) {
		memberJoinService.memDetail(session, model);
		return "member/memDetail";
	}
	
	@RequestMapping("memQuit")
	public String memQuit(HttpSession session) {
		memberJoinService.memQuit(session);
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping("memModify")
	public String memModify(HttpSession session, Model model) {
		memberJoinService.memDetail(session, model);
		return "member/memModify";
	}
	
	@RequestMapping("memModifyCfm")
	public String memModifyCfm(MemberCommand memberCommand, HttpSession session) {
		memberJoinService.memModifyCfm(memberCommand, session);
		return "redirect:memDetail";
	}
	
	@RequestMapping("myPageMain")
	public String myPage(@RequestParam(value="page", defaultValue = "1")Integer page,HttpSession session, Model model) {
		memberJoinService.myPage(page, session, model);
		return "member/memMyPage";
	}
	
	@RequestMapping("memPwChange")
	public String memPwChange() {
		
		return "member/memPwChange";
	}
	
	@RequestMapping("memPwChangCfm")
	public String memPwChangCfm(MemberCommand memberCommand, HttpSession session) {
		
		memberJoinService.memPwChangCfm(memberCommand, session);
		
		return "redirect:memDetail";
	}
	
	@RequestMapping(value="phoneCheck", method = RequestMethod.GET)
	@ResponseBody
	public String sendSMS(@RequestParam("phone")String userPhoneNumber) {
		int radomNumber = (int)((Math.random()*(9999 - 1000 + 1))+1000);
		memberJoinService.certifiedPhoneNumber(userPhoneNumber, radomNumber);
		return Integer.toString(radomNumber);
	}
	
	@RequestMapping("joongoPay")
	public String joongoPay(HttpSession session, Model model) {
		memberJoinService.memDetail(session, model);
		return "member/joongoPay";
	}
	
	@PostMapping("paymentSuccess")
	@ResponseBody
	public String paymentSuccess(@RequestParam("price")int price,String memId) {
		memberJoinService.paymentSuccess(price, memId);
		return "redirect:/";
	}
	
	@RequestMapping("paymentDe")
	public String paymentDe(@RequestParam(value="page", defaultValue = "1")Integer page,HttpSession session,Model model) {
		memberJoinService.paymentDe(session, page, model);
		return "member/paymentDe";
	}
	
	@PostMapping("paymentInsert")
	@ResponseBody
	public String paymentInsert(@RequestParam("price")int price,@RequestParam("content")String content , String memId) {
		memberJoinService.paymentInsert(price,content, memId);
		return "redirect:/";
	}
	
	@PostMapping("orderpayment")
	@ResponseBody
	public String orderpayment(@RequestParam("price")int price,int boardNum,String memId,HttpSession session) {
		memberJoinService.orderpayment(price,boardNum ,memId, session);
		return "redirect:/";
	}
	

}
