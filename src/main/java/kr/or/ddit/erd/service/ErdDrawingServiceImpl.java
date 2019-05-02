package kr.or.ddit.erd.service;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.or.ddit.erd.dao.IErdDrawingDao;
import kr.or.ddit.erd.model.ChatVo;
import kr.or.ddit.erd.model.DomainVo;
import kr.or.ddit.erdhistory.model.ErdHistVo;

@Service("erdDrawingService")
public class ErdDrawingServiceImpl implements IErdDrawingService{
	private Logger logger = LoggerFactory.getLogger(ErdDrawingServiceImpl.class);
	
	@Resource(name="erdDrawingDao")
	private IErdDrawingDao erdDrawingDao;
	
//	사용안함 (search로 대체함)
	@Override
	public List<DomainVo> domainList(int erdNo){
		return erdDrawingDao.domainList(erdNo);
	}
	
	@Override
	public List<DomainVo> domainSearch(DomainVo domainVo){
		return erdDrawingDao.domainSearch(domainVo);
	}
	
	@Override
	public int domainUpdate(DomainVo domainVo){
		
		int cnt=0;
//		
		if(domainVo.getDomainNo() != 0){
			logger.debug("값 들어있음 : {}", domainVo);
			cnt = erdDrawingDao.domainModify(domainVo);
			
		}
		else{
			logger.debug("값 없음");
			cnt = erdDrawingDao.domainInsert(domainVo);

		}

		return cnt;
	}

	
	@Override
	public int domainDelete(int domainNo){
		return erdDrawingDao.domainDelete(domainNo);
	}
	
	
	@Override
	public int erdHistInsert(ErdHistVo erdHistVo){
		return erdDrawingDao.erdHistInsert(erdHistVo);
	}
	
	@Override
	public ErdHistVo erdMaxHistSelect(int erdNo){
		return erdDrawingDao.erdMaxHistSelect(erdNo);
	}
	
	
	@Override
	public List<ErdHistVo> erdHistList(int erdNo){
		return erdDrawingDao.erdHistList(erdNo);
	}
	
	
	@Override
	public List<ErdHistVo> erdSnapList(int erdNo){
		return erdDrawingDao.erdSnapList(erdNo);
	}

	@Override
	public int chatInsert(ChatVo chatVo) {
		return erdDrawingDao.chatInsert(chatVo);
	}

	@Override
	public List<ChatVo> chatList(int erdNo) {
		return erdDrawingDao.chatList(erdNo);
	}

}
