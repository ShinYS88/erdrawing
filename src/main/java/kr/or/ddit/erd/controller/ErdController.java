package kr.or.ddit.erd.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Base64;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.erd.model.ErdLikeVo;
import kr.or.ddit.erd.model.ErdVo;
import kr.or.ddit.erd.service.IErdService;
import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.team.model.TagVo;
import kr.or.ddit.team.service.ITeamService;
import kr.or.ddit.ticket.service.ITicketService;
import kr.or.ddit.util.model.PageVo;

@RequestMapping("/erd")
@Controller
public class ErdController {
	private Logger logger = LoggerFactory.getLogger(ErdController.class);
	
	@Resource(name="erdService")
	private IErdService erdService;
	
	@Resource(name="teamService")
	private ITeamService teamService;
	
	@Resource(name="ticketService")
   private ITicketService ticketService;
	
	
	@RequestMapping(path = { "/erdAdd" }, method = { RequestMethod.POST })
	public String makeErd(ErdVo erdVo, @RequestParam("tag")String tag, HttpSession session, Model model,RedirectAttributes ra){

		MemberVo memberVo = (MemberVo) session.getAttribute("SESSION_MEMBERVO");
		String memId = memberVo.getMemId();
		
		// 1. 공개설정이 팀일 때와 아닐 때 insert 값이 달라야 한다. --> xml에서 nullif문 이용
		// 1.1 팀일 때는 memId가 null이어야 한다.
		// 1.2 개인일 때는 teamNo가 null이어야 한다.
		// 2. erd 생성과 태그 생성은 동시에 이뤄져야 한다.
		// 3. 생성 된 erd의 번호로 등록한 tag들과 맵핑이 돼야 한다.(tagHist)
		
		// 공개설정이 팀일 때
		if(erdVo.getErdScope().equals("team")){
			erdVo.setMemId(memberVo.getMemId());
			erdVo.setTeamNo(erdVo.getTeamNo());
		}
		// 공개설정이 개인일 때
		else {
			erdVo.setMemId(memberVo.getMemId());
			erdVo.setTeamNo(0);
		}
		erdService.addErdTag(erdVo, tag, memId);
		
		return "redirect:/mypage";
	}
	
	@RequestMapping("/delErd")
	public String delErd(@RequestParam("erdNo")int erdNo){
		erdService.delErd(erdNo);
		
		return "jsonView";
	}
	
	// 라이브러리 erd 페이징 ajax
	@RequestMapping("/libErdAjax")
	public String libErdAjax(@RequestParam(name = "page", defaultValue = "1")int page, @RequestParam(name = "tagContent", required = false)String tagContent, Model model, HttpSession session) {
		
		PageVo pageVo = new PageVo();
		pageVo.setPageNo(page);
		Map<String, Object> allErdListPaging;
		
		// 검색일 때 페이징
		if(!tagContent.isEmpty()){
			pageVo.setSearch(tagContent);
			allErdListPaging = erdService.searchPagingList(pageVo);
		}else{ // 모든 erd paging
			allErdListPaging = erdService.getAllErdListPaging(pageVo);
		}
		model.addAllAttributes(allErdListPaging);
		model.addAttribute("paging", pageVo);
		
		return "jsonView";
	}
	
	// erd 모달 검색
	@RequestMapping("/erdSearch")
	public String erdSearch(@RequestParam("searchTxt_modal")String searchTxt, Model model){
		List<ErdVo> searchList = erdService.searchList(searchTxt);
		model.addAttribute(searchList);
		
		return "jsonView";
	}
	
