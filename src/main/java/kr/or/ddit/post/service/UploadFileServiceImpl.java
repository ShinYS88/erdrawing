package kr.or.ddit.post.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.ddit.post.dao.IUploadFileDao;
import kr.or.ddit.post.model.UploadFileVo;

@Service("uploadFileService")
public class UploadFileServiceImpl implements IUploadFileService {
	
	@Resource(name="uploadFileDao")
	private IUploadFileDao uploadFileDao;
	
	public UploadFileServiceImpl(){
		
	}

	@Override
	public List<UploadFileVo> getAllFile(String postNo) {
		return uploadFileDao.getAllFile(postNo);
	}

	@Override
	public UploadFileVo selectFile(String uploadFileNo) {
		return uploadFileDao.selectFile(uploadFileNo);
	}

	@Override
	public int insertFile(UploadFileVo uploadFileVo) {
		return uploadFileDao.insertFile(uploadFileVo);
	}

	@Override
	public int deleteFile(String uploadFileNo) {
		return uploadFileDao.deleteFile(uploadFileNo);
	}

}
