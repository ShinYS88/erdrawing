package kr.or.ddit.test;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.erd.model.ErdLikeVo;
import kr.or.ddit.erd.model.ErdVo;
import kr.or.ddit.erd.service.IErdService;
import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.message.service.IMessageService;
import kr.or.ddit.team.model.TeamListVo;
import kr.or.ddit.team.model.TeamVo;
import kr.or.ddit.team.service.ITeamService;

@Controller
public class TestController {
	private Logger logger = LoggerFactory.getLogger(TestController.class);

	@Resource(name="teamService")
	private ITeamService teamService;
	
	@Resource(name="erdService")
	private IErdService erdService;
	
	@Resource(name="memberService")
	private IMemberService memberService;

	@RequestMapping(path="/", method=RequestMethod.GET)
	public String test1(Model model, HttpSession session){
		String orderKind = "erdLike";
		Map<String, Object> allErdOrderAndTagMap = erdService.getAllErdOrderAndTagMap(orderKind);
		model.addAllAttributes(allErdOrderAndTagMap);
		
		return "main";
	}
	
	@RequestMapping(path="/", method=RequestMethod.POST)
	public String mainPost(Model model, @RequestParam(name = "orderKind", defaultValue = "erdLike")String orderKind){
		logger.debug("***orderKind : {} ", orderKind);
		Map<String, Object> allErdOrderAndTagMap = erdService.getAllErdOrderAndTagMap(orderKind);
		model.addAllAttributes(allErdOrderAndTagMap);
		
		return "jsonView";
	}
	
	@RequestMapping(path="/test2")
	public String test2(){
		return "test2";
	}
	
	
	/*@RequestMapping(path="/library")
	public String library(Model model){
		Map<String, Object> allErdAndTagMap = erdService.getAllErdAndTagMap();
		model.addAllAttributes(allErdAndTagMap);
		return "library";
	}*/
	
	@RequestMapping(path="/library")
	public String library(Model model, @RequestParam(name = "tagContent", defaultValue = "")String tagContent/*, @RequestParam(name = "page", defaultValue = "1") int page*/){
		/*PageVo pageVo = new PageVo();
		pageVo.setPageNo(page);

		Map<String, Object> allErdListPaging = erdService.getAllErdListPaging(pageVo);

		model.addAllAttributes(allErdListPaging);
		model.addAttribute("paging", pageVo);*/
		model.addAttribute("tagContent", tagContent);
		return "libraryScroll";
	}
	
	
	@RequestMapping(path="/join")
	public String join(){
		return "join";
	}
	
	

	
	@RequestMapping(path="/mypage")
	public String mypage(Model model, HttpSession session){
		
		MemberVo memberVo = (MemberVo) session.getAttribute("SESSION_MEMBERVO");
		String memId = memberVo.getMemId();
		
		List<TeamVo> teamInfoList = teamService.getMemberAgreTeamInfoList(memId);
		model.addAttribute("teamInfoList", teamInfoList);
		
		session.setAttribute("teamInfoList", teamInfoList);
		
		logger.debug("====teamInfoList : {}", teamInfoList);
		
		// erd와 tagList Map으로 넘겨줌
		Map<String, Object> myErdTagMap = erdService.getMyErdTagMap(memId);
		model.addAllAttributes(myErdTagMap);
		
		
		return "mypage";
	}
	
	
	
	
	@RequestMapping(path="/modify")
	public String modify(String memId,HttpSession session){
		session.setAttribute("SESSION_MEMBERVO", memberService.selectMember(memId));
		return "modify";
	}
	
	
	@RequestMapping(path="/team")
	public String team(@RequestParam("teamNo")int teamNo, Model model, HttpSession session){
		MemberVo memberVo = (MemberVo) session.getAttribute("SESSION_MEMBERVO");
		String memId = memberVo.getMemId();
		model.addAttribute("loginId", memId);
		List<TeamVo> teamInfoList = teamService.getMemberAgreTeamInfoList(memId);
		model.addAttribute("teamInfoList", teamInfoList);
		
		// erd와 tagList를 Map으로 넘겨줌
		Map<String, Object> teamErdTagMap = teamService.getTeamErdTagMap(teamNo);
		model.addAllAttributes(teamErdTagMap);
		
		TeamVo teamInfo = teamService.getTeamInfo(teamNo);
		model.addAttribute("teamInfo",teamInfo);
		
		// 팀 수락한  teamList와 teamMember 리스트
		Map<String, Object> teamMemberListMap = teamService.teamMemberListMap(teamNo);
		model.addAllAttributes(teamMemberListMap);
		
		List<TeamListVo> teamAllList = teamService.getTeamAllList(memId);
		for(TeamListVo vo : teamAllList){
			if(vo.getTeamNo() == teamNo){
				model.addAttribute("myTeam", vo);
			}
		}
		
		return "team";
	}
	
