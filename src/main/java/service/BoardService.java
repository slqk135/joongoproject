package service;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import Controller.PageAction;
import command.BoardCommand;
import model.AuthInfoDTO;
import model.BoardDTO;
import model.MyBoardDTO;
import model.StartEndPageDTO;
import repository.BoardRepository;

public class BoardService {
	@Autowired
	BoardRepository boardRepository;
	
	public void boardSearch(Integer page,HttpSession session, Model model) {
		AuthInfoDTO authInfo = (AuthInfoDTO)session.getAttribute("authInfo");
		String memId = authInfo.getMemId();
		MyBoardDTO dto = new MyBoardDTO();
		int limit = 10;
		int limitPage = 10;
		if(page != null) {
			int start = (page - 1) * limit +1 ;
			int end = start + limit - 1;
			String startRow = String.valueOf(start);
			String endRow = String.valueOf(end);
			StartEndPageDTO sep = new StartEndPageDTO();
			sep.setStartRow(startRow);
			sep.setEndRow(endRow);
			dto.setStartEndPageDTO(sep);
		}
		dto.setMemId(memId);
		List<MyBoardDTO> board = boardRepository.boardSearch(dto);
		int count = boardRepository.Mycount(memId);
		model.addAttribute("board", board);
		model.addAttribute("count",count);
		if(page != null) {
			PageAction pageAction = new PageAction();
			pageAction.page(count, limit, page, limitPage, model, "myGoods");
		}
		
	}
	
	public void boardList(String category,Integer page, Model model) {
		BoardDTO dto = new BoardDTO();
		int limit = 20;
		int limitPage = 10;
		if(page != null) {
			int start = (page - 1) * limit +1 ;
			int end = start + limit - 1;
			String startRow = String.valueOf(start);
			String endRow = String.valueOf(end);
			StartEndPageDTO sep = new StartEndPageDTO();
			sep.setStartRow(startRow);
			sep.setEndRow(endRow);
			dto.setStartEndPageDTO(sep);
		}
		dto.setBoardCategory(category);
		List<BoardDTO> Blist = boardRepository.boardList(dto);
		int count = boardRepository.count(category);
		model.addAttribute("Blist", Blist);
		model.addAttribute("count",count);
		if(page != null) {
			PageAction pageAction = new PageAction();
			pageAction.page(count, limit, page, limitPage, model, "category");
		}
	}
	
	public void categoryMuti(String boardTitle,Integer page ,Model model) {
		BoardDTO dto = new BoardDTO();
		int limit = 20;
		int limitPage = 10;
		if(page != null) {
			int start = (page - 1) * limit +1;
			int end = start + limit -1;
			String startRow = String.valueOf(start);
			String endRow = String.valueOf(end);
			StartEndPageDTO sep = new StartEndPageDTO();
			sep.setStartRow(startRow);
			sep.setEndRow(endRow);
			dto.setStartEndPageDTO(sep);
		}
		dto.setBoardTitle(boardTitle);
		int count = boardRepository.Muticount(boardTitle);
		List<BoardDTO> Blist = boardRepository.categoryMuti(boardTitle);
		model.addAttribute("Blist",Blist);
		model.addAttribute("count",count);
		if(page != null) {
			PageAction pageAction = new PageAction();
			pageAction.page(count, limit, page, limitPage, model, "categoryMuti");
		}
	}
	
	public void boardCreateSave(HttpServletRequest request,BoardCommand boardCommand,HttpSession session) {
		BoardDTO dto = new BoardDTO();
		AuthInfoDTO authInfo = (AuthInfoDTO)session.getAttribute("authInfo");

		dto.setBoardCategory(boardCommand.getBoardCategory());
		dto.setBoardContent(request.getParameter("boardContent"));
		dto.setBoardCount(boardCommand.getBoardCount());
		int Num = boardRepository.boardNum();
		Num += 1;
		dto.setBoardNum(Num);
		dto.setMemId(authInfo.getMemId());
		dto.setBoardPay(boardCommand.getBoardPay());
		dto.setBoardTitle(boardCommand.getBoardTitle());
		dto.setGoodsPrice(boardCommand.getGoodsPrice());
		dto.setVisible(boardCommand.getVisible());
		dto.setGoodsName(boardCommand.getGoodsName());
		dto.setGoodsState(boardCommand.getGoodsState());
		dto.setBoardState(boardCommand.getBoardState());
		if(!boardCommand.getGoodsImg().getOriginalFilename().isEmpty()) {
			MultipartFile mf = boardCommand.getGoodsImg();
			String original = mf.getOriginalFilename();
			/// 확장자
			String originalExt = original.substring(original.lastIndexOf("."));
			String store = UUID.randomUUID().toString().replace("-", "")
					     + originalExt;
			String realPath = session.getServletContext().getRealPath("WEB-INF/view/resources/asset/image/reviewImg");
					//"/Users/jaegu/git/baedal/BaedalProject/reviewImg";
			File f = new File(realPath + "/" + store);
			try{mf.transferTo(f);}catch(Exception e) {e.printStackTrace();}
			dto.setGoodsImg(store);			
		}
		
		boardRepository.boardCreateSave(dto);
	}
	
	
	public void boardMo(HttpServletRequest request,BoardCommand boardCommand) {
		BoardDTO dto = new BoardDTO();
		
		dto.setBoardCategory(boardCommand.getBoardCategory());
		dto.setBoardContent(request.getParameter("boardContent"));
		dto.setBoardPay(boardCommand.getBoardPay());
		dto.setBoardTitle(boardCommand.getBoardTitle());
		dto.setGoodsPrice(boardCommand.getGoodsPrice());
		dto.setBoardNum(boardCommand.getBoardNum());
		boardRepository.boardMoSave(dto);
		
	}


}
