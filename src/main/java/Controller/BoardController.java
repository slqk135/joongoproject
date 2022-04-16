package Controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.maven.shared.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import command.BoardCommand;
import command.QuestionCommand;
import model.SmarteditorDTO;
import service.BoardClearService;
import service.BoardDetailService;
import service.BoardService;
import service.MemberJoinService;

@Controller
@RequestMapping("board")
public class BoardController {
	@Autowired
	BoardService boardService;
	@Autowired
	BoardDetailService boardDetailService;
	@Autowired
	MemberJoinService memberJoinService;
	@Autowired
	BoardClearService boardClearService;
	
	@RequestMapping("myGoods")
	public String myGoods(@RequestParam(value="page", defaultValue ="1")Integer page,HttpSession session, Model model) {
		boardService.boardSearch(page,session, model);
		return "board/myGoods";
	}
	
	@RequestMapping("category")
	public String category(@RequestParam(value = "category") String category,@RequestParam(value="page", defaultValue ="1")Integer page, Model model) {
		boardService.boardList(category,page, model);
		return "board/category";
	}
	
	@RequestMapping("boardContent")
	public String boardContent(@RequestParam(value="boardNum")int boardNum,Model model) {
		boardDetailService.boardContent(boardNum, model);
		boardDetailService.boardQuestion(boardNum, model);
		return "board/boardContent";
	}
	
	@RequestMapping("boardCreate")
	public String boardCreate(HttpSession session, Model model) {
		memberJoinService.memDetail(session, model);
		return "board/boardCreate";
	}
	
	@RequestMapping("boardCreateSave")
	public String boardCreateSave(HttpServletRequest request,BoardCommand boardCommand,HttpSession session) {
		boardService.boardCreateSave(request,boardCommand, session);
		return "redirect:/";
	}
	
	@RequestMapping("boardClear")
	public String boardClear(@RequestParam(value="boardNum")int boardNum) {
		boardClearService.boardClear(boardNum);
		return "redirect:/";
	}
	
	@RequestMapping("categoryMuti")
	public String categoryMuti(@RequestParam(value="boardTitle")String boardTitle,@RequestParam(value="page", defaultValue ="1")Integer page,Model model) {
		boardService.categoryMuti(boardTitle,page, model);
		return "board/categoryMuti";
	}
	
	@PostMapping("AddQeustion")
	@ResponseBody
	public String AddQuestion(@RequestParam("boardNum")int boardNum,String question,HttpSession session) {
		boardDetailService.AddQuestion(boardNum, question,session);
		return "redirect:/";
	}
	
	@PostMapping("QuestionCle")
	@ResponseBody
	public String QuestionCle(@RequestParam(value="QuestionNum")int boardQuestionNum) {
		boardDetailService.QuestionCle(boardQuestionNum);
		return "redirect:/";
	}
	
	@RequestMapping("boardMo")
	public String baordMo(@RequestParam(value="boardNum")int boardNum, Model model) {
		boardDetailService.boardContent(boardNum, model);
		return "board/boardMo";
	}
	
	@RequestMapping("boardCreateMo")
	public String boardCreateMo(HttpServletRequest request,BoardCommand boardCommand) {
		boardService.boardMo(request, boardCommand);
		return "redirect:/";
	}
	
	@PostMapping("PaySuccess")
	@ResponseBody
	public String PaySuccess(@RequestParam("price") int price,HttpSession session, Model model) {
		memberJoinService.UpPaySuccess(price, session, model);
		System.out.println(price);
		return "redirect:/";
	}

	@RequestMapping("file_uploader.jsp")
	public String singleImageUploader(HttpServletRequest req, SmarteditorDTO smarteditorDTO) throws UnsupportedEncodingException {
		System.out.println("클릭==============================");
		String callback = smarteditorDTO.getCallback();
		String callback_func = smarteditorDTO.getCallback_func();
		String file_result = "";
		String result = "";
		MultipartFile multipartFile = smarteditorDTO.getFiledate();
		
		try {
			if(multipartFile != null && multipartFile.getSize() > 0 && StringUtils.isNotBlank(multipartFile.getName())) {
				if(multipartFile.getContentType().toLowerCase().startsWith("image/")) {
					String oriName = multipartFile.getName();
					String uploadPath = req.getServletContext().getRealPath("/img");
					String path = uploadPath + "/smarteditor";
					File file = new File(path);
					if(!file.exists()) {
						file.mkdirs();
					}
					String fileName = UUID.randomUUID().toString();
					smarteditorDTO.getFiledate().transferTo(new File(path + fileName));
					file_result += "&bNewLine=true&FileName=" + oriName + "&FileURL=/img/smarteditor" + fileName;
				}else {
					file_result += "&errstr=error";
				}
				
			}else {
				file_result += "&errstr=error";
			}			
			}catch(Exception e) {
				e.printStackTrace();
			}
		result = "redirect:" + callback + "?callback_func=" + URLEncoder.encode(callback_func,"UTF-8") + file_result;
		return result;
		}
}
