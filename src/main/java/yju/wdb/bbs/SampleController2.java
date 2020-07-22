package yju.wdb.bbs;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.slf4j.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import yju.wdb.test.SampleVO;
import yju.wdb.test.Ticket;

@RestController
@RequestMapping("/sample2/*")
public class SampleController2 {
	Logger log = LoggerFactory.getLogger(SampleController2.class);
	
	@GetMapping(value="/getText", produces = "text/plain; charset=UTF-8")
	public String getText() {
		log.info("MIME TYPE: " + MediaType.TEXT_PLAIN_VALUE);
		return "안녕하세요";
	}
	
	@GetMapping(value="/getSample")
	public SampleVO getSample() {
		SampleVO v = new SampleVO(112, "스타", "로드");
		log.info(v.getFirstName()+ ", " + v.getLastName() + ", " + v.getMno());
		return v;
	}
 
	@GetMapping(value="getList")
	public List<SampleVO> getList() {	
		//return IntStream.range(1, 10).mapToObj(i->new SampleVO(i, i+"First", i+"Last")).collect(Collectors.toList());
		List<SampleVO> list = new ArrayList<>();
		for (int i = 0; i < 10; i++)
			list.add(new SampleVO(i, i+"First", i+"Last"));
		
		return list;
	}
	
	@GetMapping(value="getMap")
	public Map<String, SampleVO> getMap() {
		Map<String, SampleVO> map = new HashMap<>();
		map.put("first",  new SampleVO(111, "그루투", "주니어"));
		
		return map;
	}

	@GetMapping(value="/check", params = {"height", "weight"})
	public ResponseEntity<SampleVO> check(double height, double weight) {
		SampleVO vo = new SampleVO(0, ""+height, ""+weight);
		
		ResponseEntity<SampleVO> result = null;
		
		if (height < 150) {
			result = ResponseEntity .status(HttpStatus.BAD_REQUEST).body(vo);
		} else {
			result = ResponseEntity.status(HttpStatus.OK).body(vo);
		}
		
		return result;
	}
	
	@GetMapping("/product/{cat}/{pid}")
	public String[] getPath(@PathVariable("cat") String cat, @PathVariable("pid") int pid) {
		return new String[] {"category: " + cat, "product id : " + pid};
	}
	
	@PostMapping("/ticket")
	public Ticket convert(@RequestBody Ticket ticket) {
		log.info("convert.........ticket" + ticket);
		
		return ticket;
	}
	
	
}
