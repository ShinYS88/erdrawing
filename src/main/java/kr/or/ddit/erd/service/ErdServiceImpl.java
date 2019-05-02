package kr.or.ddit.erd.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.or.ddit.erd.dao.IErdDao;
import kr.or.ddit.erd.dao.IErdDrawingDao;
import kr.or.ddit.erd.model.ErdLikeVo;
import kr.or.ddit.erd.model.ErdVo;
import kr.or.ddit.erdhistory.model.ErdHistVo;
import kr.or.ddit.team.dao.ITeamDao;
import kr.or.ddit.team.model.TagHistVo;
import kr.or.ddit.team.model.TagVo;
import kr.or.ddit.util.model.PageVo;

@Service("erdService")
public class ErdServiceImpl implements IErdService{
	private Logger logger = LoggerFactory.getLogger(ErdServiceImpl.class);
	
	@Resource(name="erdDao")
	private IErdDao erdDao;
	@Resource(name="teamDao")
	private ITeamDao teamDao;
	@Resource(name="erdDrawingDao")
	private IErdDrawingDao erdDrawingDao;
	

	@Override
	public int addErd(ErdVo erdVo) {
		return erdDao.addErd(erdVo);
	}

	@Override
	public int addErdTag(ErdVo erdVo, String tag, String memId) {
		// tag 검색을 위한 list
		ArrayList<String> tagContentList = new ArrayList<>();
		int addErdCnt = 0;
		
		// 태그가 있을 때
		if(!tag.isEmpty()){
			
			String tagEmptyRemove = tag.replaceAll("\\p{Z}", "");	// 앞뒤 공백 제거
			String[] tagSplit = tagEmptyRemove.split(",");	// (,)로 자르기
			
			int cnt = 0;
			for(String tagFinal : tagSplit){
				cnt++;
				// (,)만 넣은 값 판별
				if(!tagFinal.equals("")){
					TagVo tagVo = new TagVo();
					tagVo.setTagContent(tagFinal);
					tagVo.setTagMaker(memId);
					
					teamDao.insertTag(tagVo);
					
					tagContentList.add(tagFinal);	// 입력한 태그 list에 추가
				}
			}
			// 입력받은 태그 다 넣었을 때 erd 생성
			if(cnt == tagSplit.length){
				addErdCnt = erdDao.addErd(erdVo);
				// erd 생성 후 태그와 erd 맵핑
				for(String tagContent : tagContentList){
					int tagNo = teamDao.getTagNo(tagContent);	// 입력한 태그의 tagNo 가져오기
					
					TagHistVo tagHistVo = new TagHistVo();
					tagHistVo.setErdNo(erdVo.getErdNo());	
					tagHistVo.setTagNo(tagNo);
					
					teamDao.insertTagHist(tagHistVo);
				}
			}else{
				addErdCnt = 0;
			}
		}
		// 태그가 없을 경우
		else
			addErdCnt = erdDao.addErd(erdVo);
		
		return addErdCnt;
	}

	@Override
	public List<ErdVo> getMyErdList(String memId) {
		return erdDao.getMyErdList(memId);
	}

	@Override
	public Map<String, Object> getMyErdTagMap(String memId) {
		List<ErdVo> myErdList = erdDao.getMyErdList(memId);	// erdList
		Map<Integer, List<TagVo>> erdTagListMap = new HashMap<>();
		for(ErdVo erdVo : myErdList){
			int erdNo = erdVo.getErdNo();
			List<TagVo> erdTagList = teamDao.getErdTag(erdNo);	// tagList
			if(!erdTagList.isEmpty()){
				erdTagListMap.put(erdNo, erdTagList);	// tagList가 있을 때 erdNo를 key, tagList를 value로 설정
			}
		}
		Map<String, Object> erdTagMap = new HashMap<>();	// 리턴 값 2개 처리하기 위해 erdList와 erdTagListMap을 Map에 넣어 리턴 
		erdTagMap.put("myErdList", myErdList);
		erdTagMap.put("erdTagListMap", erdTagListMap);
		
		return erdTagMap;
	}

	@Override
	public int delErd(int erdNo) {
		return erdDao.delErd(erdNo);
	}

