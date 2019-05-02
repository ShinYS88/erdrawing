package kr.or.ddit.post.dao;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.ddit.post.model.ReportVo;

@Repository("reportDao")
public class ReportDaoImpl implements IReportDao {
	
	@Resource(name = "sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List<ReportVo> getAllReport(String toMemId) {
		List<ReportVo> reportList = sqlSessionTemplate.selectList("post.getAllReport", toMemId);

		return reportList;
	}

	@Override
	public ReportVo getReport(String toMemId) {
		ReportVo reportVo = sqlSessionTemplate.selectOne("post.getReport", toMemId);

		return reportVo;
	}

	@Override
	public int getReportCnt(ReportVo reportVo) {
		int reportCnt = sqlSessionTemplate.selectOne("post.getReportCnt", reportVo);
		
		return reportCnt;
	}
	
	@Override
	public int insertReport(ReportVo reportVo) {
		int insertCnt = sqlSessionTemplate.insert("post.insertReport", reportVo);
		
		return insertCnt;
	}


	
}
