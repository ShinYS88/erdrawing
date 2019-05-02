<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<input type="button" value="fff"  id="btn">
</body>

<script type="text/javascript">
$("#btn").click(function() {
	 URL = 'https://kapi.kakao.com/payment/ready'
		
				Kakao.init('KakaoAK 290b4c9ee60f5922e4cbfce140f0946d');
			     Kakao.API.request({
			          url: '/v1/web/ready',
			       data:{cid:"TC0ONETIME",
			    	   partner_order_id : "partner_order_id",
			    	   partner_user_id : "partner_user_id",
			    	   item_name : "test!!",
			    	   quantity: 1,
			    	   total_amount:1000,
			    	   approval_url:"http://localhost/good",
			    	   fail_url:"https://localhost/fail",
			    	   vat_amount:300,
			    	   tax_free_amount:0,
			    	   cancel_url:"https://localhost/cancel",
			       
			       },
			       
			          success: function(res) {
				            alert("성공");
				          },
			          fail: function(error) {
			            alert("실패");
		          }
			        });
			});
</script>
</html>