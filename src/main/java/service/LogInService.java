package service;

import java.util.Base64;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import command.LoginCommand;
import model.AuthInfoDTO;
import repository.LoginRepository;

public class LogInService {
	
	
	@Autowired
	LoginRepository loginRepository;
	
	public AuthInfoDTO logIn(LoginCommand loginCommand, HttpSession session) {
		String userId = loginCommand.getMemId();
		AuthInfoDTO authInfo = loginRepository.logIn(userId);
		session.setAttribute("authInfo", authInfo);
		return authInfo;
	}
	
	public int idCheck(String userId) {
		
		int cnt = loginRepository.idCheck(userId);
		return cnt;
	}
	
	public int memberCheck(String userId, String userPw) {
		LoginCommand dto = new LoginCommand();
		String Pw = Base64.getEncoder().encodeToString(userPw.getBytes());
		dto.setMemId(userId);
		dto.setMemPw(Pw);
		int cnt = loginRepository.memberCheck(dto);
		System.out.println(cnt);
		return cnt;
	}

}
