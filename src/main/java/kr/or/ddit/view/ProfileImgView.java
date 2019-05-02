package kr.or.ddit.view;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.View;

public class ProfileImgView implements View{

	@Override
	public String getContentType() {
		// TODO Auto-generated method stub
		return "image";
	}

	
	//개발자는 이미지 경로를 model객체에 "path"라는 속성으로 설정한다

	//개발자는 사용자 아이디를 model객체에 userId라는 속성으로 설정한다
	@Override
	public void render(Map<String, ?> model, HttpServletRequest req, HttpServletResponse resp)
			throws Exception {
	
	
		
	}
	

	
	
}
