package kr.or.ddit.erd.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.erd.model.ErdLikeVo;
import kr.or.ddit.erd.model.ErdVo;
import kr.or.ddit.erdhistory.model.ErdHistVo;
import kr.or.ddit.util.model.PageVo;

public interface IErdService {
	/**
	* Method : addErd
	* 작성자 : PC08
	* 변경이력 :
	* @param erdVo
	* @return
	* Method 설명 : erd 생성
	*/
	int addErd(ErdVo erdVo);
	

	/**
	* Method : addErdTag
	* 작성자 : kjy
	* 변경이력 :
	* @param erdVo
	* @param tag
	* @return
	* Method 설명 : erd 생성 시 태그도 함께 insert
	*/
	int addErdTag(ErdVo erdVo, String tag, String memId);
	
	/**
	* Method : getMyErdList
	* 작성자 : PC08
	* 변경이력 :
	* @param memId
	* @return
	* Method 설명 : 나의 Erd리스트 가져오기
	*/
	List<ErdVo> getMyErdList(String memId);

	/**
	* Method : getMyErdTagMap
	* 작성자 : PC08
	* 변경이력 :
	* @param memId
	* @return
	* Method 설명 : 나의 erd리스트와 태그 리스트 가져오기
	*/
	Map<String, Object> getMyErdTagMap(String memId);
	
	/**
	* Method : delErd
	* 작성자 : PC08
	* 변경이력 :
	* @param erdNo
	* @return
	* Method 설명 : erd 삭제
	*/
	int delErd(int erdNo);
	
	/**
	* Method : getMyErdTagMap
	* 작성자 : PC08
	* 변경이력 :
	* @param memId
	* @return
	* Method 설명 : 전체 erd리스트와 태그 리스트 가져오기
	*/
	Map<String, Object> getAllErdAndTagMap();
	
	/**
	* Method : getAllErdListPaging
	* 작성자 : PC08
	* 변경이력 :
	* @return
	* Method 설명 : 모든 erd 페이징 리스트
	*/
	Map<String, Object>getAllErdListPaging(PageVo pageVo);
	
	/**
	* Method : searchPagingList
	* 작성자 : PC08
	* 변경이력 :
	* @param pageVo
	* @return
	* Method 설명 : 라이브러리 검색된 erd 페이징 리스트
	*/
	Map<String, Object> searchPagingList(PageVo pageVo);
	
	/**
	* Method : searchList
	* 작성자 : PC08
	* 변경이력 :
	* @param searchTxt
	* @return
	* Method 설명 : 검색 된 erd 리스트
	*/
	List<ErdVo>searchList(String searchTxt);
	
	/**
	* Method : getErdInfo
	* 작성자 : PC08
	* 변경이력 :
	* @param erdNo
	* @return
	* Method 설명 : erd정보 조회
	*/
	ErdVo getErdInfo(int erdNo);
	
	/**
	* Method : updCnt
	* 작성자 : PC08
	* 변경이력 :
	* @param erdNo
	* @return
	* Method 설명 : erd 조회수 증가
	*/
	int updCnt(int erdNo);
	
	/**
	* Method : getAllErdListOrder
	* 작성자 : PC08
	* 변경이력 :
	* @param orderKind
	* @return
	* Method 설명 : 모든 ERD와 Tag 가져오기(정렬선택)
	*/
	Map<String, Object> getAllErdOrderAndTagMap(String orderKind);
	
	/**
	* Method : erdUdt
	* 작성자 : PC08
	* 변경이력 :
	* @param erdVo
	* @param memId
	* @param tag
	* @return
	* Method 설명 : erd 수정
	*/
	int erdUdt(ErdVo erdVo, String memId, String tag);
	
	/**
	* Method : erdTitleEdit
	* 작성자 : PC08
	* 변경이력 :
	* @param erdVo
	* @return
	* Method 설명 : erd title 수정
	*/
	int erdTitleEdit(ErdVo erdVo);

	/**
	* Method : erdLikeCnt
	* 작성자 : PC08
	* 변경이력 :
	* @param erdNo
	* @return
	* Method 설명 : erd별 조회수
	*/
	int erdLikeCnt(int erdNo);
	
	/**
	* Method : erdLikeClick
	* 작성자 : PC08
	* 변경이력 :
	* @param erdLikeVo
	* @return
	* Method 설명 : erd 좋아요 클릭
	*/
	int erdLikeClick(ErdLikeVo erdLikeVo);
	
	/**
	* Method : getMyLikeCnt
	* 작성자 : PC08
	* 변경이력 :
	* @param erdLikeVo
	* @return
	* Method 설명 : erd 좋아요 했는지 확인 cnt
	*/
	int getMyLikeCnt(ErdLikeVo erdLikeVo);
	
	/**
	* Method : erdCopy
	* 작성자 : PC08
	* 변경이력 :
	* @param erdVo
	* @return
	* Method 설명 : erd 복사
	*/
	int erdCopy(ErdVo erdVo);
	
	// erd private 갯수
	int getPrivateCnt(String memId);
}
