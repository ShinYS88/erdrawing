package kr.or.ddit.message.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.message.model.MessageVo;
import kr.or.ddit.message.service.IMessageService;
import kr.or.ddit.team.model.TeamListVo;
import kr.or.ddit.util.model.PageVo;

@RequestMapping("/message")
@Controller
public class MessageController {
	private Logger logger = LoggerFactory.getLogger(MessageController.class);
	
	@Resource(name="messageService")
	IMessageService messageService;
	
	@RequestMapping("/messageView")
	public String messageView(){
		return "member/message";
	}
	
	// 알림 회신
	@RequestMapping("/insertMsg")
	public String insertMsg(MessageVo msgVo, @RequestParam("value")String value, HttpSession session){
		logger.debug("===dfdsfs==msgVo : {}", msgVo);
		logger.debug("===dfdsfs==value : {}", value);
		
		Object obj = session.getAttribute("SESSION_MEMBERVO");
		MemberVo memberVo = (MemberVo)obj;
		
		String memId = memberVo.getMemId();
		String receiverId = msgVo.getSenderId();	// 알림 보낸 멤버한테 답장
		String content="";
		int teamNo = msgVo.getTeamNo();
		
		msgVo.setReceiverId(receiverId);
		msgVo.setSenderId(memId);
		msgVo.setMsgType("n");
		
		TeamListVo teamListVo = new TeamListVo();
		teamListVo.setMemId(memId);
		teamListVo.setTeamNo(teamNo);
		
		switch(value){
			case "yes":
				content = memId + " 님이 초대를 수락하였습니다.";
				msgVo.setMsgContent(content);
				teamListVo.setTeamAgreeFlag("y");
				
				messageService.insertAplyMsg(msgVo, teamListVo);
				break;
				
			case "no":
				content = memId + " 님이 초대를 거절하였습니다.";
				msgVo.setMsgContent(content);
				teamListVo.setTeamAgreeFlag("n");
				
				messageService.insertAplyMsg(msgVo, teamListVo);
				break;
				
			case "del":
				messageService.delMsg(msgVo.getMsgNo());
				break;
				
			case "delAll":
				messageService.delMsgAll(memId);
				break;
		}
		
		return "jsonView";
	}
	
	// 알림창 페이징
	@RequestMapping("/msgAjax")
	public String msgAjax(@RequestParam(name="page", defaultValue="1" )int page, Model model, HttpSession session){
		Object obj = session.getAttribute("SESSION_MEMBERVO");
		MemberVo memVo = (MemberVo) obj;
		
		PageVo pageVo = new PageVo();
		pageVo.setPageNo(page);
		//pageVo.setPageSize(5);
		
		List<MessageVo> msgPagingList = messageService.msgPagingList(pageVo, memVo.getMemId());
		
		model.addAttribute("msgPagingList", msgPagingList);
		model.addAttribute("paging", pageVo);
		
		return "member/messagePagingHtml";
	}

}
