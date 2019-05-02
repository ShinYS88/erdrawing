package kr.or.ddit.post.dao;

import java.util.List;

import kr.or.ddit.post.model.ReportVo;

public interface IReportDao {
	
	List<ReportVo> getAllReport(String toMemId);
	
	ReportVo getReport(String toMemId);
	
	int getReportCnt(ReportVo reportVo); //중복신고 막으려고
	
	int insertReport(ReportVo reportVo);
	
}
