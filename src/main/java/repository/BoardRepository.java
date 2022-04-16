package repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import model.BoardDTO;
import model.MyBoardDTO;

public class BoardRepository {
	
	@Autowired
	SqlSession sqlSession;
	
	String namespace = "mappers.BoardMapper";
	String statement;
	
	public List<MyBoardDTO> boardSearch(MyBoardDTO dto) {
		statement = namespace + ".myGoods";
		return sqlSession.selectList(statement, dto);
		
	}
	
	public List<BoardDTO> boardList(BoardDTO dto){
		statement = namespace + ".boardList";
		return sqlSession.selectList(statement,dto);
	}
	
	public int boardNum() {
		statement= namespace +".boardCount";
		int boardNum = sqlSession.selectOne(statement);
		return boardNum;
		
	}
	
	public void boardCreateSave(BoardDTO dto) {
		statement = namespace + ".boardCreateSave";
		sqlSession.insert(statement, dto);
	}
	
	public void BoardClear(int boardNum) {
		statement = namespace + ".BoardClear";
		sqlSession.update(statement,boardNum);
	}
	
	public List<BoardDTO> categoryMuti(String boardTitle){
		statement = namespace + ".categoryMuti";
		String str = "%" + boardTitle + "%";
		return sqlSession.selectList(statement,str);
	}
	
	public void boardMoSave(BoardDTO dto) {
		statement = namespace + ".boardMoSave";
		sqlSession.update(statement, dto);
	}
	
	public int count(String category) {
		statement = namespace + ".count";
		return sqlSession.selectOne(statement,category);
	}
	
	public int Mycount(String memId) {
		statement = namespace + ".Mycount";
		return sqlSession.selectOne(statement,memId);
	}
	
	public int Muticount(String boardTitle) {
		statement = namespace + ".Muticount";
		String str = "%" + boardTitle + "%";
		return sqlSession.selectOne(statement,str);
	}
	
	public void boardState(int boardNum) {
		statement = namespace + ".boardState";
		sqlSession.selectOne(statement,boardNum);
	}
}
