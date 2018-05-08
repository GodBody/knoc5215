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
import org.knoc.service.UpdateService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/uboard/*")
public class UpdateController {

	private static Logger logger = LoggerFactory.getLogger(UpdateController.class);

	@Inject
	private UpdateService updateService;

	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public void update() throws Exception {

		logger.info("into update GET");

		String src = "http://www.leagueoflegends.co.kr/?m=news&cate=update";

		Document doc = Jsoup.connect(src).get();

		Elements tbody_a = doc.select("tbody a");

		Stack<Map<Integer, UpdateVO>> stack = new Stack<>();

		Integer index = 0;

		Map<Integer, UpdateVO> map = new HashMap<>();

		for (Element element : tbody_a) {

			String title = element.getAllElements().text();
			String link = element.attr("href");

			// Map<Integer, UpdateVO> map = new HashMap<>();
			UpdateVO vo = new UpdateVO();
			vo.setTitle(title);
			vo.setContent(link);

			map.put(index++, vo);
			stack.push(map);
		}
		int key_index = map.size() - 1;
		// int key_index = stack.size() - 1;
		// while (!stack.isEmpty()) {
		while (!map.isEmpty()) {
			// Map<Integer, UpdateVO> map = new HashMap<>();
			// map = stack.pop();
			updateService.regist(map.get(key_index));
			key_index--;
		}
	}

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public void listUpdate(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {

		model.addAttribute("list", updateService.listSearchCriteria(cri));

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(updateService.listSearchCount(cri));

		model.addAttribute("pageMaker", pageMaker);
	}

	@RequestMapping(value = "/readPage", method = RequestMethod.GET)
	public void read(@RequestParam("bno") int bno, Model model) throws Exception {
		model.addAttribute(updateService.read(bno));
	}
}