	// erd 이미지 조회
	@RequestMapping("/erdImg")
	public void erdImg(HttpServletRequest req, HttpServletResponse resp, @RequestParam("erdNo") int erdNo) throws IOException{

		// 2. 해당 사용자 아이디로 사용자 정보 조회(realFilename)
		ErdVo erdInfo = erdService.getErdInfo(erdNo);

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
		
		if (erdInfo != null && erdInfo.getErdImg() != null) {
			fis = new FileInputStream(new File(path + erdInfo.getErdImg()));
		}
		// 3-2. memImg 존재하지 않을 경우
		// 3-2-1. /image/noImg.png(application.getRealPath())
		else {
			ServletContext application = req.getServletContext();
			String noimgPath = application.getRealPath("/image/noimg1.png");
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
	
	@RequestMapping(path = "erdModify", method = RequestMethod.GET)
	public String erdModify(@RequestParam("erdNo")int erdNo, Model model){
		
		ErdVo erdVo = erdService.getErdInfo(erdNo);	// erd 정보
		List<TagVo> tagList = teamService.getErdTag(erdNo);	// erd Tag
		
		model.addAttribute("erdVo", erdVo);
		model.addAttribute("tagList", tagList);
		
		return "jsonView";
	}
	
	@RequestMapping(path = "erdModify", method = RequestMethod.POST)
	public String erdModifyPost(ErdVo erdVo, @RequestParam("tag")String tag, @RequestParam(name="snapshot", required = false)String snapshot, @RequestPart("profileImg") MultipartFile multipartFile, HttpServletRequest req, HttpSession session) throws IOException{
		//erdno 없음 
		
		MemberVo memberVo = (MemberVo) session.getAttribute("SESSION_MEMBERVO");
		String memId = memberVo.getMemId();
		
		// 공개설정이 팀일 때
		if(erdVo.getErdScope().equals("team")){
			erdVo.setTeamNo(erdVo.getTeamNo());
		}
		// 공개설정이 개인일 때
		else{
			erdVo.setMemId(memberVo.getMemId());
			erdVo.setTeamNo(0);
		}

		String path = "";
		String os = System.getProperty("os.name").toLowerCase();
		if(os.indexOf("win") > -1){
			path = "d:\\picture\\" ;
		}else if(os.indexOf("mac") > -1){
			path = "/users/shinys/imagesave/";
		}
		
		String savename =  UUID.randomUUID().toString();
		
		ErdVo tempVo = erdService.getErdInfo(erdVo.getErdNo());
		String realFile = tempVo.getErdImg();
		
		if (multipartFile.getSize() > 0) {
			String[] split;
			String fileName = "";
			String ext = "";

			split = multipartFile.getOriginalFilename().split("\\.");
			fileName = split[0]; // 파일 이름
			ext = split[1]; // 확장자

			String filename = fileName + "_" + UUID.randomUUID().toString() + "." + ext;

			realFile = filename;
			
			// 불러온 파일 저장할 공간 생성
			File profile = new File(path + realFile);
			multipartFile.transferTo(profile);
		}
		// 스냅샷일 경우
		else if(!snapshot.isEmpty()){
			try {
				// create a buffered image
				BufferedImage image = null;
				String[] base64Arr = snapshot.split(","); // image/png;base64, 이 부분 버리기 위한 작업
				byte[] imageByte = Base64.getDecoder().decode(base64Arr[1]); // base64 to byte array로 변경
				
				ByteArrayInputStream bis = new ByteArrayInputStream(imageByte);
				image = ImageIO.read(bis);
				bis.close();
		
				// write the image to a file
				
				File outputfile = new File(path + savename + ".png");
				ImageIO.write(image, "png", outputfile); // 파일생성
				
				realFile = savename + ".png";
				
			} catch (IOException e) {
				throw e;
			}
		}
  		erdVo.setErdImg(realFile);
  		
  		erdService.erdUdt(erdVo, memId, tag);	// erd 수정


		return "redirect:/mypage";
	}
	
	@RequestMapping("/erdTitleEdit")
	public String erdTitleEdit(ErdVo erdVo, Model model){
		ErdVo erdInfoVo = erdService.getErdInfo(erdVo.getErdNo());
		erdInfoVo.setErdTitle(erdVo.getErdTitle());
		
		erdService.erdTitleEdit(erdInfoVo);
		
		model.addAttribute("erdTitle", erdInfoVo.getErdTitle());
		
		return "jsonView";
	}
	
	
	/**
	* Method : erdLikeClick
	* 작성자 : PC08
	* 변경이력 :
	* @param erdLikeVo
	* @param session
	* @return
	* Method 설명 : erd 좋아요 클릭
	*/
	@RequestMapping("/erdLikeClick")
	public String erdLikeClick(ErdLikeVo erdLikeVo, HttpSession session){
		MemberVo memberVo = (MemberVo) session.getAttribute("SESSION_MEMBERVO");
		String memId = memberVo.getMemId();
		
		erdLikeVo.setMemId(memId);
		
		erdService.erdLikeClick(erdLikeVo);
		
		return "jsonView";
	}
	
	@RequestMapping("/erdCopy")
	public String erdCopy(ErdVo erdVo, HttpSession session){
		MemberVo memberVo = (MemberVo) session.getAttribute("SESSION_MEMBERVO");
		String memId = memberVo.getMemId();
		erdVo.setMemId(memId);
		
		erdService.erdCopy(erdVo);
		
		return "redirect:/mypage";
	}
	
	@RequestMapping("/privateCnt")
	public String privateCnt(HttpSession session, Model model){
		MemberVo memberVo = (MemberVo) session.getAttribute("SESSION_MEMBERVO");
		String memId = memberVo.getMemId();
		String alertMsg ="";
		// private일 경우
		int privateCnt = erdService.getPrivateCnt(memId);
		int usingTicketCnt = ticketService.getUsingTicketCnt(memId);
		if (privateCnt >= 2 && usingTicketCnt <= 0) {	// and 조건으로 이용권 cnt 0이면 추가
			 alertMsg = "private는 2개 까지 무료로 생성 가능합니다." + "\n" + "이용권을 구입해 주세요.";
		}else
			alertMsg = "";
		model.addAttribute("alertMsg",alertMsg);
		return "jsonView";
	}
}
