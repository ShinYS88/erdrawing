package kr.or.ddit.erd.dao;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.ddit.erd.model.ErdLikeVo;
import kr.or.ddit.erd.model.ErdVo;
import kr.or.ddit.erdhistory.model.ErdHistVo;
import kr.or.ddit.util.model.PageVo;

@Repository("erdDao")
public class ErdDaoImpl implements IErdDao{
	
	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int addErd(ErdVo erdVo) {
		return sqlSession.insert("erd.addErd", erdVo);
	}

	@Override
	public List<ErdVo> getMyErdList(String memId) {
		return sqlSession.selectList("erd.getMyErdList", memId);
	}

	@Override
	public int delErd(int erdNo) {
		return sqlSession.delete("erd.delErd", erdNo);
	}

	@Override
	public List<ErdVo> getAllErdList() {
		return sqlSession.selectList("erd.getAllErdList");
	}

	@Override
	public List<ErdVo> getAllErdListPaging(PageVo pageVo) {
		return sqlSession.selectList("erd.getAllErdListPaging", pageVo);
	}

	@Override
	public int getAllErdCnt() {
		return sqlSession.selectOne("erd.getAllErdCnt");
	}

	@Override
	public List<ErdVo> searchPagingList(PageVo pageVo) {
		return sqlSession.selectList("erd.searchPagingList", pageVo);
	}

	@Override
	public List<ErdVo> searchList(String search) {
		return sqlSession.selectList("erd.searchList", search);
	}

	@Override
	public ErdVo getErdInfo(int erdNo) {
		return sqlSession.selectOne("erd.getErdInfo", erdNo);
	}

	@Override
	public int updCnt(int erdNo) {
		return sqlSession.update("erd.updCnt", erdNo);
	}

	@Override
	public List<ErdVo> getAllErdListOrder(ErdVo erdVo) {
		return sqlSession.selectList("erd.getAllErdListOrder", erdVo);
	}

	@Override
	public int erdUdt(ErdVo erdVo) {
		return sqlSession.update("erd.erdUdt",erdVo);
	}

	@Override
	public int erdLikeCnt(int erdNo) {
		return sqlSession.selectOne("erd.erdLikeCnt", erdNo);
	}

	@Override
	public int erdLikeClick(ErdLikeVo erdLikeVo) {
		return sqlSession.insert("erd.erdLikeClick", erdLikeVo);
	}

	@Override
	public int getMyLikeCnt(ErdLikeVo erdLikeVo) {
		return sqlSession.selectOne("erd.getMyLikeCnt", erdLikeVo);
	}

	@Override
	public int getPrivateCnt(String memId) {
		return sqlSession.selectOne("erd.getPrivateCnt", memId);
	}

}
