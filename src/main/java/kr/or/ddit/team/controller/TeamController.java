package kr.or.ddit.team.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.message.model.MessageVo;
import kr.or.ddit.message.service.IMessageService;
import kr.or.ddit.team.model.TeamListVo;
import kr.or.ddit.team.model.TeamVo;
import kr.or.ddit.team.service.ITeamService;

@RequestMapping("/team")
@Controller
public class TeamController {
	private Logger logger = LoggerFactory.getLogger(TeamController.class);
	
	@Resource(name="memberService")
	private IMemberService memberService;
	@Resource(name="teamService")
	private ITeamService teamService;
	@Resource(name="messageService")
	private IMessageService messageService;
	
	@RequestMapping(path="/teamCreate", method=RequestMethod.POST)
	public String teamCreate(TeamVo teamVo, @RequestParam("teamMember")List<String> teamMember, HttpServletRequest req, @RequestPart("profileImg")MultipartFile multipartFile, HttpSession session){

		String[] split;
		String fileName="";
		String ext="";
		
		if(!multipartFile.isEmpty()){
			split = multipartFile.getOriginalFilename().split("\\.");
			fileName = split[0];	// 파일 이름
			ext = split[1];	// 확장자
		}
		
		// db에 저장할 때 path는 빼고 파일 이름만 저장.
		// 이미지 가져올 때도 파일 이름을 가져와서 path를 앞에 따로 붙여주자.
		//String path11 = req.getRealPath("image");	// image폴더 path
		// /users/shinys/imagesave <- 신유수오빠 이미지 경로
		
		//String path = "d:\\picture\\" ;
		String path = "";
		String filename = fileName + "_" + UUID.randomUUID().toString() + "." + ext;
		
		String os = System.getProperty("os.name").toLowerCase();
		if(os.indexOf("win") > -1){
			path = "d:\\picture\\" ;
		}else if(os.indexOf("mac") > -1){
			path = "/users/shinys/imagesave/";
		}
		
		// 불러온 파일 저장할 공간 생성
		File profile = new File(path + filename);
		try {
			multipartFile.transferTo(profile);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		MemberVo memberVo = (MemberVo) session.getAttribute("SESSION_MEMBERVO");
		String memId = memberVo.getMemId();
		
		teamVo.setMakerId(memId);
//		teamVo.setTeamImg(path +"\\" + filename);
		teamVo.setTeamImg(filename);
		
		// 팀 생성
		teamMember.add(memId);	// 멤버에 생성자 추가
		teamService.insertTeam(teamVo, teamMember);
		
		return "redirect:/mypage";
	}
	
	@RequestMapping(path="/auto", method=RequestMethod.GET)
	public String auto(Model model, String value){
		
		List<MemberVo> list = memberService.getAutoFindMem(value);
		
		JSONArray array = new JSONArray();
		
		for(MemberVo vo : list){
			JSONObject obj = new JSONObject();
			obj.put("img", vo.getMemImg());
			obj.put("id", vo.getMemId());
			array.add(obj);
		}
		model.addAttribute("array", array);
		return "jsonView";
	}
	
	@RequestMapping("/teamImg")
	public void teamImg(HttpServletRequest req, HttpServletResponse resp, @RequestParam("teamNo") int teamNo) throws IOException{
		
		// 1. 사용자 아이디 파라미터 확인
		// String userId = request.getParameter("userId");

		// 2. 해당 사용자 아이디로 사용자 정보 조회(realFilename)
		TeamVo teamInfo = teamService.getTeamInfo(teamNo);

		// 3-1. memImg 존재 할 경우
		// 3-1-1. 해당 경로의 파일을 FileInputStream으로 읽는다.
		FileInputStream fis;
		String path = "";
		String os = System.getProperty("os.name").toLowerCase();
		if(os.indexOf("win") > -1){
			path = "d:\\picture\\" ;
		}else if(os.indexOf("mac") > -1){
			path = "/users/shinys/imagesave/";
		}
		
		if (teamInfo != null && teamInfo.getTeamImg() != null) {
			fis = new FileInputStream(new File(path + teamInfo.getTeamImg()));
		}
		// 3-2. memImg 존재하지 않을 경우
		// 3-2-1. /image/noImg.png(application.getRealPath())
		else {
			ServletContext application = req.getServletContext();
			String noimgPath = application.getRealPath("/image/noImg.png");
			fis = new FileInputStream(new File(noimgPath));
		}
		// 4. FileInputStream을 response객체의 outputStream 객체에 write
		ServletOutputStream sos = resp.getOutputStream();

		byte[] buff = new byte[512];
		int len = 0;
		while ((len = fis.read(buff)) > -1) {
			sos.write(buff);
		}

		sos.close();
		fis.close();
	}
	
	@RequestMapping("/authUpdate")
	public String authUpdate(TeamListVo teamListVo, Model model){
		
		teamService.authUpdate(teamListVo);
		
		String teamAuth = teamListVo.getTeamAuth();
		String auth = "";
		if(teamAuth.equals("user")){
			auth = "admin";
		}else if(teamAuth.equals("admin")){
			auth = "user";
		}
		model.addAttribute("auth", auth);
		
		return "jsonView";
	}
	
	@RequestMapping("/delMember")
	public String delMember(TeamListVo teamListVo, TeamVo teamVo, Model model, HttpSession session){
		
		Object memberVoObj = session.getAttribute("SESSION_MEMBERVO");
		MemberVo memberVo = (MemberVo) memberVoObj;
		
		String loginId = memberVo.getMemId();
		
		teamService.delMember(teamListVo);
		
		MessageVo vo = new MessageVo();
		String msgContent = "";
		vo.setTeamNo(teamVo.getTeamNo());
		vo.setMsgType("n");
		
		if(loginId.equals(teamListVo.getMemId())){
			// 팀 생성자에게 탈퇴 알림 보내기
			msgContent = teamListVo.getMemId() + " 님이 " + teamVo.getTeamNm() + " 팀을 탈퇴하였습니다.";
			vo.setReceiverId(teamVo.getMakerId());
			vo.setSenderId(memberVo.getMemId());
			
		}else if(loginId.equals(teamVo.getMakerId())){
			// 팀에서 제외당한 멤버에게 알림 보내기
			msgContent = teamVo.getMakerId() + " 님이 " + teamVo.getTeamNm() + " 팀에 " + teamListVo.getMemId() + " 님을 제외 하였습니다. ";
			vo.setReceiverId(teamListVo.getMemId());
			vo.setSenderId(teamVo.getMakerId());
		}
		vo.setMsgContent(msgContent);
		messageService.insertMsgOne(vo);
		
		return "jsonView";
	}
	
	@RequestMapping(path="/teamModify", method=RequestMethod.GET)
	public String teamModify(@RequestParam("teamNo")int teamNo, Model model){
		TeamVo teamInfoVo = teamService.getTeamInfo(teamNo);
		List<MemberVo> teamMemberList = teamService.getTeamMember(teamNo);
		
		model.addAttribute("teamInfoVo", teamInfoVo);
		model.addAttribute("teamMemberList", teamMemberList);
		
		return "jsonView";
	}
	// 팀 수정
	@RequestMapping(path = "/teamModify", method = RequestMethod.POST)
	public String teamModifyPost(TeamVo teamVo, @RequestParam("addMember")List<String> addMember, @RequestParam("delMember")List<String> delMember, HttpServletRequest req,
			@RequestPart("profileImg") MultipartFile multipartFile) throws Exception, IOException {
		
		TeamVo teamp_vo = teamService.getTeamInfo(teamVo.getTeamNo());
		String realFile = teamp_vo.getTeamImg();
		
		if (multipartFile.getSize() > 0) {
			String[] split;
			String fileName = "";
			String ext = "";

			split = multipartFile.getOriginalFilename().split("\\.");
			fileName = split[0]; // 파일 이름
			ext = split[1]; // 확장자

			//String path = req.getRealPath("image"); // image폴더 path
			String path = "";
			String os = System.getProperty("os.name").toLowerCase();
			if(os.indexOf("win") > -1){
				path = "d:\\picture\\" ;
			}else if(os.indexOf("mac") > -1){
				path = "/users/shinys/imagesave/";
			}

			String filename = fileName + "_" + UUID.randomUUID().toString() + "." + ext;

			realFile = filename;
			
			// 불러온 파일 저장할 공간 생성
			File profile = new File(path + realFile);
			multipartFile.transferTo(profile);
		}
		teamVo.setTeamImg(realFile);
		 
		teamService.teamMofify(teamVo, addMember, delMember);
		
		return "redirect:/team?teamNo=" + teamVo.getTeamNo();
	}
	
	@RequestMapping(path = "/teamDelete", method = RequestMethod.POST)
	public String teamDelete(TeamVo teamVo){
		teamService.teamDel(teamVo);	// 팀 삭제
		return "redirect:/mypage";
	}

}
