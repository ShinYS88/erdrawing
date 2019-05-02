package kr.or.ddit.ticket.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
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

import org.apache.commons.collections.map.HashedMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.ticket.model.TicketBuyHistVo;
import kr.or.ddit.ticket.model.TicketRefHistVo;
import kr.or.ddit.ticket.model.TicketVo;
import kr.or.ddit.ticket.service.ITicketService;
import kr.or.ddit.util.model.PageVo;

@RequestMapping("/ticket")
@Controller
public class TicketController {
   
   @Resource(name="ticketService")
   private ITicketService ticketService;
   
   private Logger logger = LoggerFactory.getLogger(TicketController.class);

   @RequestMapping("/ticketList")
   public String ticketList(Model model){
   model.addAttribute("ticketList", ticketService.getAllTicketList());
      return "ticket"; 
   }
   
   @RequestMapping("/CallPaymentKakaoPaySuccess")
   public String CallPaymentKakaoPaySuccess(Model model){
   model.addAttribute("next_redirect_pc_url", "/ticket/CallPay");
      return "jsonView";
   }
   
   @RequestMapping("/CallPay")
   public String CallPay(Model model){
      return "ticket/ticketBuy";
   }
   
   //티켓수정정보요청
	@RequestMapping("/ticketModify")
	public String ticketModify(Model model, String ticketNo) {
		TicketVo ticketVo = ticketService.selectTicket(ticketNo);
		model.addAttribute("ticketVo", ticketVo);
		return "jsonView";
	}
   
   //티켓정수정
   @RequestMapping("/modifyTicket")
   public String modifyTicket(Model model,TicketVo ticketVo,RedirectAttributes ra,HttpServletRequest req,MultipartFile profileImg) throws IllegalStateException, IOException{
      logger.debug("======modify{}",ticketVo);
      
      
      TicketVo vo = ticketService.selectTicket(ticketVo.getTicketNo()+"");

		String filename = vo.getTicketImg();
		
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
		
		ticketVo.setTicketImg(filename);
      
      int updCnt = ticketService.updateTicket(ticketVo);
      
      if(updCnt>0){
         ra.addFlashAttribute("msg", "수정이 완료되었습니다.");
      }else{
         ra.addFlashAttribute("msg", "수정이 실패 하였습니다.");
      }
      
      model.addAttribute("ticketList", ticketService.getAllTicketList());
      return "redirect:" + req.getContextPath() +"/ticket/ticketList";
   }
   
   @RequestMapping("/deleteTicket")
   public String deleteTicket(Model model,TicketVo ticketVo,String ticketNo,RedirectAttributes ra,HttpServletRequest req){
      logger.debug("======delete{}",ticketVo);
      
      int delCnt = ticketService.deleteTicket(ticketNo);
      
      if(delCnt>0){
         ra.addFlashAttribute("msg", "티켓이 삭제되었습니다.");
      }else{
         ra.addFlashAttribute("msg", "실패하였습니다.");
      }
      
      model.addAttribute("ticketList", ticketService.getAllTicketList());
      return "redirect:" + req.getContextPath() +"/ticket/ticketList";
   }
   
   
	// 티켓추가
	@RequestMapping("/insertTicket")
	public String insertTicket(MultipartFile profileImg,Model model, TicketVo ticketVo, RedirectAttributes ra, HttpServletRequest req) throws IllegalStateException, IOException {
		logger.debug("======insertTicket{}", ticketVo);

		String filename="";
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
		
		ticketVo.setTicketImg(filename);
		int inCnt = ticketService.insertTicket(ticketVo);
		
		if (inCnt > 0) {
			ra.addFlashAttribute("msg", "추가 되었습니다.");
		} else {
			ra.addFlashAttribute("msg", "실패 하였습니다.");
		}
		model.addAttribute("ticketList", ticketService.getAllTicketList());
		return "redirect:" + req.getContextPath() + "/ticket/ticketList";
	}
      
