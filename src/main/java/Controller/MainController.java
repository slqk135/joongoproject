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

import command.LoginCommand;
import command.MemberCommand;
import service.BoardService;
import service.LogInService;
import service.MemberJoinService;

@Controller
public class MainController {
	
	@Autowired
	LogInService logInService;

	
	@RequestMapping("main")
	public String main() {
		return "main/main";
	}
	
	@RequestMapping("memberForm")
	public String member() {
		return "member/memberForm";
	}
	

	
	@RequestMapping("loginPage")
	public String loginPage() {
		return "main/login";
	}
	

	
	@RequestMapping("logIn")
	public String login(LoginCommand loginCommand, HttpSession session) {
		logInService.logIn(loginCommand, session);
		session.setAttribute("memId", loginCommand.getMemId());
		return "redirect:/";
	}
	
	@RequestMapping("logOut")
	public String logOut(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@PostMapping("memberCheck")
	@ResponseBody
	public int memberCheck(String userId, String userPw) {
		
		int cnt = logInService.memberCheck(userId, userPw);
		return cnt;
	}
	
	@PostMapping("IdCheckService")
	@ResponseBody
	public int IdCheckService(String userId) {
		
		int cnt = logInService.idCheck(userId);
		return cnt;
	}
	



}
