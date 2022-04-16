package repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import model.GoodsPaymentDTO;
import model.MemberDTO;
import model.PaymentDTO;

public class MemberRepository {
	
	@Autowired
	SqlSession sqlSession;
	
	String namespace = "mappers.memberMapper";
	String statement;
	
	
	public void memJoin(MemberDTO dto) {
		statement = namespace + ".memJoin";
		sqlSession.insert(statement, dto);
	}
	
	
	public MemberDTO memDetail(String memId) {
		statement = namespace + ".memDetail";
		return sqlSession.selectOne(statement, memId);
	}
	
	public void memQuit(String userId) {
		statement = namespace +".memQuit";
		sqlSession.delete(statement,userId);
	}
	
	public void memModifyCfm(MemberDTO dto) {
		statement = namespace + ".memModifyCfm";
		sqlSession.update(statement,dto);
	}
	
	public void memPwChangCfm(MemberDTO dto) {
		statement = namespace + ".memPwChangCfm";
		sqlSession.update(statement,dto);
	}

	public int CheckBalance(String memId) {
		statement = namespace + ".CheckBalance";
		return sqlSession.selectOne(statement,memId);
	}
	
	public void paymentSuccess(MemberDTO dto) {
		statement = namespace + ".paymentSuccess";
		sqlSession.update(statement,dto);
	}
	
	public int Pnum() {
		statement = namespace + ".Pnum";
		return sqlSession.selectOne(statement);
	}
	
	public void paymentInsert(PaymentDTO dto) {
		statement = namespace +".paymentInsert";
		sqlSession.insert(statement,dto);
	}
	
	public int count(String memId) {
		statement = namespace + ".count";
		return sqlSession.selectOne(statement,memId);
	}
	
	public int mcount(String memId) {
		statement = namespace + ".mcount";
		return sqlSession.selectOne(statement,memId);
	}
	
	public List<PaymentDTO> paymentDe(PaymentDTO dto){
		statement = namespace + ".paymentDe";
		return sqlSession.selectList(statement, dto);
	}
	
	public void UpPaySuccess(MemberDTO dto) {
		statement = namespace + ".UpPaySuccess";
		sqlSession.update(statement, dto);
	}
	
	public void orderpayment(GoodsPaymentDTO dto) {
		statement = namespace + ".orderpayment";
		sqlSession.insert(statement,dto);
	}
	
	public List<GoodsPaymentDTO> myPage(GoodsPaymentDTO dto){
		statement = namespace + ".myPage";
		return sqlSession.selectList(statement, dto);
	}
	

}