	// 티켓차트 페이지
	@RequestMapping("/ticketChart")
	public String ticketChart(Model model, TicketVo ticketVo, RedirectAttributes ra, HttpServletRequest req,
			ModelMap modelMap) throws ParseException {
		List<TicketBuyHistVo> ticketBuyHistList = ticketService.selectTicketYearList("3");

		if (ticketBuyHistList != null) {
			List<List<Map<Object, Object>>> canvasjsDataList = getCanvasjsDataListLine(ticketBuyHistList);
			modelMap.addAttribute("dataPointsList", canvasjsDataList);
			logger.debug("====list{}", canvasjsDataList);
		}
		model.addAttribute("ticketBuyHistList", ticketService.getAllTicketList());

		return "ticketChart";
	}
      
	public List<List<Map<Object, Object>>> getCanvasjsDataListLine(List<TicketBuyHistVo> ticketBuyList) throws ParseException {
		
		Map<Object, Object> map = null;
		List<List<Map<Object, Object>>> list = new ArrayList<List<Map<Object, Object>>>();
		List<Map<Object, Object>> dataPoints1 = new ArrayList<Map<Object, Object>>();
		
		List<TicketVo> allTicket = ticketService.getAllTicketList();
		
		for(int i=0; i<allTicket.size();i++){
			 ticketBuyList = ticketService.selectTicketYearList(allTicket.get(i).getTicketNo()+"");
			 if(ticketBuyList.size()>0){
			 for (TicketBuyHistVo vo : ticketBuyList) {
				SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMdd");
				Date tos = transFormat.parse(vo.getTicketMonDt() + "01");
				long dataLong = tos.getTime();
				
				map = new HashMap<Object, Object>();
				map.put("y"+i, vo.getTicketFee());
				map.put("x"+i, dataLong);
				map.put("showInLegend"+i, "true");
				map.put("name"+i, allTicket.get(i).getTicketContent());
				dataPoints1.add(map);
				}
			}
		}
		list.add(dataPoints1);
		return list;
	}
      
	// 티켓차트(pie) 페이지
	@RequestMapping(path="/ticketPie")
	public String ticketPie(Model model, TicketVo ticketVo, RedirectAttributes ra, HttpServletRequest req,
			ModelMap modelMap,String yyyy,String ticketNo) {
		Map<String, Object> ticketmap = new HashMap<>();
		logger.debug("==ss={}",yyyy);
		if(ticketNo==null){
			List<TicketVo> ticket = ticketService.getAllTicketList();
			 Collections.shuffle(ticket);
			 ticketNo=ticket.get(0).getTicketNo()+"";
		}
		
		if(yyyy.equals("")){
			yyyy="2019";
		}
		
		ticketmap.put("yyyy", yyyy);
		ticketmap.put("yyyyMMdd", yyyy+"0101");
		ticketmap.put("ticketNo", ticketNo);

		List<TicketBuyHistVo> ticketBuyHistList = ticketService.selectTicketYearPieList(ticketmap);

		if (ticketBuyHistList != null) {
			List<List<Map<Object, Object>>> canvasjsDataList = getCanvasjsDataListPie(ticketBuyHistList);
			modelMap.addAttribute("dataPointsListPie", canvasjsDataList);
		}else{
			ra.addFlashAttribute("msg", "값이 존재 하지 않습니다.");
		}
		model.addAttribute("ticketList", ticketService.getAllTicketList());
		model.addAttribute("ticketNo", ticketNo);
		model.addAttribute("ticketTitle", ticketService.selectTicket(ticketNo).getTicketContent());
		model.addAttribute("yyyy", yyyy);
	
		return "ticketPie";
	}
            
