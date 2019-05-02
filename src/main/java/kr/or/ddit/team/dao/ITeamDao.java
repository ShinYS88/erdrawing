package kr.or.ddit.team.dao;

import java.util.List;

import kr.or.ddit.erd.model.ErdVo;
import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.team.model.TagHistVo;
import kr.or.ddit.team.model.TagVo;
import kr.or.ddit.team.model.TeamListVo;
import kr.or.ddit.team.model.TeamVo;

public interface ITeamDao {

	/**
	* Method : getTeamAllList
	* 작성자 : kjy
	* 변경이력 :
	* @param memId
	* @return
	* Method 설명 : 팀 리스트 조회
	*/
	List<TeamListVo> getTeamAllList(String memId);
	
	
	/**
	* Method : getTeamInfo
	* 작성자 : kjy
	* 변경이력 :
	* @param teamNo
	* @return
	* Method 설명 : 회원의 팀 정보 조회
	*/
	TeamVo getTeamInfo(int teamNo);
	
	/**
	* Method : insertTag
	* 작성자 : kjy
	* 변경이력 :
	* @param tagVo
	* @return
	* Method 설명 : 태그 insert
	*/
	int insertTag(TagVo tagVo);
	
	/**
	* Method : getTagNo
	* 작성자 : kjy
	* 변경이력 :
	* @param tagContent
	* @return
	* Method 설명 : 태그 번호 가져오기
	*/
	int getTagNo(String tagContent);
	
	/**
	* Method : insertTagHist
	* 작성자 : kjy
	* 변경이력 :
	* @param tagHistVo
	* @return
	* Method 설명 : 태그와 erd번호 맵핑
	*/
	int insertTagHist(TagHistVo tagHistVo);
	
	/**
	* Method : getErdTag
	* 작성자 : PC08
	* 변경이력 :
	* @param erdNo
	* @return
	* Method 설명 : erd에 해당되는  tag 가져오기
	*/
	List<TagVo> getErdTag(int erdNo);
	
	/**
	* Method : insertTeam
	* 작성자 : PC08
	* 변경이력 :
	* @param teamVo
	* @return
	* Method 설명 : 팀 생성
	*/
	int insertTeam(TeamVo teamVo);
	
	/**
	* Method : getTeamErdList
	* 작성자 : PC08
	* 변경이력 :
	* @param teamNo
	* @return
	* Method 설명 : 팀 erd 가져오기
	*/
	List<ErdVo>getTeamErdList(int teamNo);
	
	/**
	* Method : insertTeamMember
	* 작성자 : kjy
	* 변경이력 :
	* @param teamListVo
	* @return
	* Method 설명 : 팀 멤버 추가
	*/
	int insertTeamMember(TeamListVo teamListVo);
	
	/**
	* Method : getTeamAllListTeamNo
	* 작성자 : kjy
	* 변경이력 :
	* @param teamNo
	* @return
	* Method 설명 : 팀리스트 가져오기(팀 번호)
	*/
	List<TeamListVo> getTeamAllListTeamNo(int teamNo);
	
	/**
	* Method : getTeamMember
	* 작성자 : kjy
	* 변경이력 :
	* @param teamNo
	* @return
	* Method 설명 : 팀 멤버 가져오기
	*/
	List<MemberVo> getTeamMember(int teamNo);
	
	/**
	* Method : authUpdate
	* 작성자 : PC08
	* 변경이력 :
	* @param teamListVo
	* @return
	* Method 설명 : 팀 멤버 권한 수정하기
	*/
	int authUpdate(TeamListVo teamListVo);
	
	/**
	* Method : delMember
	* 작성자 : PC08
	* 변경이력 :
	* @param teamListVo
	* @return
	* Method 설명 : 팀 멤버 삭제
	*/
	int delMember(TeamListVo teamListVo);
	
	
	/**
	* Method : updateAgreeFlag
	* 작성자 : PC08
	* 변경이력 :
	* @param teamListVo
	* @return
	* Method 설명 : 팀 수락여부 수정하기
	*/
	int updateAgreeFlag(TeamListVo teamListVo);
	
	/**
	* Method : teamMofify
	* 작성자 : PC08
	* 변경이력 :
	* @param teamVo
	* @return
	* Method 설명 : 팀 수정
	*/
	int teamModify(TeamVo teamVo);
	
	/**
	* Method : teamDel
	* 작성자 : PC08
	* 변경이력 :
	* @param teamNo
	* @return
	* Method 설명 : 팀 삭제
	*/
	int teamDel(int teamNo);
	
	/**
	* Method : getTeamMemList
	* 작성자 : PC08
	* 변경이력 :
	* @param teamNo
	* @return
	* Method 설명 : 팀원 리스트 가져오기
	*/
	List<TeamListVo>getTeamMemList(int teamNo);
	
	/**
	* Method : delTag
	* 작성자 : PC08
	* 변경이력 :
	* @param erdNo
	* @return
	* Method 설명 : 태그 삭제
	*/
	int delTag(int erdNo);
	
}
