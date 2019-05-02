package kr.or.ddit.post.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.ddit.post.dao.IReportDao;
import kr.or.ddit.post.model.ReportVo;

@Service("reportService")
public class ReportServiceImpl implements IReportService {
	
	@Resource(name="reportDao")
	private IReportDao reportDao;
	
	public ReportServiceImpl(){
		
	}

	@Override
	public List<ReportVo> getAllReport(String toMemId) {
		List<ReportVo> reportList = reportDao.getAllReport(toMemId);

		return reportList;
	}

	@Override
	public ReportVo getReport(String toMemId) {
		ReportVo reportVo = reportDao.getReport(toMemId);
		
		return reportVo;
	}
	
	@Override
	public int getReportCnt(ReportVo reportVo) {
		int reportCnt = reportDao.getReportCnt(reportVo);
		
		return reportCnt;
	}

	@Override
	public int insertReport(ReportVo reportVo) {
		int insertCnt = reportDao.insertReport(reportVo);
		
		return insertCnt;
	}

}
