package kr.or.ddit.team.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.erd.model.ErdVo;
import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.team.model.TagHistVo;
import kr.or.ddit.team.model.TagVo;
import kr.or.ddit.team.model.TeamListVo;
import kr.or.ddit.team.model.TeamVo;

public interface ITeamService {
	/**
	* Method : getTeamAllList
	* 작성자 : kjy
	* 변경이력 :
	* @param memId
	* @return
	* Method 설명 : 팀 리스트 가져오기
	*/
	List<TeamListVo> getTeamAllList(String memId);
	
	/**
	* Method : getTeamInfo
	* 작성자 : kjy
	* 변경이력 :
	* @param teamNo
	* @return
	* Method 설명 : 팀 정보 가져오기
	*/
	TeamVo getTeamInfo(int teamNo);

	/**
	* Method : getMemberTeamInfoList
	* 작성자 : kjy
	* 변경이력 :
	* @param memId
	* @return
	* Method 설명 : 회원의 팀 정보 가져오기
	*/
	List<TeamVo> getMemberTeamInfoList(String memId);
	
	/**
	* Method : getMemberAgreTeamInfoList
	* 작성자 : kjy
	* 변경이력 :
	* @param memId
	* @return
	* Method 설명 : 회원이 수락한 팀 정보 가져오기
	*/
	List<TeamVo> getMemberAgreTeamInfoList(String memId);
	
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
	* Method : insertTeam
	* 작성자 : PC08
	* 변경이력 :
	* @param teamVo
	* @return
	* Method 설명 : 팀 생성
	*/
	int insertTeam(TeamVo teamVo, List<String> teamMember);
	
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
	* Method : getTeamErdTagMap
	* 작성자 : PC08
	* 변경이력 :
	* @param teamNo
	* @return
	* Method 설명 : team erd + tag 가져오기
	*/
	Map<String, Object> getTeamErdTagMap(int teamNo);
	
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
	* Method : teamMemberListMap
	* 작성자 : kjy
	* 변경이력 :
	* @param teamNo
	* @return
	* Method 설명 : 팀 멤버, 팀 멤버 내역 Map
	*/
	Map<String, Object> teamMemberListMap(int teamNo);
	
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
	* Method : getTeamMember
	* 작성자 : kjy
	* 변경이력 :
	* @param teamNo
	* @return
	* Method 설명 : 팀 멤버 리스트
	*/
	List<MemberVo> getTeamMember(int teamNo);
	
	/**
	* Method : teamMofify
	* 작성자 : PC08
	* 변경이력 :
	* @param teamVo
	* @param addMember
	* @param delMember
	* @return
	* Method 설명 : 팀 수정
	*/
	int teamMofify(TeamVo teamVo, List<String> addMember, List<String> delMember);
	
	/**
	* Method : teamDel
	* 작성자 : PC08
	* 변경이력 :
	* @param teamNo
	* @return
	* Method 설명 : 팀 삭제
	*/
	int teamDel(TeamVo teamVo);
	

	/**
	* Method : getErdTag
	* 작성자 : PC08
	* 변경이력 :
	* @param erdNo
	* @return
	* Method 설명 : erd 태그 가져오기
	*/
	List<TagVo> getErdTag(int erdNo);
}
