package kr.or.ddit.member.dao;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.post.model.ReportVo;
import kr.or.ddit.util.model.PageVo;

@Repository("memberDao")
public class MemberDaoImpl implements IMemberDao{

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSession; 
	
	@Override
	public List<MemberVo> getAllMember() {
		return sqlSession.selectList("member.getAllMember");
	}

	@Override
	public MemberVo selectMember(String memId) {
		return sqlSession.selectOne("member.selectMember",memId);
	}

	@Override
	public int insertMember(MemberVo vo) {
		return sqlSession.insert("member.insertMember",vo);
	}

	@Override
	public List<MemberVo> getAutoFindMem(String memId) {
		return sqlSession.selectList("member.getAutoFindMem", memId);
	}

	@Override
	public int updateMemPw(MemberVo vo) {
		return sqlSession.update("member.updateMemPw", vo);
	}

	@Override
	public List<MemberVo> getMemId(MemberVo vo) {
		return sqlSession.selectList("member.getMemId", vo);
	}

	@Override
	public List<MemberVo> selectMemPagingList(PageVo vo) {
		return sqlSession.selectList("member.selectMemPagingList", vo);
	}

	@Override
	public int getMemCnt() {
		return sqlSession.selectOne("member.getMemCnt");
	}

	@Override
	public int updateMemberDel(MemberVo vo) {
		return sqlSession.update("member.updateMemberDel",vo);
	}

	@Override
	public int updateMemberInfo(MemberVo vo) {
		return sqlSession.update("member.updateMemberInfo",vo);
	}

	@Override
	public List<ReportVo> selectReport(String tomemid) {
		return sqlSession.selectList("post.selectReport",tomemid);
	}

}
