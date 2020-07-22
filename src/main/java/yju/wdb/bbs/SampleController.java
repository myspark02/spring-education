package yju.wdb.bbs;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.*;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import yju.wdb.domain.SampleDTO;
import yju.wdb.domain.SampleDTOList;
import yju.wdb.domain.TodoDTO;

@Controller
@RequestMapping("/sample/*")
public class SampleController {
	
	
	@RequestMapping("")
	public void basic() {
		System.out.println("basic ............................");
	}

	@RequestMapping(value="basic", method= {RequestMethod.GET, RequestMethod.POST})
	public void basicGet() {
		System.out.println("basicGet......");
	}
	/*
	@RequestMapping(value="basic", method=RequestMethod.POST)
	public String basicGet2() {
		System.out.println("basicGet2......");
		return "sample/basic2";
	}
	*/
	@RequestMapping("test")
	public String test() {
		return "sample/mytest";
	}
	
	
	@RequestMapping("dto")
	public void dto(SampleDTO dto) {
		System.out.println(dto);
	}
	
	@RequestMapping("param")
	public void param(@RequestParam("name") String myName, int age) {
		System.out.println("name: "+myName + ", age: "+age);
	}
	
	@RequestMapping("list")
	public String list(@RequestParam("ids") ArrayList<String> ids) {
		System.out.println(ids);
		
		return "sample/exList";
	}
	
	@RequestMapping("array") 
	public String myArray(@RequestParam("ids") String[] ids) {
		System.out.println(Arrays.toString(ids));
		
		return "sample/myArray";
	}
	
	@RequestMapping("objList")
	public String objList(SampleDTOList list) {
		System.out.println(list);
		
		return "sample/objects";
	}
	
	@RequestMapping("binder")
	public void myBinder(TodoDTO todo) {
		System.out.println(todo);
	}
	
	/*
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(java.util.Date.class, new CustomDateEditor(dateFormat, false));
	}
	*/
	
	@RequestMapping("model")
	public String testModelAttr(SampleDTO dto, @ModelAttribute("page") int page, Model model) {
		System.out.println(dto);
		System.out.println("page:"+page);
		model.addAttribute("myValue", "Hi~ My name is scpark");
		
		return "sample/modelAttr";
	}
	
	@RequestMapping("redirect")
	public String testRedirect(RedirectAttributes rttr) {
		rttr.addAttribute("name", "Neo Lion");
		rttr.addAttribute("age", "18");
		rttr.addAttribute("page", "100");
		return "redirect: /sample/model";
	}
	
	@GetMapping("json")
	public @ResponseBody SampleDTO testJson() {
		SampleDTO dto = new SampleDTO();
		dto.setName("Lee MoungRyoung");
		dto.setAge(18);
		
		return dto;
	}
	
	@GetMapping("resEntity")
	public ResponseEntity<String> testEntity() {
		
		String msg = "{'name':'È«±æµ¿', 'age':18, 'gender':'³²'}";
		
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "application/json;charset=UTF-8");
		return new ResponseEntity<>(msg, header, HttpStatus.OK);
		
	}
	
	
}
