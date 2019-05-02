package kr.or.ddit.member.dao;

import java.util.List;

import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.post.model.ReportVo;
import kr.or.ddit.util.model.PageVo;

public interface IMemberDao {
	
	/**
	 * Method : getAllMember
	 * 작성자 : PC02
	 * 변경이력 :
	 * @return
	 * Method 설명 : 전체 사용자 조회
	 */
	List<MemberVo> getAllMember();
	
	/**
	 * Method : selectMember
	 * 작성자 : PC02
	 * 변경이력 :
	 * @param memId
	 * @return
	 * Method 설명 : 특정 사용자 조회
	 */
	MemberVo selectMember(String memId);
	
	/**
	 * Method : insertMember
	 * 작성자 : PC02
	 * 변경이력 :
	 * @param vo
	 * @return
	 * Method 설명 : 사용자 등록
	 */
	int insertMember(MemberVo vo);
	
	/**
	* Method : getAutoFindMem
	* 작성자 : PC08
	* 변경이력 :
	* @param memId
	* @return
	* Method 설명 : 회원 자동검색
	*/
	List<MemberVo> getAutoFindMem(String memId);
	
	/**
	 * Method : updateMemPw
	 * 작성자 : PC02
	 * 변경이력 :
	 * @param vo
	 * @return
	 * Method 설명 : 비밀번호 임시번호 저장,비밀번호 찾기
	 */
	int updateMemPw(MemberVo vo);
	 
	/**
	 * Method : getMemId
	 * 작성자 : PC02
	 * 변경이력 :
	 * @param vo
	 * @return
	 * Method 설명 : 회원id검색
	 */
	List<MemberVo> getMemId(MemberVo vo);
	
	/**
	 * Method : selectMemPagingList
	 * 작성자 : PC02
	 * 변경이력 :
	 * @param vo
	 * @return
	 * Method 설명 : 전체 사용자 페이징
	 */
	List<MemberVo> selectMemPagingList(PageVo vo);
	
	
	/**
	 * Method : getMemCnt
	 * 작성자 : PC02
	 * 변경이력 :
	 * @return
	 * Method 설명 : 회원 정보 갯수
	 */
	int getMemCnt();
	
	/**
	 * Method : delMember
	 * 작성자 : PC02
	 * 변경이력 :
	 * @param memId
	 * @return
	 * Method 설명 :특정회원삭제
	 */
	int updateMemberDel(MemberVo vo);
	
	/**
	 * Method : updateMemberInfo
	 * 작성자 : hyuns
	 * 변경이력 :
	 * @param vo
	 * @return
	 * Method 설명 : 회원정보수정
	 */
	int updateMemberInfo(MemberVo vo);
	
	/**
	 * Method : selectReport
	 * 작성자 : PC02
	 * 변경이력 :
	 * @param tomemid
	 * @return
	 * Method 설명 :신고사유 조회
	 */
	List<ReportVo> selectReport(String tiemid);
	
}
