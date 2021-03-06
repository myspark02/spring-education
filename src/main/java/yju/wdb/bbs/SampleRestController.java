package yju.wdb.bbs;

import java.util.*;
import java.util.stream.*;

import org.slf4j.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import yju.wdb.domain.SampleVO;
import yju.wdb.domain.Ticket;


@RestController
@RequestMapping("/rest")
public class SampleRestController {
	Logger log = LoggerFactory.getLogger(SampleRestController.class);
	
	@GetMapping(value="/getText", produces="text/plain; charset=UTF-8")
	public String getText() {
		log.info("MIME TYPE: " + MediaType.TEXT_PLAIN_VALUE);
		
		return "안녕하세요?";
	}

	@GetMapping(value="/getSample", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
	public SampleVO getSample() {
		
		return new SampleVO(112, "스타", "로드");
	}
	
	@GetMapping(value="/getList")
	public List<SampleVO> getList() {
		//return IntStream.range(1, 10).mapToObj(i-> new SampleVO(i, i+"First", i+"Last")).collect(Collectors.toList());
		List<SampleVO> list = new ArrayList<>();
		for (int i = 0; i < 10; i++) {
			list.add(new SampleVO(i, i+"First", i+"Last"));
		}
		return list;	
	}
	
	@GetMapping(value="/check", params= {"height", "weight"})
	public ResponseEntity<SampleVO> check(int height, int weight) {
		SampleVO vo = new SampleVO(0, ""+height, ""+weight);
		
		ResponseEntity<SampleVO> result = null;
		
		if (height < 150) {
			result = ResponseEntity.status(HttpStatus.BAD_REQUEST).body(vo);
		} else {
			result = ResponseEntity.status(HttpStatus.OK).body(vo);
		}
		
		return result;
	}
	
	@GetMapping("/product/{cat}/{pid}")
	public String[] getPath(@PathVariable("cat") String cat, @PathVariable("pid") int pid) {
		return new String[] {"category: " + cat, "product id: " + pid};
		
	}
	
	@PostMapping("/ticket")
	public Ticket convert(@RequestBody Ticket ticket) {
		log.info("convert...........ticket: " + ticket);
		return ticket;
	}
}
