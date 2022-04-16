package service;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import command.QuestionCommand;
import model.AuthInfoDTO;
import model.BoardViewDTO;
import model.QuestionDTO;
import repository.BoardDetailRepository;

public class BoardDetailService {
	@Autowired
	BoardDetailRepository boardDetailRepository;
	
	public void boardContent(int boardNum, Model model) {
		boardDetailRepository.bCount(boardNum);
		BoardViewDTO dto = boardDetailRepository.boardContent(boardNum);
		model.addAttribute("bCon", dto);
	}
	
	public void boardQuestion(int boardNum, Model model) {
		List<QuestionDTO> qCon = boardDetailRepository.boardQuestion(boardNum);
		model.addAttribute("qCon",qCon);
	}

	public void AddQuestion(int boardNum, String question,HttpSession session) {
		QuestionDTO dto = new QuestionDTO();
		AuthInfoDTO authInfo = (AuthInfoDTO)session.getAttribute("authInfo");
		
		dto.setBoardNum(boardNum);
		dto.setBoardQuestionContent(question);
		int Num = boardDetailRepository.questionBoardNum(boardNum);
		Num += 1;
		dto.setBoardQuestionNum(Num);
		dto.setMemId(authInfo.getMemId());
		dto.setMemName(authInfo.getMemId());

		boardDetailRepository.questionCreateSave(dto);
		
	}
	
	public void QuestionCle(int boardQuestionNum) {
		boardDetailRepository.QuestionCle(boardQuestionNum);
	}
}
