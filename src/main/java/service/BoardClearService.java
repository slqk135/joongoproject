package service;

import org.springframework.beans.factory.annotation.Autowired;

import model.BoardDTO;
import repository.BoardRepository;

public class BoardClearService {

	@Autowired
	BoardRepository boardRepository;
	
	public void boardClear(int boardNum) {
		boardRepository.BoardClear(boardNum);		
	}
	
}
