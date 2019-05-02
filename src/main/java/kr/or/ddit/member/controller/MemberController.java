package kr.or.ddit.member.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.annotation.Resource;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.api.mail.IMailService;
import kr.or.ddit.erd.service.IErdService;
import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.post.model.ReportVo;
import kr.or.ddit.util.encrypt.kisa.sha256.KISA_SHA256;
import kr.or.ddit.util.model.PageVo;

@RequestMapping("/member")
@Controller
public class MemberController {
	
	private Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Resource(name = "memberService")
	private IMemberService memberService;
	
	@Resource(name = "mailService")
	private IMailService mailService;
	
	@Resource(name="erdService")
	private IErdService erdService;
	
	@RequestMapping("/join")	//회원가입
	public String join(MemberVo memVo,RedirectAttributes ra,HttpServletRequest req){
		logger.debug("===={}",memVo);
		String pass =KISA_SHA256.encrypt(memVo.getMemPass());
		MemberVo vo = new MemberVo(memVo.getMemId(), memVo.getMemMail(),pass , memVo.getMemNm(),"kr", "basic");
		int cnt = memberService.insertMember(vo);
		
		if(cnt==1){
			ra.addFlashAttribute("msg", "회원가입에 성공 하셨습니다.");
		}else{
			ra.addFlashAttribute("msg", "회원가입에 실패하셨습니다.");
			return "join";
		}
		return "redirect:" + req.getContextPath() +"/";
		
	}
	
	
	
	
	
	@RequestMapping("/checkId")	//아이디 중복 체크
	public String checkId(MemberVo memVo,RedirectAttributes ram,Model model){
		MemberVo memId = memberService.selectMember(memVo.getMemId());
		if(memId==null){
		model.addAttribute("check", "OK");
		}else{
			model.addAttribute("check", "No");
		}
		return "jsonView";
		
	}
	 @RequestMapping("/sendMail")
	    public String sendMailAuth(HttpSession session, @RequestParam String email,Model model) {
		 int ran = new Random().nextInt(100000) + 10000; // 10000 ~ 99999
	        String joinCode = String.valueOf(ran);
	 
	        String subject = "회원가입 인증 코드 발급 안내 입니다.";
	        StringBuilder sb = new StringBuilder();
	        sb.append("귀하의 인증 코드는 " + joinCode + " 입니다.");
	        boolean send = mailService.send(subject, sb.toString(), "prings196s@gmail.com", email, null);
	        model.addAttribute("check", send);
	        model.addAttribute("joinCode", joinCode);
	        return "jsonView";
	    }
	 
