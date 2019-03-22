package kr.or.conn.spring.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.conn.spring.dto.DisplayInfoDTO;
import kr.or.conn.spring.dto.ProductDTO;
import kr.or.conn.spring.service.MainService;

@Controller
@RequestMapping("/main")
public class MainController {
	
	@Autowired 
	MainService mainService;
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	@RequestMapping("/home")
	public String mainhome(Locale locale, Model model) throws Exception{
		
		return "main/mainPage";
	}
	
	@RequestMapping("/mainList")
	@ResponseBody
	public HashMap<String, Object> mainList(HttpSession session, @RequestBody HashMap<String, Object> param, Model model, HttpServletRequest request, ProductDTO prddto) {    	

		 prddto.setStart((int)param.get("start"));
		 prddto.setLimit((int)param.get("limit"));
		 
		 int mainListCount = 0;
		 
		 prddto.setCategory_id((int)param.get("category_id"));
		 
		 List<HashMap<String, Object>> mainList = mainService.mainList(prddto);
		 mainListCount = mainService.mainListCount(prddto);
	    
		 HashMap<String, Object> map = new HashMap<String, Object>();
		 map.put("mainList", mainList);
		 map.put("mainCount", mainListCount);
		 
//		 System.out.println("param");
//		 System.out.println(param.get("promo_id"));
		 if (param.get("promo_id").equals("0")) {
//			 System.out.println("타나");
			 List<HashMap<String, Object>> promoList = mainService.promoList();
			 map.put("promoList", promoList);
		 }
		 
	    return map;
	 }
	
	@RequestMapping("/detail")
	public String maindetail(Locale locale, Model model) throws Exception{
		
		return "main/detail";
	}

	@RequestMapping("/detailEntry")
	@ResponseBody
	public HashMap<String, Object> detailEntry(HttpSession session, @RequestBody HashMap<String, Object> param, Model model, HttpServletRequest request) throws Exception{
		
		
		request.getParameter("id");
		System.out.println("request.getParameter");
		System.out.println(request.getParameter("id"));
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<HashMap<String, Object>> ComentList = mainService.DetailComentList(param);
		int ComentListCount = mainService.DetailComentListCount(param);
		float ComentScore = mainService.DetailComentScore(param);
		System.out.println("ComentScore");
		System.out.println(ComentScore);
		
		if (param.get("flag").equals("0")) {
			HashMap<String, Object> detailEntry = mainService.detailEntry(param);
			HashMap<String, Object> DetailEtcImage = mainService.DetailEtcImage(param);
			map.put("data", detailEntry);
			map.put("etcImage", DetailEtcImage);
		}
		
		map.put("ComentCount", ComentListCount);
		map.put("ComentList", ComentList);
		map.put("ComentScore", ComentScore);
		return map;
	}
	@RequestMapping("/DetailComentList")
	@ResponseBody
	public HashMap<String, Object> DetailComentList(HttpSession session, @RequestBody HashMap<String, Object> param, Model model, HttpServletRequest request) throws Exception{
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<HashMap<String, Object>> ComentList = mainService.DetailComentList(param);
		
		map.put("ComentList", ComentList);
		return map;
	}
	
	@RequestMapping("/reserve")
	public String reserve(HttpSession session, ModelMap modelMap, HashMap<String, Object> param,HttpServletRequest request,ProductDTO prddto) throws Exception{
		
		
		System.out.println();
	 	int id= Integer.parseInt(request.getParameter("id"));
	 	prddto.setCategory_id(id); 
	 	param.put("id", id);
	 	HashMap<String, Object> detailEntry = mainService.detailEntry(param);
		
	 	modelMap.addAttribute("reserveDetail",detailEntry);
		
		return "main/reserve";
	}
	
	@RequestMapping("/detailprice")
	@ResponseBody
	public HashMap<String, Object> detailreserve(HttpSession session, @RequestBody HashMap<String, Object> param, Model model, HttpServletRequest request) throws Exception{
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<HashMap<String, Object>> DetailPrice = mainService.DetailPrice(param);
		
		map.put("DetailPrice", DetailPrice);
		return map;
	}
	
