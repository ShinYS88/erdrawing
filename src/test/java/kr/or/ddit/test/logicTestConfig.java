package kr.or.ddit.test;

import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration( {"classpath:kr/or/ddit/config/spring/application-context.xml",
						"classpath:kr/or/ddit/config/spring/context-datasource.xml",
						"classpath:kr/or/ddit/config/spring/context-transaction.xml"})
public class logicTestConfig {
	
}