	@RequestMapping(path="/insert")
	public String insert(){
		return "post/postInsert";
	}
	
	
	
	
	
	@RequestMapping("/erdDrawing")
	public String erdDrawing(Model model, ErdVo erdVo, HttpSession session){
		erdService.updCnt(erdVo.getErdNo()); // 조회수 증가
		int erdNo = erdVo.getErdNo();
		ErdVo erdInfoVo = erdService.getErdInfo(erdNo);
		model.addAttribute("erdVo", erdInfoVo);
		model.addAttribute("erdNo", erdNo);
		
		MemberVo memberVo = (MemberVo) session.getAttribute("SESSION_MEMBERVO");
		String memId = memberVo.getMemId();
		
		ErdLikeVo erdLikeVo = new ErdLikeVo();
		erdLikeVo.setErdNo(erdNo);
		erdLikeVo.setMemId(memId);
		int myLikeCnt = erdService.getMyLikeCnt(erdLikeVo);
		
		model.addAttribute("likeCnt", myLikeCnt);
		
		return "erdrawing_base";
	}
	
//	@RequestMapping(path="er")
//	public String erdDrawing(){
//		return "drawing/erdDrawing";
//	}
	
	@RequestMapping(path="yhs")
	public String erdDrawingYhs(){
		return "drawing/erdDrawingTestYHS";
	}
	
	@RequestMapping(path="/kjy")
	public String erdDrawingKJY(ErdVo erdVo, Model model, HttpSession session){
		//erdVo에 erdNo만 있음
		erdService.updCnt(erdVo.getErdNo()); // 조회수 증가
		int erdNo = erdVo.getErdNo();
		ErdVo erdInfoVo = erdService.getErdInfo(erdNo);
		model.addAttribute("erdVo", erdInfoVo);
		model.addAttribute("erdNo", erdNo);
		
		MemberVo memberVo = (MemberVo) session.getAttribute("SESSION_MEMBERVO");
		String memId = memberVo.getMemId();
		
		ErdLikeVo erdLikeVo = new ErdLikeVo();
		erdLikeVo.setErdNo(erdNo);
		erdLikeVo.setMemId(memId);
		int myLikeCnt = erdService.getMyLikeCnt(erdLikeVo);
		
		model.addAttribute("likeCnt", myLikeCnt);
		
		return "erdrawing";
	}
	
	// 모달 페이지 변경 메소드 
	@RequestMapping("/pageViewAjax")
	public String testAjax(String value){
		String page = "";
		
		
		switch(value){
			case "erdAdd":
				page = "erd/erdadd";
				break;
				
			case "createTeam":
				page = "erd/teamCreate";
				break;
				
			case "pwSearch":
				page = "member/pwSearch";
				break;
				
			case "IdSearch":
				page = "member/idSearch";
				break;
			case "message":
				page = "member/messagePaging";
				break;
			case "teamModify":
				page = "erd/teamModify";
				break;
			case "searchModal":
				page = "erd/search";
				break;
			case "erdModify":
				page = "erd/erdModify";
				break;
			case "joinAgree":
				page = "member/joinAgree";
				break;
		}
		
		return page;
	}
	
	
	@RequestMapping("/sys0130")
	public String sys0130(Model model, @RequestParam(name="erdNo")String erdNo){
		model.addAttribute("erdNo",erdNo);
		
		return "erdrawing_shin";
	}
	
	

	
	
}
