package yju.wdb.bbs;

import java.io.File;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import yju.wdb.domain.BoardVO;
import yju.wdb.domain.Criteria;
import yju.wdb.service.BoardService;
import yju.wdb.test.PageDTO;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/bbs/*")
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private BoardService service;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	/*
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	*/
	
	@GetMapping("/list")
	public void list(Criteria crt,  Model model) {
		logger.info("bbs list");
	//	model.addAttribute("list", service.getList());	
		model.addAttribute("list", service.getList(crt));
		model.addAttribute("pageMaker", new PageDTO(crt, 123));
	}
	
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		logger.info("register: " + board);
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());
		
		return "redirect:/bbs/list";
	}
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("bno") int bno, @ModelAttribute("crt") Criteria crt, Model model) {
		logger.info("/get");
		
		model.addAttribute("board", service.get(bno));
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("crt") Criteria crt, RedirectAttributes rttr) {
		logger.info("modify:" + board);
		
		service.modify(board);
		rttr.addFlashAttribute("result", "success");
		
		/*
		rttr.addAttribute("pageNum", crt.getPageNum());
		rttr.addAttribute("amount", crt.getAmount());
		rttr.addAttribute("type", crt.getType());
		rttr.addAttribute("keyword", crt.getKeyword());		
		*/
		return "redirect:/bbs/list" + crt.getListLink();
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") int bno, @ModelAttribute("crt") Criteria crt, RedirectAttributes rttr) {
		logger.info("remove..."+bno);
		
		service.remove(bno);
		
		rttr.addFlashAttribute("result", "success");
		
		/*
		rttr.addAttribute("pageNum", crt.getPageNum());
		rttr.addAttribute("amount", crt.getAmount());
		rttr.addAttribute("type", crt.getType());
		rttr.addAttribute("keyword", crt.getKeyword());		
		*/
		
		return "redirect:/bbs/list" + crt.getListLink();
		
	}
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	
	@GetMapping("/uploadForm")
	public void uploadForm() {
		logger.info("upload form");
	}
	
	
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFiles, Model model) {
		logger.info("upload form Action");
		logger.info("uploadFiles.length:" +uploadFiles.length);
		String uploadFolder = "E:\\Documents\\scpark\\SW\\sts-4.5.1.RELEASE\\workspace\\files";
		
		for (MultipartFile multipartFile : uploadFiles) {
			logger.info("-----------------------------------------");
			logger.info("Upload File Name: " + multipartFile.getOriginalFilename());
			logger.info("Upload File Size: " + multipartFile.getSize());
			
			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
			
			try {
				multipartFile.transferTo(saveFile);
			}catch(Exception e) {
				logger.error(e.getMessage());
			}
			
		}
	}
	
	
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		logger.info("upload ajax");
	}
	
	
	@PostMapping("/uploadAjaxAction")
	public void uploadAjaxPost(MultipartFile[] uploadFiles) {
		logger.info("upload ajax post ...........");
		logger.info("uploadFiles.length:" +uploadFiles.length);
		String uploadFolder =  "E:\\Documents\\scpark\\SW\\sts-4.5.1.RELEASE\\workspace\\files";
		
		for (MultipartFile multipartFile : uploadFiles) {
			logger.info("-----------------------------------------");
			logger.info("Upload File Name: " + multipartFile.getOriginalFilename());
			logger.info("Upload File Size: " + multipartFile.getSize());
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			//IE has file path
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			
			logger.info("file name(file path excluded): " + uploadFileName);
			
			File saveFile = new File(uploadFolder, uploadFileName);
			
			try {
				multipartFile.transferTo(saveFile);
			}catch(Exception e) {
				logger.error(e.getMessage());
			}		
		}
	}
	
	
	
}
