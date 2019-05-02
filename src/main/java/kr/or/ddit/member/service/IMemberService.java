package kr.or.ddit.member.service;

import java.util.List;

import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.post.model.ReportVo;
import kr.or.ddit.util.model.PageVo;

public interface IMemberService {
	
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
	 * Method 설명 :회원정보 등록
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
	 * Method 설명 :비밀번호 찾기시 임시비밀번호 저장
	 */
	int updateMemPw(MemberVo vo);
	

	/**
	 * Method : getMemId
	 * 작성자 : PC02
	 * 변경이력 :
	 * @param vo
	 * @return
	 * Method 설명 :회원 아이디 찾기 
	 */
	List<MemberVo> getMemId(MemberVo vo);

	/**
	 * Method : selectMemPagingList
	 * 작성자 : PC02
	 * 변경이력 :
	 * @param vo
	 * @return
	 * Method 설명 : 페ㄹ이징 처리
	 */
	List<MemberVo> selectMemPagingList(PageVo vo);
	
	int updateMemberDel(MemberVo vo);
	
	int updateMemberInfo(MemberVo vo);
	
	List<ReportVo> selectReport(String tomemid);
	
}
