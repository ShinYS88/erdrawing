package kr.or.ddit.erd.dao;

import java.util.List;

import kr.or.ddit.erd.model.ErdLikeVo;
import kr.or.ddit.erd.model.ErdVo;
import kr.or.ddit.erdhistory.model.ErdHistVo;
import kr.or.ddit.util.model.PageVo;

/**
* IErdDao.java
*
* @author PC08
* @version 1.0
* @see
*
* <pre>
* << 개정이력(Modification Information) >>
*
* 수정자 수정내용
* ------ ------------------------
* PC08 최초 생성
*
* </pre>
*/
public interface IErdDao {
	/**
	* Method : addErd
	* 작성자 : PC08
	* 변경이력 :
	* @return
	* Method 설명 : erd 생성
	*/
	int addErd(ErdVo erdVo);
	
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
	* Method : delErd
	* 작성자 : PC08
	* 변경이력 :
	* @param erdNo
	* @return
	* Method 설명 : erd 삭제
	*/
	int delErd(int erdNo);

	/**
	* Method : getAllErdList
	* 작성자 : PC08
	* 변경이력 :
	* @return
	* Method 설명 : 모든 erd 리스트 가져오기
	*/
	List<ErdVo>getAllErdList();
	
	/**
	* Method : getAllErdListPaging
	* 작성자 : PC08
	* 변경이력 :
	* @return
	* Method 설명 : 모든 ERD 페이징 리스트
	*/
	List<ErdVo>getAllErdListPaging(PageVo pageVo);
	
	/**
	* Method : getAllErdCnt
	* 작성자 : PC08
	* 변경이력 :
	* @return
	* Method 설명 : 모든 ERD 개수
	*/
	int getAllErdCnt();
	
	/**
	* Method : searchPagingList
	* 작성자 : PC08
	* 변경이력 :
	* @param pageVo
	* @return
	* Method 설명 : 검색 ERD 페이징 리스트
	*/
	List<ErdVo>searchPagingList(PageVo pageVo);
	
	/**
	* Method : searchList
	* 작성자 : PC08
	* 변경이력 :
	* @param search
	* @return
	* Method 설명 : 검색 ERD 리스트
	*/
	List<ErdVo>searchList(String search);
	
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
	* Method 설명 : 모든 ERD 가져오기(정렬선택)
	*/
	List<ErdVo>getAllErdListOrder(ErdVo erdVo);
	
	/**
	* Method : erdUdt
	* 작성자 : PC08
	* 변경이력 :
	* @param erdVo
	* @return
	* Method 설명 : erd 업데이트
	*/
	int erdUdt(ErdVo erdVo);
	
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
	
	// erd private 갯수
	int getPrivateCnt(String memId);
}
