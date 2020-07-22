package yju.wdb.test;

import static org.junit.Assert.assertNotNull;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import yju.wdb.domain.BoardVO;
import yju.wdb.domain.Criteria;
import yju.wdb.service.BoardService;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BoardServiceTest {
	Logger log = Logger.getLogger(BoardServiceTest.class);
	@Autowired
	private BoardService service;
	
	//@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}

		
	//@Test
	public void testRegister() {
		BoardVO board = new BoardVO();
		board.setTitle("New article");
		board.setContent("New Content");
		board.setWriter("scpark");
		
		service.register(board);
		
		log.info("생성된 게시글의 번호: " + board.getBno());
		
	}
	
	//@Test
	/*
	public void testGetList() {
		//service.getList().forEach(board->log.info(board));
	}
	*/
	
	//@Test
	public void testGet() {
		log.info(service.get(4));
	}
	
	//@Test 
	public void testDelete() {
		service.remove(2);
	}
	
	//@Test
	public void testUpdate() {
		
		BoardVO board = service.get(1);
		
		if (board == null) {
			log.info("No such an article");
			return;
		}
		
		board.setTitle("Updated Title");
		service.modify(board);
	}
	
	@Test
	public void testGetList() {
		service.getList(new Criteria(2, 10)).forEach(board->log.info(board.toString()));
	}
	
}