	 // imageView
	 @RequestMapping("/memberImg")
	 public void memberImg(HttpServletRequest req, HttpServletResponse resp, @RequestParam("memId") String memId) throws IOException{
		 	// 1. 사용자 아이디 파라미터 확인
			// String userId = request.getParameter("userId");

			// 2. 해당 사용자 아이디로 사용자 정보 조회(realFilename)
		 	MemberVo memberVo = memberService.selectMember(memId);
		 	
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
			if (memberVo != null && memberVo.getMemImg() != null) {
				fis = new FileInputStream(new File(path+memberVo.getMemImg()));
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
	 

	 
	 //임시 비밀번호 보내기
	 @RequestMapping("/sendMailPw")
	    public String sendMailPw(HttpSession session, @RequestParam String email,Model model, MemberVo memVo) {
		 MemberVo memvo = null;
		if(memVo.getMemId()!=null || !memVo.getMemId().equals(""))
		 memvo = memberService.selectMember(memVo.getMemId());
		 
		 if(memvo!=null&&memvo.getMemEmailDiv().equals("basic")){
		 
		 String uuid = UUID.randomUUID().toString().replaceAll("-", ""); // -를 제거해 주었다. 
	        uuid = uuid.substring(0, 10); //uuid를 앞에서부터 10자리 잘라줌. 

	        String subject = "회원가입 인증 코드 발급 안내 입니다.";
	        StringBuilder sb = new StringBuilder();
	        sb.append("귀하의 인증 코드는 " + uuid + " 입니다.");
	        mailService.send(subject, sb.toString(), "prings196s@gmail.com", email, null);
	        
	        memvo.setMemPass(KISA_SHA256.encrypt(uuid));
	        memvo.setMemId(memVo.getMemId());
	        memberService.updateMemPw(memvo);	
	        model.addAttribute("check", "ok");
	        return "jsonView";
		 }else if(memvo!=null&&memvo.getMemEmailDiv().equals("google")){
			 model.addAttribute("check", "bx");
			 return "jsonView";
		 }else if(memvo!=null&&memvo.getMemEmailDiv().equals("kakao")){
			 model.addAttribute("check", "bx");
			 return "jsonView";
		 }else{
			 model.addAttribute("check", "no");
			 return "jsonView";
		 }
	    }
	 
	 //아이디 찾기
	@RequestMapping("/idSearch")
	public String idSearch(HttpServletRequest req, HttpServletResponse resp, MemberVo memVo, Model model)
			throws IOException {
		logger.debug("===sss{}", memVo);
		List<MemberVo> memList = memberService.getMemId(memVo);

		if (memList != null) {
			for (MemberVo memvo : memList) {
				if(memvo.getMemEmailDiv().equals("basic")){
					model.addAttribute("check", "ok");
					model.addAttribute("id", memvo.getMemId());
			        return "jsonView";
				}else if(memvo.getMemEmailDiv().equals("google")){
					 model.addAttribute("check", "bx");
					 return "jsonView";
				 }else{
					 model.addAttribute("check", "bx");
					 return "jsonView";
				 }
			}
		}else{
			 model.addAttribute("check", "no");
			 return "jsonView";
		 } model.addAttribute("check", "no");
		 return "jsonView";
	}
	
	//전체회원 리스트 페이지 요청
	 @RequestMapping("/memberList")
	    public String memberList(@RequestParam(name = "page", defaultValue = "1") int page, Model model) {


		 PageVo paging = new PageVo(); // 페이징 처리를 위해 페이징 객체 생성 Paging 이라는 VO가 존재함
			paging.setPageNo(page);
			paging.setPageSize(10);

			List<MemberVo> memList = memberService.selectMemPagingList(paging);

			model.addAttribute("memList", memList);
			model.addAttribute("paging", paging);

		 return "memList";
	 }
		 
	 
	 @RequestMapping("/memberDel")
	 public String memberDel(@RequestParam(name = "page", defaultValue = "1") int page, Model model,MemberVo memVo,RedirectAttributes ra){
		 	logger.debug("name=={}",memVo.getMemId());
				MemberVo vo = memberService.selectMember(memVo.getMemId());
		 if(vo!=null){
			 vo.setMemCancelFlag("T");
		 int delCnt =memberService.updateMemberDel(vo);
		 	if(delCnt==1){
		 	ra.addFlashAttribute("msg", "삭제가 완료 되었습니다.");	
		 	}
		 	else{
		 		ra.addFlashAttribute("msg", "삭제가 되지 않았습니다.");}
		 }	 
		 PageVo paging = new PageVo(); // 페이징 처리를 위해 페이징 객체 생성 Paging 이라는 VO가 존재함
			paging.setPageNo(page);
			paging.setPageSize(10);
			
			List<MemberVo> memList = memberService.selectMemPagingList(paging);
			
			model.addAttribute("memList", memList);
			model.addAttribute("paging", paging);
			 
		 return "member/memListPagingHtml";
	 }

	
	 
		//전체회원 리스트 페이지 요청
	 @RequestMapping("/memberAjaxList")
	    public String memberAjaxList(@RequestParam(name = "page", defaultValue = "1") int page, Model model) {

		 PageVo paging = new PageVo(); // 페이징 처리를 위해 페이징 객체 생성 Paging 이라는 VO가 존재함
			paging.setPageNo(page);
			paging.setPageSize(10);
			
			List<MemberVo> memList = memberService.selectMemPagingList(paging);
			
			model.addAttribute("memList", memList);
			model.addAttribute("paging", paging);
			 
		 return "member/memListPagingHtml";
	 }
	 
	 
	 @RequestMapping("/memModifyModal")
	    public String memModifyModal(@RequestParam(name = "page", defaultValue = "1") int page, Model model,MemberVo memVo) {
		 logger.debug("====memVo1{}",memVo);
		 
		 memVo = memberService.selectMember(memVo.getMemId());

		 SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		 String inDate = transFormat.format(memVo.getMemInDt());
		 
		 model.addAttribute("memVo", memVo);
		 model.addAttribute("inDate", inDate);
			 
		 return "jsonView";
	 }
	 
	 @RequestMapping("/memModalModify")
	    public String memModalModify(@RequestParam(name = "page", defaultValue = "1") int page, Model model,MemberVo memVo) {
		 logger.debug("====ssss{}",memVo);
		 MemberVo vo =memberService.selectMember(memVo.getMemId());
		 if(memVo.getMemPass()==null){
			memVo.setMemImg(vo.getMemImg());
			memVo.setMemPass(vo.getMemPass());
			 memberService.updateMemberInfo(memVo);
		 }else{
		 memVo.setMemImg(vo.getMemImg());
		 memVo.setMemPass(KISA_SHA256.encrypt(memVo.getMemPass()));
		 memberService.updateMemberInfo(memVo);
		 }
		 PageVo paging = new PageVo(); // 페이징 처리를 위해 페이징 객체 생성 Paging 이라는 VO가 존재함

			paging.setPageNo(page);
			paging.setPageSize(10);

			List<MemberVo> memList = memberService.selectMemPagingList(paging);

			model.addAttribute("memList", memList);
			model.addAttribute("paging", paging);
			 
		 return "memList";
	 }
	 
	 @RequestMapping("/memberErd")
	 public String memberErd(@RequestParam("memId")String memId, Model model){
		 MemberVo memberVo = memberService.selectMember(memId);
		 model.addAttribute("memberVo", memberVo);
		 
		// erd와 tagList Map으로 넘겨줌
		Map<String, Object> myErdTagMap = erdService.getMyErdTagMap(memId);
		model.addAllAttributes(myErdTagMap);
		 
		 return "memberErdPage";
	 }

	@RequestMapping("/memberModify")
	public String memberModify(MultipartFile profileImg, HttpSession session, Model model, MemberVo memVo, String imgDelCk,
			HttpServletRequest req) throws IllegalStateException, IOException {
		logger.debug("====ssss{}", memVo);
		logger.debug("====ssss{}", profileImg);

		MemberVo vo = memberService.selectMember(memVo.getMemId());

		String filename = vo.getMemImg();
		//수정시
		if (profileImg.getSize() > 0) {
			filename = UUID.randomUUID() +profileImg.getOriginalFilename();
			String path = "";
		      String os = System.getProperty("os.name").toLowerCase();
		      if(os.indexOf("win") > -1){
		         path = "d:\\picture\\" ;
		      }else if(os.indexOf("mac") > -1){
		         path = "/users/shinys/imagesave/";
		      }
			String pathFilename = path +  filename;

			profileImg.transferTo(new File(pathFilename));
		}
		
		logger.debug("imgDelck===={}",imgDelCk);
		if(imgDelCk.equals("imgno")){
			vo.setMemImg(null);
		}else{
			vo.setMemImg(filename);	
		}
		
		
		vo.setMemNm(memVo.getMemNm());
		
		if(memVo.getMemPass()!=null){
		vo.setMemPass(KISA_SHA256.encrypt(memVo.getMemPass()));}
		vo.setMemIntro(memVo.getMemIntro());
		vo.setMemMail(memVo.getMemMail());
		memberService.updateMemberInfo(vo);
		return "redirect:" + req.getContextPath() + "/";
	}

	@RequestMapping("/memRepotList")
	public String memRepotList(HttpSession session, Model model, MemberVo memVo, HttpServletRequest req,
			RedirectAttributes ra) {
		logger.debug("====ssss{}", memVo);
		List<ReportVo> reportList = memberService.selectReport(memVo.getMemId());
		model.addAttribute("reportList", reportList);

		List<String> inDate = new ArrayList<>();
		for (ReportVo reVo : reportList) {

			SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-ss");
			inDate.add(sdf.format(reVo.getReportDt()));
		}
		model.addAttribute("inDate", inDate);
		return "jsonView";
	}
	
	//회원탈퇴
	@RequestMapping("/memberDelete")
	public String memberDelete(HttpSession session, Model model, MemberVo memVo, HttpServletRequest req,
			RedirectAttributes ra) {
		logger.debug("====ssss{}", memVo);
		memVo.setMemCancelFlag("T");
		memberService.updateMemberDel(memVo);
		ra.addFlashAttribute("msg", "계정 탈퇴가 완료되었습니다.        "
									+ "ERDrawing을 이용해주셔서 감사합니다.  "
				+"더욱 발전하는 ERDrawing가 되겠습니다");
		session.removeAttribute("SESSION_MEMBERVO");
		return "redirect:" + req.getContextPath() +"/";
	}

}


	 
	 

