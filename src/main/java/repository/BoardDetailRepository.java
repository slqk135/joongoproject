package repository;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import model.BoardDTO;
import model.BoardViewDTO;
import model.QuestionDTO;

public class BoardDetailRepository {
	
	@Autowired
	SqlSession sqlSession;
	
	String namespace = "mappers.BoardMapper";
	String statement;
	
	public BoardViewDTO boardContent(int boardNum) {
		statement = namespace + ".boardContent";
		return sqlSession.selectOne(statement,boardNum);
	}
	
	public void bCount(int boardNum) {
		statement = namespace + ".bCount";
		sqlSession.update(statement,boardNum);
	}
	
	public List<QuestionDTO> boardQuestion(int boardNum) {
		statement = namespace + ".boardQuestion";
		return sqlSession.selectList(statement,boardNum);
	}
	
	public int questionBoardNum(int boardNum) {
		statement = namespace + ".questionBoardNum";
		int questionBoardNum = sqlSession.selectOne(statement,boardNum);
		return questionBoardNum;
	}
	
	public void questionCreateSave(QuestionDTO dto) {
		statement = namespace + ".questionCreateSave";
		sqlSession.insert(statement, dto);
	}

	public void QuestionCle(int boardQuestionNum) {
		statement = namespace + ".QuestionCle";
		sqlSession.update(statement,boardQuestionNum);
	}
}
