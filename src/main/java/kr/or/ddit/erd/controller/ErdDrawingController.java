package kr.or.ddit.erd.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Base64;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
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

import kr.or.ddit.erd.model.ChatVo;
import kr.or.ddit.erd.model.DomainVo;
import kr.or.ddit.erd.model.ErdVo;
import kr.or.ddit.erd.service.IErdDrawingService;
import kr.or.ddit.erdhistory.model.ErdHistVo;
import kr.or.ddit.member.model.MemberVo;

@RequestMapping("/erddrawing") 
@Controller
public class ErdDrawingController {
	private Logger logger = LoggerFactory.getLogger(ErdDrawingController.class);
	
	@Resource(name="erdDrawingService")
	private IErdDrawingService erdDrawingService;
	
	@RequestMapping(path="/domainList", method=RequestMethod.GET)
	public String domainList(Model model, int erdNo){
		
		List<DomainVo> list = erdDrawingService.domainList(erdNo);
		model.addAttribute(list);
		
		return "jsonView";
	}
	

	@RequestMapping(path="/domainUpdate", method=RequestMethod.GET)
	public String domainUpdate(DomainVo domainVo){

		erdDrawingService.domainUpdate(domainVo);
		
		//model.addAttribute("updateNm",updateNm);
		
		return "jsonView";
	}
	
	
	@RequestMapping(path="/domainDelete", method=RequestMethod.GET)
	public String domainDelete(int domainNo){
		
		erdDrawingService.domainDelete(domainNo);
		
		return "jsonView";
	}
	
	
	@RequestMapping(path="/domainSearch", method=RequestMethod.GET)
	public String domainSearch(Model model, DomainVo domainVo){
		
		List<DomainVo> list = erdDrawingService.domainSearch(domainVo);
		model.addAttribute(list);
		
		return "jsonView";
	}
	
	//도메인 1개만 찾아서 가져오기 (erd에 도메인 입력시 사용)
		@RequestMapping(path="/domainOneSearch", method=RequestMethod.GET)
		public String domainOneSearch(Model model, DomainVo domainVo){
			
			List<DomainVo> list = erdDrawingService.domainOneSearch(domainVo);
			model.addAttribute(list);
			
			return "jsonView";
		}

	
	@RequestMapping(path="/erdHistInsert", method=RequestMethod.POST)
	public String erdHistInser(ErdHistVo erdHistVo, String realFile) throws IOException{
		//String realFile = null;
		if(erdHistVo.getSnapImg() != null){
			String path = "";
			try {
				logger.debug("if문 탔음 ====================={}");
				String os = System.getProperty("os.name").toLowerCase();
				logger.debug("os ====================={}",os);
				if(os.indexOf("win") > -1){
					path = "d:\\picture\\" ;
				}else if(os.indexOf("mac") > -1){
					path = "/users/shinys/imagesave/";
				}
				
				
				String savename =  UUID.randomUUID().toString();
				
				String snapshot = erdHistVo.getSnapImg();
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
				
				realFile = path+savename + ".png";
				
				logger.debug("realFile====================={}",realFile);
				erdHistVo.setSnapImg(realFile);
			} catch (IOException e) {
				throw e;
			}
		}
		erdDrawingService.erdHistInsert(erdHistVo);
		
		return "jsonView";
	}
	
	
	@RequestMapping(path="erdMaxHistSelect", method=RequestMethod.POST)
	public String erdMaxHistSelect(Model model, int erdNo){
		
		ErdHistVo vo = erdDrawingService.erdMaxHistSelect(erdNo);
		model.addAttribute("erdHistVo", vo);
		
		return "jsonView"; 
	}
	
	
	@RequestMapping(path="erdHistList", method=RequestMethod.POST)
	public String erdHistList(Model model, int erdNo){
		
		List<ErdHistVo> list = erdDrawingService.erdHistList(erdNo);
		model.addAttribute("erdHistList", list);
		
		return "jsonView"; 
	}
	
	
	@RequestMapping(path="erdSnapList", method=RequestMethod.POST)
	public String erdSnapList(Model model, int erdNo){
		
		List<ErdHistVo> list = erdDrawingService.erdSnapList(erdNo);
		model.addAttribute("erdSnapList", list);
		
		return "jsonView"; 
	}
	
	@RequestMapping(path="chatInsert", method=RequestMethod.POST)
	public String chatInsert(ChatVo chatVo, HttpSession session){
		
		MemberVo memberVo = (MemberVo) session.getAttribute("SESSION_MEMBERVO");
		String memId = memberVo.getMemId();
		chatVo.setMemId(memId);
		
		erdDrawingService.chatInsert(chatVo);
		
		return "jsonView";
	}
	@RequestMapping(path="chatList", method=RequestMethod.POST)
	public String chatList(ChatVo chatVo, Model model){
		List<ChatVo> chatList = erdDrawingService.chatList(chatVo.getErdNo());
		model.addAttribute("chatList", chatList);
		return "jsonView";
	}
	
	//yhs 스냅샷 찍을 떄 이미지저장 메서드
	@RequestMapping(path = "/erdSnapshot", method = RequestMethod.GET)
	public void erdSnapshot(@RequestParam(name="erdHistNo") int erdHistNo, HttpServletResponse resp, HttpServletRequest req) throws IOException{
		resp.setContentType("image");
		logger.debug("snapImg====1231231231231======{}");
		logger.debug("erdHistNo====1231231231231======{}", erdHistNo);
		String selectSnapImg = erdDrawingService.selectSnapImg(erdHistNo);
		logger.debug("selectSnapImg====1231231231231======{}",selectSnapImg);
		
		FileInputStream fis;
		fis = new FileInputStream(new File(selectSnapImg));
		// 4.2을 response객체의 outputStream 객체에 write
				ServletOutputStream sos = resp.getOutputStream();
				byte[] buff = new byte[512];
				int len = 0;
				while ((len = fis.read(buff)) > -1) {
					sos.write(buff);

				}

				sos.flush();
				sos.close();
				fis.close();
		
	}
	
	@RequestMapping(path="erdSnapJson", method=RequestMethod.POST)
	public String erdSnapJson(Model model, int erdHistNo){
		
		String erdJson = erdDrawingService.selectErdJson(erdHistNo);
		logger.debug("erdJsonerdJson{}", erdJson);
		model.addAttribute("erdJson", erdJson);
		
		return "jsonView"; 
	}
	
	
}