	@Override
	public Map<String, Object> getAllErdAndTagMap() {
		List<ErdVo> erdList = erdDao.getAllErdList();	// erdList
		Map<Integer, List<TagVo>> erdTagListMap = new HashMap<>();
		for(ErdVo erdVo : erdList){
			int erdNo = erdVo.getErdNo();
			List<TagVo> erdTagList = teamDao.getErdTag(erdNo);	// tagList
			if(!erdTagList.isEmpty()){
				erdTagListMap.put(erdNo, erdTagList);	// tagList가 있을 때 erdNo를 key, tagList를 value로 설정
			}
		}
		Map<String, Object> erdTagMap = new HashMap<>();	// 리턴 값 2개 처리하기 위해 erdList와 erdTagListMap을 Map에 넣어 리턴 
		erdTagMap.put("erdList", erdList);
		erdTagMap.put("erdTagListMap", erdTagListMap);
		
		return erdTagMap;
	}

	@Override
	public Map<String, Object> getAllErdListPaging(PageVo pageVo) {
		int allErdCnt = erdDao.getAllErdCnt();
		pageVo.setPageSize(12);
		pageVo.setTotalCount(allErdCnt);
		
		List<ErdVo> allErdListPaging = erdDao.getAllErdListPaging(pageVo);
		
		Map<Integer, List<TagVo>> erdTagListMap = new HashMap<>();
		for(ErdVo erdVo : allErdListPaging){
			int erdNo = erdVo.getErdNo();
			List<TagVo> erdTagList = teamDao.getErdTag(erdNo);	// tagList
			if(!erdTagList.isEmpty()){
				erdTagListMap.put(erdNo, erdTagList);	// tagList가 있을 때 erdNo를 key, tagList를 value로 설정
			}
		}
		Map<String, Object> erdTagMap = new HashMap<>();	// 리턴 값 2개 처리하기 위해 erdList와 erdTagListMap을 Map에 넣어 리턴 
		erdTagMap.put("allErdListPaging", allErdListPaging);
		erdTagMap.put("erdTagListMap", erdTagListMap);
		
		return erdTagMap;
	}

	@Override
	public Map<String, Object> searchPagingList(PageVo pageVo) {
		List<ErdVo> searchList = erdDao.searchList(pageVo.getSearch());
		pageVo.setPageSize(12);
		pageVo.setTotalCount(searchList.size());
		
		List<ErdVo> allErdListPaging = erdDao.searchPagingList(pageVo);
		
		Map<Integer, List<TagVo>> erdTagListMap = new HashMap<>();
		for(ErdVo erdVo : allErdListPaging){
			int erdNo = erdVo.getErdNo();
			List<TagVo> erdTagList = teamDao.getErdTag(erdNo);	// tagList
			if(!erdTagList.isEmpty()){
				erdTagListMap.put(erdNo, erdTagList);	// tagList가 있을 때 erdNo를 key, tagList를 value로 설정
			}
		}
		Map<String, Object> erdTagMap = new HashMap<>();	// 리턴 값 2개 처리하기 위해 erdList와 erdTagListMap을 Map에 넣어 리턴 
		erdTagMap.put("allErdListPaging", allErdListPaging);
		erdTagMap.put("erdTagListMap", erdTagListMap);
		
		return erdTagMap;
	}

	@Override
	public List<ErdVo> searchList(String searchTxt) {
		List<ErdVo> searchList = erdDao.searchList(searchTxt);
		return searchList;
	}

	@Override
	public ErdVo getErdInfo(int erdNo) {
		return erdDao.getErdInfo(erdNo);
	}

	@Override
	public int updCnt(int erdNo) {
		return erdDao.updCnt(erdNo);
	}

	@Override
	public Map<String, Object> getAllErdOrderAndTagMap(String orderKind) {
		ErdVo vo = new ErdVo();
		vo.setOrderKind(orderKind);
		
		List<ErdVo> allErdListOrder = erdDao.getAllErdListOrder(vo);
		
		Map<Integer, List<TagVo>> erdTagListMap = new HashMap<>();
		for(ErdVo erdVo : allErdListOrder){
			int erdNo = erdVo.getErdNo();
			List<TagVo> erdTagList = teamDao.getErdTag(erdNo);	// tagList
			
			logger.debug("***erdTagList : {}", erdTagList);
			if(!erdTagList.isEmpty()){
				erdTagListMap.put(erdNo, erdTagList);	// tagList가 있을 때 erdNo를 key, tagList를 value로 설정
			}
		}
		Map<String, Object> erdTagMap = new HashMap<>();	// 리턴 값 2개 처리하기 위해 erdList와 erdTagListMap을 Map에 넣어 리턴 
		erdTagMap.put("erdList", allErdListOrder);
		erdTagMap.put("erdTagListMap", erdTagListMap);
		
		return erdTagMap;
	}

