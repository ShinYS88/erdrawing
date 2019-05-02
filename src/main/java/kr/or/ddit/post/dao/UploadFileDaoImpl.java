package kr.or.ddit.post.dao;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.ddit.post.model.UploadFileVo;

@Repository("uploadFileDao")
public class UploadFileDaoImpl implements IUploadFileDao {
	
	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List<UploadFileVo> getAllFile(String postNo) {
		return sqlSessionTemplate.selectList("post.getAllFile", postNo);
	}

	@Override
	public UploadFileVo selectFile(String uploadFileNo) {
		return sqlSessionTemplate.selectOne("post.selectFile", uploadFileNo);
	}

	@Override
	public int insertFile(UploadFileVo uploadFileVo) {
		return sqlSessionTemplate.insert("post.insertFile", uploadFileVo);
	}

	@Override
	public int deleteFile(String uploadFileNo) {
		return sqlSessionTemplate.delete("post.deleteFile", uploadFileNo);
	}

}
