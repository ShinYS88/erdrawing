package kr.or.ddit.erd.dao;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.ddit.erd.model.ChatVo;
import kr.or.ddit.erd.model.DomainVo;
import kr.or.ddit.erdhistory.model.ErdHistVo;

@Repository("erdDrawingDao")
public class ErdDrawingDaoImpl implements IErdDrawingDao{
	
	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<DomainVo> domainList(int erdNo){
		return sqlSession.selectList("erdDrawing.domainList", erdNo);
	}
	
	@Override
	public int domainDelete(int domainNo){
		return sqlSession.delete("erdDrawing.domainDelete", domainNo);
	}
	
	@Override
	public int domainModify(DomainVo domainVo){
		return sqlSession.update("erdDrawing.domainModify", domainVo);
	}
	
	@Override
	public int domainInsert(DomainVo domainVo){
		return sqlSession.insert("erdDrawing.domainInsert", domainVo);
	}
	
	@Override
	public List<DomainVo> domainSearch(DomainVo domainVo){
		return sqlSession.selectList("erdDrawing.domainSearch", domainVo);
	}
	
	@Override
	public int erdHistInsert(ErdHistVo erdHistVo){
		
		int cnt = sqlSession.selectOne("erdDrawing.selectCntHist",erdHistVo);
		
		if(cnt >= 20){
			//update
			sqlSession.update("erdDrawing.erdHistUpdate",erdHistVo);
		}else{
			//insert
			sqlSession.insert("erdDrawing.erdHistInsert",erdHistVo);
		}
		
		return 0; 
	}
	
	@Override
	public ErdHistVo erdMaxHistSelect(int erdNo){
		return sqlSession.selectOne("erdDrawing.erdMaxHistSelect",erdNo);
	}
	
	
	@Override
	public List<ErdHistVo> erdHistList(int erdNo){
		return sqlSession.selectList("erdDrawing.erdHistList",erdNo);
	}
	
	
	@Override
	public List<ErdHistVo> erdSnapList(int erdNo){
		return sqlSession.selectList("erdDrawing.erdSnapList",erdNo);
	}

	@Override
	public int chatInsert(ChatVo chatVo) {
		return sqlSession.insert("erdDrawing.chatInsert", chatVo);
	}

	@Override
	public List<ChatVo> chatList(int erdNo) {
		return sqlSession.selectList("erdDrawing.chatList", erdNo);
	}
	
}