	@Override
	public int erdUdt(ErdVo erdVo, String memId, String tag) {
		int erdNo = erdVo.getErdNo();
		teamDao.delTag(erdNo); // 태그 삭제

		// tag 검색을 위한 list
		ArrayList<String> tagContentList = new ArrayList<>();
		int erdUdtCnt = 0;

		// 태그가 있을 때
		if (!tag.isEmpty()) {

			String tagEmptyRemove = tag.replaceAll("\\p{Z}", ""); // 앞뒤 공백 제거
			String[] tagSplit = tagEmptyRemove.split(","); // (,)로 자르기

			int cnt = 0;
			for (String tagFinal : tagSplit) {
				cnt++;
				// (,)만 넣은 값 판별
				if (!tagFinal.equals("")) {
					TagVo tagVo = new TagVo();
					tagVo.setTagContent(tagFinal);
					tagVo.setTagMaker(memId);

					teamDao.insertTag(tagVo);

					tagContentList.add(tagFinal); // 입력한 태그 list에 추가
				}
			}
			// 입력받은 태그 다 넣었을 때 erd 수정
			if (cnt == tagSplit.length) {
				erdUdtCnt = erdDao.erdUdt(erdVo);
				// erd 수정 후 태그와 erd 맵핑
				for (String tagContent : tagContentList) {
					int tagNo = teamDao.getTagNo(tagContent); // 입력한 태그의 tagNo 가져오기
					TagHistVo tagHistVo = new TagHistVo();
					tagHistVo.setErdNo(erdVo.getErdNo());
					tagHistVo.setTagNo(tagNo);

					teamDao.insertTagHist(tagHistVo);
				}
			} else {
				erdUdtCnt = 0;
			}
		}
		// 태그가 없을 경우
		else
			erdUdtCnt = erdDao.erdUdt(erdVo);
		return erdUdtCnt;
	}

	@Override
	public int erdTitleEdit(ErdVo erdVo) {
		return erdDao.erdUdt(erdVo);
	}

	@Override
	public int erdLikeCnt(int erdNo) {
		return erdDao.erdLikeCnt(erdNo);
	}

	@Override
	public int erdLikeClick(ErdLikeVo erdLikeVo) {
		return erdDao.erdLikeClick(erdLikeVo);
	}

	@Override
	public int getMyLikeCnt(ErdLikeVo erdLikeVo) {
		return erdDao.getMyLikeCnt(erdLikeVo);
	}

	@Override
	public int erdCopy(ErdVo erdVo) {
		ErdHistVo erdMaxHistVo = erdDrawingDao.erdMaxHistSelect(erdVo.getErdNo());	// 복사 대상의 최신 erd hist
		erdVo.setErdTitle(erdVo.getErdTitle() + " of copy");
		erdVo.setErdScope("private");
		logger.debug("!@!@ erdVo : {}", erdVo);
		erdDao.addErd(erdVo);	// 복사할 erd 생성
		
		int erdNo = erdVo.getErdNo();
		
		// 새로 생성한 erd에 복사 대상의 erdhist 넣어주기
		if(erdMaxHistVo == null){
			ErdHistVo newErdHistVo = new ErdHistVo();
			newErdHistVo.setErdNo(erdNo);
			newErdHistVo.setErdIsVisible("T");
			erdDrawingDao.erdHistInsert(newErdHistVo);
		}else{
			erdMaxHistVo.setErdNo(erdNo);
			erdMaxHistVo.setErdIsVisible("T");
			erdDrawingDao.erdHistInsert(erdMaxHistVo);
		}
		return 0;
	}

	@Override
	public int getPrivateCnt(String memId) {
		return erdDao.getPrivateCnt(memId);
	}

}
