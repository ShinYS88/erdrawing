package kr.or.ddit.erd.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.erd.model.ChatVo;
import kr.or.ddit.erd.model.DomainVo;
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
	
	@RequestMapping(path="/erdHistInsert", method=RequestMethod.POST)
	public String erdHistInser(ErdHistVo erdHistVo){
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
	
}
