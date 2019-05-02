package kr.or.ddit.erd.service;

import java.util.List;

import kr.or.ddit.erd.model.ChatVo;
import kr.or.ddit.erd.model.DomainVo;
import kr.or.ddit.erdhistory.model.ErdHistVo;

public interface IErdDrawingService {

	//도메인 리스트 출력	//	사용안함 (search로 대체함)
	List<DomainVo> domainList(int erdNo);
	
	//도메인 검색
	List<DomainVo> domainSearch(DomainVo domainVo);

	//도메인 등록 및 수정
	int domainUpdate(DomainVo domainVo);

	//도메인 삭제
	int domainDelete(int domainNo);

	//erd 히스토리 추가
	int erdHistInsert(ErdHistVo erdHistVo);

	//erd 최신 히스토리 가져오기
	ErdHistVo erdMaxHistSelect(int erdNo);

	//erd 히스토리 가져오기
	List<ErdHistVo> erdHistList(int erdNo);

	//erd 스냅샷 가져오기
	List<ErdHistVo> erdSnapList(int erdNo);
	
	// 채팅 내용 insert
	int chatInsert(ChatVo chatVo);
	
	// 채팅 리스트 
	List<ChatVo>chatList(int erdNo);



}
