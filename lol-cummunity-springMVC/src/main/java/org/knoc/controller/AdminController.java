package org.knoc.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Stack;

import javax.inject.Inject;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.knoc.domain.PageMaker;
import org.knoc.domain.SearchCriteria;
import org.knoc.domain.UpdateVO;
import org.knoc.service.AdminService;
import org.knoc.service.BoardService;
import org.knoc.service.UpdateService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/*")
public class AdminController {
	private static Logger logger = LoggerFactory.getLogger(AdminController.class);

	@Inject
	private UpdateService updateService;

	@Inject
	private BoardService boardService;

	@Inject
	AdminService adminService;

	@Secured("ROLE_ADMIN")
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index() {

		logger.info("ADMIN Index.jsp");

		return "/admin/index";
	}

	@RequestMapping(value = "/noticeList", method = RequestMethod.GET)
	public void listUpdate(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		// logger.info(cri.toString());

		String src = "http://www.leagueoflegends.co.kr/?m=news&cate=update";

		Document doc = Jsoup.connect(src).get();

		Elements tbody_a = doc.select("tbody a");

		Stack<Map<Integer, UpdateVO>> stack = new Stack<>();

		Integer index = 0;

		for (Element element : tbody_a) {

			String title = element.getAllElements().text();
			String link = element.attr("href");

			Map<Integer, UpdateVO> map = new HashMap<>();
			UpdateVO vo = new UpdateVO();
			vo.setTitle(title);
			vo.setContent(link);

			map.put(index++, vo);
			stack.push(map);
		}

		// vo.setContent(src+link);
		int key_index = stack.size() - 1;
		while (!stack.isEmpty()) {
			Map<Integer, UpdateVO> map = new HashMap<>();
			map = stack.pop();
			updateService.regist(map.get(key_index));
			key_index--;
		}

		// model.addAttribute("list", updateService.list());
		model.addAttribute("list", updateService.listSearchCriteria(cri));

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(updateService.listSearchCount(cri));

		model.addAttribute("pageMaker", pageMaker);
	}

	@RequestMapping(value = "/boardList", method = RequestMethod.GET)
	public void listPage(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		logger.info(cri.toString());

		// model.addAttribute("list", service.listCriteria(cri));
		model.addAttribute("list", boardService.listSearchCriteria(cri));
		PageMaker p = new PageMaker();
		p.setCri(cri);
		// p.setTotalCount(service.listCountCriteria(cri));
		p.setTotalCount(boardService.listSearchCount(cri));

		model.addAttribute("pageMaker", p);
	}

	@RequestMapping(value = "/boardRead", method = RequestMethod.GET)
	public void read(@RequestParam("bno") int bno, @ModelAttribute("cri") SearchCriteria cri, Model model)
			throws Exception {

		model.addAttribute(boardService.read(bno));
	}

	@RequestMapping(value = "/boardRemove", method = RequestMethod.POST)
	public String remove(@RequestParam("bno") int bno, SearchCriteria cri, RedirectAttributes rttr) throws Exception {

		boardService.remove(bno);
		System.out.println(cri.toString());

		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());

		rttr.addFlashAttribute("msg", "SUCCESS");

		boardService.remove(bno);

		return "redirect:/admin/boardList";

	}

	@RequestMapping(value = "/account", method = RequestMethod.GET)
	public void accountGET(Model model) {
		logger.info((adminService.listAccount()).toString());
		model.addAttribute("accountlist", adminService.listAccount());
		model.addAttribute("board", adminService.listBoardCount());
		model.addAttribute("update", adminService.listUpdateCount());
		model.addAttribute("message", adminService.listMessageCount());
	}

}
