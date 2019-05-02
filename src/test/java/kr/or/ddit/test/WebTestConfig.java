package kr.or.ddit.test;

import org.junit.Before;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "classpath:kr/or/ddit/config/spring/servlet-context.xml" ,
						"classpath:kr/or/ddit/config/spring/application-context.xml",
						 "classpath:kr/or/ddit/config/spring/context-datasource.xml",
						 "classpath:kr/or/ddit/config/spring/context-transaction.xml"})
@WebAppConfiguration 	
public class WebTestConfig {
	@Autowired	
	private WebApplicationContext context;	
	protected MockMvc mockMvc;
	

	@Before
	public void setup(){
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
}