      //pie      
	public List<List<Map<Object, Object>>> getCanvasjsDataListPie(List<TicketBuyHistVo> ticketBuyHistList) {
		Map<Object, Object> map = null;
		List<List<Map<Object, Object>>> list = new ArrayList<List<Map<Object, Object>>>();
		List<Map<Object, Object>> dataPoints1 = new ArrayList<Map<Object, Object>>();

		for (TicketBuyHistVo vo : ticketBuyHistList) {
			map = new HashMap<Object, Object>();
			map.put("label", vo.getTicketMonDt().substring(4));
			map.put("y", vo.getTicketFee());
			dataPoints1.add(map);
		}
		list.add(dataPoints1);
		return list;
	}
	
	
	 // imageView
	 @RequestMapping("/ticketImg")
	 public void ticketImg(HttpServletRequest req, HttpServletResponse resp, String ticketNo) throws IOException{
		 	// 1. 사용자 아이디 파라미터 확인
			// String userId = request.getParameter("userId");

			// 2. 해당 사용자 아이디로 사용자 정보 조회(realFilename)
		 	TicketVo tickerVo = ticketService.selectTicket(ticketNo);
		 	
		 	
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
			if (tickerVo != null && tickerVo.getTicketImg() != null) {
				fis = new FileInputStream(new File(path+tickerVo.getTicketImg()));
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
	 
	 //티켓구매
	 @RequestMapping(path="/ticketCardBuy" ,method= { RequestMethod.POST })
	 public String ticketCardBuy(HttpServletRequest req ,int ticketNo,String memId,RedirectAttributes ra){
		 logger.debug("======1{}",ticketNo);
//		 logger.debug("======2{}",memId);
		 ;
		 if(memId != null && ticketNo != 0){
		 TicketBuyHistVo vo = new TicketBuyHistVo();
		 vo.setMemId(memId);
		 vo.setTicketNo(ticketNo);
		 vo.setTicketFee(ticketService.selectTicket(ticketNo+"").getTicketPrice());
		 ticketService.insertticketBuyHist(vo);
		 
		 ra.addFlashAttribute("msg", "결제가 완료되었습니다~");
		 }
			return "redirect:" + req.getContextPath() + "/ticket/ticketList";
	 }
	 
	 
	 //티켓환불 신청 내역
	 @RequestMapping(path="/ticketRefList")
	 public String TicketRefList(HttpServletRequest req ,RedirectAttributes ra,Model model,@RequestParam(name = "page", defaultValue = "1") int page){
		 Map<String, Object> map = new HashMap<>();
		map.put("pageNo", page)	;
		map.put("pageSize", 10)	;
		PageVo paging= new PageVo();
		 paging.setPageNo(page);
		 paging.setPageSize(10);
		 int cnts = Integer.valueOf((String) ticketService.getAllTicketRefList(map).get(0).get("CNT"));
		 paging.setTotalCount(cnts);
		 model.addAttribute("ticketList", ticketService.getAllTicketList());
		 model.addAttribute("ticketRefList", ticketService.getAllTicketRefList(map));
		 model.addAttribute("paging", paging);
			return "ticketRefList";
	 }
	 
	 //티켓환불 신청 내역
	 @RequestMapping(path="/ticketRefAjaxList")
	 public String ticketRefAjaxList(HttpServletRequest req ,RedirectAttributes ra,Model model,@RequestParam(name = "page", defaultValue = "1") int page,String inputstart,String inputend,String searchgroup,String memId,String radioValref,String radioValtic){
		 logger.debug("오나?");
		 logger.debug("오나?inputstart=={}",inputstart);
		 logger.debug("오나?inputend=={}",inputend);
		 logger.debug("오나?searchgroup=={}",searchgroup);
		 logger.debug("오나?memId=={}",memId);
		 logger.debug("오나?radioValref=={}",radioValref);
		 logger.debug("오나?radioValtic=={}",radioValtic);
		 
		 PageVo paging = new PageVo();
			paging.setPageNo(page);
			paging.setPageSize(10);
			
			Map<String, Object> map = new HashMap<>();
			map.put("pageNo", page);
			map.put("pageSize", 10);
			
			
			if(searchgroup.equals("searchNo")){
				;
			}
			else if(searchgroup.equals("날짜")){
				map.put("inputstart", inputstart.substring(6)+inputstart.substring(0, 2)+inputstart.substring(3,5));
				map.put("inputend", inputend.substring(6)+inputend.substring(0, 2)+inputend.substring(3,5));
				map.put("memId", memId);
			}else if(searchgroup.equals("티켓")){
				map.put("ticketNo", radioValtic);
				map.put("memId", memId);
			}else if(searchgroup.equals("구매자")){
				map.put("memId", memId);
			}else if(searchgroup.equals("환불여부")){//환불여부
				if(radioValref.equals("refNull")){
					map.put("cknullOk", "cknullOk");
					map.put("memId", memId);
				}else{
					map.put("cknullNo", "cknullNo");
					map.put("memId", memId);
				}
			}else{
				map.put("pageNo", page);
				map.put("pageSize", 10);
			}
			
			model.addAttribute("ticketRefList", ticketService.getAllTicketRefList(map));
			
			if (ticketService.getAllTicketRefList(map).size() > 0) {
				int cnts = Integer.valueOf((String) ticketService.getAllTicketRefList(map).get(0).get("CNT"));
				paging.setTotalCount(cnts);
			}
		 
			model.addAttribute("paging", paging);
		 
		 return "ticket/ticketRefListHtml";
	 }
	 
	 
	 //티켓환불 신청 정보띄우기
	 @RequestMapping(path="/ticketRefInfo")
	 public String ticketRefInfo(Model model,String ticketBuyNo,ModelMap modelMap){
		 
	List<Map<String, Object>> ticketbuyVo = ticketService.selectTicketBuyHist(ticketBuyNo);
	if(ticketbuyVo.size()>0){
		//ticketbuyVo.get(0).get("")

		//int ticketno = Integer.valueOf((String) ticketbuyVo.get(0).get("TICKETNO"));
		TicketVo ticketvo = ticketService.selectTicket(String.valueOf(ticketbuyVo.get(0).get("TICKETNO")));
		ticketbuyVo.get(0).put("ticketContext",ticketvo.getTicketContent());
		model.addAttribute("ticketbuyVo", ticketbuyVo.get(0));
	}
			return "jsonView";
	 }
	 
	 @RequestMapping(path="/updateTicketRefDt")
	 public String updateTicketRefDt(Model model,String ticbuyNo,HttpServletRequest req){
		 logger.debug("=====ticbuyNo===={}",ticbuyNo);
		 int cnt = ticketService.updateTicketRefDt(ticbuyNo);
		 logger.debug("=====cnt===={}",cnt);
		 return "redirect:" + req.getContextPath() +"/ticket/ticketRefList";
	 }
	 
	 @RequestMapping(path="/myTicket")
	 public String myTicket(Model model,HttpSession session){
		  MemberVo memVo = (MemberVo) session.getAttribute("SESSION_MEMBERVO");
		  
		  //남은 일수로 사용가능한 날수 구하기
		  
		  
		  if(memVo !=null){
			  List<Map<String, Object>> myTicketList = ticketService.selectMyTicketDt(memVo.getMemId());
			  int totalPeriod=0;

				if(myTicketList.size()>0){
					for(int i = 0; i<myTicketList.size(); i++){
						 int PeriodUse = Integer.valueOf((String) myTicketList.get(i).get("PeriodUse"));
						 totalPeriod+=PeriodUse;
						 logger.debug("===totalPeriod={}",totalPeriod);
						logger.debug("===PeriodUse={}",PeriodUse);
					}
					
					String endDt = ticketService.selectEndDt(totalPeriod+"");
					logger.debug("====endDt{}==",endDt);
					int totalRef=0;
					List<TicketVo> ticketVo = ticketService.selectRefOkList(memVo.getMemId());
					if(ticketVo != null){
						for(int i=0; i<ticketVo.size(); i++){
						String period=ticketVo.get(i).getTicketPeriod();
						totalRef +=Integer.parseInt(period); 
						}
					}
					model.addAttribute("myTicketList",myTicketList);
					model.addAttribute("endDt", endDt);
					model.addAttribute("totalPeriod", totalPeriod-totalRef);
				}else{
					model.addAttribute("endDt", 0);
					model.addAttribute("totalPeriod", 0);
				}
		  }
		 return "myTicket";
	 }
	 
	 
	 @RequestMapping(path="/ticketBuyInfoAjax")
	 public String ticketBuyInfoAjax(Model model,String ticketBuyNo,HttpServletRequest req){
		 List<Map<String, Object>> ticketBuyInfo = ticketService.selectTicketBuyList(ticketBuyNo);
		 logger.debug("====ddd?{}",ticketBuyInfo.size());
		 model.addAttribute("ticketBuyInfo",ticketBuyInfo.get(0));
		 return "jsonView";
	 }
	 
	 @RequestMapping(path="/ticketRefInsert")
	 public String ticketBuyInfoAjax(TicketRefHistVo ticketRefHistVo,Model model,String ticketBuyNo,HttpServletRequest req){
		 ticketService.insertTicketRef(ticketRefHistVo);
		 return "redirect:" + req.getContextPath() +"/ticket/myTicket";
	 }
	 
	 
	
}