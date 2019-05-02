package kr.or.ddit.post.dao;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.ddit.post.model.BoardVo;

@Repository("boardDao")
public class BoardDaoImpl implements IBoardDao {

	@Resource(name = "sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List<BoardVo> getAllBoard() {
		List<BoardVo> boardList = sqlSessionTemplate.selectList("post.getAllBoard");
		
		return boardList;
	}

	@Override
	public BoardVo getSelectBoard(String boardNo) {
		BoardVo boardVo = sqlSessionTemplate.selectOne("post.getSelectBoard", boardNo);
			
		return boardVo;
	}

}
