package kr.or.ddit.post.dao;

import java.util.List;

import kr.or.ddit.post.model.UploadFileVo;

public interface IUploadFileDao {

	List<UploadFileVo> getAllFile(String postNo);
	
	UploadFileVo selectFile(String uploadFileNo);
	
	int insertFile(UploadFileVo uploadFileVo);

	/* int insertUploadFileUpd(UploadFileVo uploadfileVo); //확인필요? */

	int deleteFile(String uploadFileNo);

}
