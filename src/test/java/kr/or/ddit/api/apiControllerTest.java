package kr.or.ddit.api;

import static org.junit.Assert.*;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ibm.watson.developer_cloud.assistant.v1.Assistant;
import com.ibm.watson.developer_cloud.assistant.v1.model.InputData;
import com.ibm.watson.developer_cloud.assistant.v1.model.MessageOptions;
import com.ibm.watson.developer_cloud.assistant.v1.model.MessageResponse;
import com.ibm.watson.developer_cloud.service.security.IamOptions;

public class apiControllerTest {

	private Logger logger = LoggerFactory.getLogger(apiControllerTest.class);
	@Test
	public void test() {
		IamOptions iamOptions = new IamOptions.Builder().apiKey("Rvy0XPi7YkMsaVk2MkZU5iVeSBv67fFl0EKlonub6hZL").build();
		Assistant service = new Assistant("2019-02-28", iamOptions);
		service.setEndPoint("https://gateway-tok.watsonplatform.net/assistant/api");

		String workspaceId = "2721d597-8f79-42f2-bc70-1fd348f64602";
		InputData input = new InputData.Builder("sdfsdfsdf").build();

		MessageOptions options = new MessageOptions.Builder(workspaceId)
		  .input(input)
		  .build();

		MessageResponse response = service.message(options).execute();
		logger.debug("====son{}",response);

//		System.out.println("111==========================22222222222==========");
		
		System.out.print(response.getOutput());
//		System.out.println("=======================4444=============");
		String temp = response.getOutput()+"";
		System.out.println("temp"+temp);
		String[] resarray = temp.split("\\[");
		System.out.println("=====resarray[0]==============================");
		System.out.println();
		String[] resarray2 = resarray[2].split("\\],");
		
		//System.out.println("====================================");
		System.out.println(resarray2[0]);System.out.println("====================================");
		//System.out.println("====================================");
		String[] resarray3 = resarray2[0].split("\"");System.out.println("====================================");
		
		System.out.println(resarray3[1]);
	}

}