	@RequestMapping("/bookinglogin")
	public String bookinglogin(HttpSession session, ModelMap modelMap, HashMap<String, Object> param,HttpServletRequest request,ProductDTO prddto) throws Exception{
		
		
//		System.out.println();
//	 	int id= Integer.parseInt(request.getParameter("id"));
//	 	prddto.setCategory_id(id); 
//	 	param.put("id", id);
//	 	HashMap<String, Object> detailEntry = mainService.detailEntry(param);
//		
//	 	modelMap.addAttribute("reserveDetail",detailEntry);
		
		return "main/bookinglogin";
	}
	
	@RequestMapping("/myreservation")
	public String myreservation(HttpSession session, ModelMap modelMap, HashMap<String, Object> param,HttpServletRequest request,ProductDTO prddto) throws Exception{
		
		
//		System.out.println();
//	 	int id= Integer.parseInt(request.getParameter("id"));
//	 	prddto.setCategory_id(id); 
//	 	param.put("id", id);
//	 	HashMap<String, Object> detailEntry = mainService.detailEntry(param);
//		
//	 	modelMap.addAttribute("reserveDetail",detailEntry);
		
		return "main/myreservation";
	}
//	@RequestMapping(value = "/board/boardListf.do", method = RequestMethod.GET)
//	public String boardListfirst(Locale locale, Model model) throws Exception{
//		
//		return "board/boardList";
//	}
	
//	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.POST)
//	@ResponseBody
////	public HashMap<String, Object> boardList(Locale locale, Model model, @RequestBody HashMap<String, Object> param) throws Exception{
////	파라미터를 파람으로 싹다 받아서 넘기고 싶은데 Content type 'application/x-www-form-urlencoded;charset=UTF-8' not supported 오류....
////	public HashMap<String, Object> boardList(Locale locale, Model model, HashMap<String, Object> param,
////			@RequestParam("cpage")int cPage,
////			@RequestParam("searchKey")String searchKey,
////			@RequestParam("searchWord")String searchWord) throws Exception{
//	public HashMap<String, Object> boardList(Locale locale, Model model, @RequestBody HashMap<String, Object> param
//			) throws Exception{
//		int cPage =(Integer) param.get("cpage");
//		int pageBlock = 10;
//		int startRow  = (cPage - 1) * pageBlock + 1;
//		int endRow    = startRow  + pageBlock - 1;
//		
////		param.put("searchKey", searchKey);
////		param.put("searchWord", "%" +searchWord+ "%");
//		param.put("startRow", startRow);
//		param.put("endRow", endRow);
//		
//		List<HashMap<String, Object>> list	= boardService.BoardList(param);
//		int totalRows		= boardService.getTotalRows(param);
//		
////		System.out.println("totalRows:"+totalRows);
//		
//		
//		HashMap<String, Object> map = new HashMap<String, Object>();
//		map.put("list", list);
//		map.put("totalRows", totalRows);
////		System.out.println("cpage:"+cPage);
//		map.put("cPage", cPage);
//		
//
//		return map;
//	}
	
//	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
//	public String boardWrite(Locale locale, Model model) throws Exception{
//		
//		return "board/boardWrite";
//	}
//	
//	@RequestMapping(value = "/board/boardWriteAc.do", method = RequestMethod.POST)
//	@ResponseBody
//	public Map<String, String> boardWriteAc(Locale locale, productDTO BoardVo) throws Exception{
//		
//		int flag =  boardService.boardWriteAc(BoardVo);
//		
//		Map<String, String> map = new HashMap<String, String>();
//		
//		map.put("success", (flag > 0)?"Y":"N");
//		
//		return map;
//	}
//	
//	@RequestMapping(value = "/board/boardRead.do", method = RequestMethod.GET)
//	public String boardRead(Locale locale, Model model
//			,@RequestParam("seq")int seq) throws Exception{
//		
//		productDTO list = boardService.BoardRead(seq);
//		
//		model.addAttribute("list", list);
//		
//		return "board/boardRead";
//	}
	
}
