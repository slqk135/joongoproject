package repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import command.LoginCommand;
import model.AuthInfoDTO;
import model.MemberDTO;

public class LoginRepository {
	
	@Autowired
	SqlSession sqlSession;
	
	String namespace = "mappers.loginMapper";
	String statement;
	
	
	public int idCheck(String userId) {
		statement = namespace + ".idCheck";
		int cnt = sqlSession.selectOne(statement,userId);
		return cnt;
		
	}
	
	public int memberCheck(LoginCommand dto) {

		statement = namespace + ".memberCheck";
		int cnt = sqlSession.selectOne(statement, dto);
		return cnt;
	}
	
	public AuthInfoDTO logIn(String userId) {
		statement = namespace + ".memberLogin";
		return sqlSession.selectOne(statement,userId);
	}
}
