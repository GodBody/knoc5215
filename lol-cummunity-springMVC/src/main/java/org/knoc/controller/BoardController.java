package org.knoc.controller;

import javax.inject.Inject;

import org.knoc.domain.Board;
import org.knoc.domain.Criteria;
import org.knoc.domain.PageMaker;
import org.knoc.service.BoardService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	private static Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Inject
	private BoardService service;

	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void registerGET(Board board, Model model) throws Exception {
		logger.info("register GET");
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerPOST(Board board, RedirectAttributes rttr) throws Exception {
		
		logger.info("register POST");

		service.regist(board);

		rttr.addFlashAttribute("msg", "SUCCESS");

		return "redirect:/board/listAll";
	}

	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public void read(@RequestParam("bno") int bno, Model model) throws Exception {
		model.addAttribute(service.read(bno));
	}

	@RequestMapping(value = "/readPage", method = RequestMethod.GET)
	public void readPage(@RequestParam("bno") int bno, @ModelAttribute("cri") Criteria cri, Model model)
			throws Exception {
		model.addAttribute(service.read(bno));
	}

	@RequestMapping(value = "/remove", method = RequestMethod.POST)
	public String remove(@RequestParam("bno") int bno, RedirectAttributes rttr) throws Exception {
		service.remove(bno);
		rttr.addFlashAttribute("msg", "SUCCESS");

		return "redirect:/board/listAll";
	}

	@RequestMapping(value = "/removePage", method = RequestMethod.POST)
	public String remove(@RequestParam("bno") int bno, Criteria cri, RedirectAttributes rttr) throws Exception {
		service.remove(bno);

		rttr.addFlashAttribute("page", cri.getPage());
		rttr.addFlashAttribute("perPageNUm", cri.getPerPageNum());
		rttr.addFlashAttribute("msg", "SUCCESS");

		return "redirect:/board/listPage";
	}

	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public void modifyGET(int bno, Model model) throws Exception {
		model.addAttribute(service.read(bno));
	}

	@RequestMapping(value = "/modifyPage", method = RequestMethod.GET)
	public void modifyPagingGET(@RequestParam("bno") int bno, @ModelAttribute("cri") Criteria cri, Model model)
			throws Exception {

		model.addAttribute(service.read(bno));

	}

	@RequestMapping(value = "/modifyPage", method = RequestMethod.POST)
	public String modifyPagingPOST(Board board, Criteria cri, RedirectAttributes rttr) throws Exception {
		service.modify(board);

		rttr.addFlashAttribute("page", cri.getPage());
		rttr.addFlashAttribute("perPageNUm", cri.getPerPageNum());
		rttr.addFlashAttribute("msg", "SUCCESS");

		return "redirect:/board/listPage";
	}

	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modifyPOST(Board board, RedirectAttributes rttr) throws Exception {
		logger.info("modify POST");

		service.modify(board);
		rttr.addFlashAttribute("msg", "SUCCESS");

		return "redirect:/board/listAll";
	}

	@RequestMapping(value = "/listCri", method = RequestMethod.GET)
	public void listAll(Criteria cri, Model model) throws Exception {
		logger.info("listAll GET with Criteria");
		model.addAttribute("list", service.listCriteria(cri));
	}

	@RequestMapping(value = "/listPage", method = RequestMethod.GET)
	public void listPage(@ModelAttribute("cri") Criteria cri, Model model) throws Exception {
		logger.info(cri.toString());

		model.addAttribute("list", service.listCriteria(cri));
		PageMaker p = new PageMaker();
		p.setCri(cri);
		// p.setTotalCount(131);
		p.setTotalCount(service.listCountCriteria(cri));

		model.addAttribute("pageMaker", p);
	}
}
