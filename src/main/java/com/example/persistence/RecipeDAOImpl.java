package com.example.persistence;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.Criteria;
import com.example.domain.RecipeVO;
import com.example.domain.Recipe_attachVO;
import com.example.domain.User_keepVO;

@Repository
public class RecipeDAOImpl implements RecipeDAO{
	String namespace="com.example.mapper.RecipeMapper";
	
	@Autowired
	SqlSession session;

	@Override
	public List<RecipeVO> list(Criteria cri) throws Exception {		
		return session.selectList(namespace + ".list", cri);
	}

	@Override
	public int totalCount(Criteria cri) throws Exception {		
		return session.selectOne(namespace + ".totalCount", cri);
	}

	@Override
	public RecipeVO read(int recipe_bno) throws Exception {		
		return session.selectOne(namespace + ".read", recipe_bno);
	}

	@Override
	public void insert(RecipeVO vo) throws Exception {
		session.insert(namespace + ".insert", vo);		
	}

	@Override
	public void update(RecipeVO vo) throws Exception {
		session.update(namespace + ".update", vo);		
	}

	@Override
	public void delete(int recipe_bno) throws Exception {
		session.delete(namespace + ".delete", recipe_bno);		
	}

	@Override
	public List<Recipe_attachVO> getAttach(int recipe_bno) throws Exception {		
		return session.selectList(namespace + ".getAttach", recipe_bno);
	}

	@Override
	public void updateViewcnt(int recipe_bno) throws Exception {
		session.update(namespace + ".updateViewcnt", recipe_bno);
		
	}	

	@Override
	public int lastBno() throws Exception {
		return session.selectOne(namespace + ".lastBno");
	}

	@Override
	public void updateReply(int recipe_bno, int recipe_rno) throws Exception {
		session.update(namespace + ".updateReply", recipe_rno);
		
	}

	@Override
	public void delAttach(int recipe_bno) throws Exception {
		session.delete(namespace + ".delAttach", recipe_bno);		
	}

	@Override
	public void updateUserRating(int recipe_bno) throws Exception {		
		session.update(namespace + ".updateUserRating", recipe_bno);
	}

	@Override
	public void delAttach2(int recipe_bno, int recipe_attach_no) throws Exception {
		HashMap<String,Object> map = new HashMap<>();
		map.put("recipe_attach_no", recipe_attach_no);
		map.put("recipe_bno", recipe_bno);
		session.delete(namespace + ".delAttach2", map);
	}

	@Override
	public void addAttach(Recipe_attachVO attachVO) throws Exception {
		session.update(namespace + ".addAttach", attachVO);		
	}

	@Override
	public int lastAttachNo(int reipce_bno) throws Exception {	
		return session.selectOne(namespace + ".lastAttachNo", reipce_bno);
	}

	@Override
	public User_keepVO keepRead(int recipe_bno, String user_id) throws Exception {
		HashMap<String,Object> map = new HashMap<>();
		map.put("user_id", user_id);
		map.put("recipe_bno", recipe_bno);
		return session.selectOne(namespace + ".keepRead", map);
	}

	@Override
	public void keepInsert(User_keepVO vo) throws Exception {
		session.insert(namespace + ".keepInsert", vo);
	}

	@Override
	public void keepUpdate(User_keepVO vo) throws Exception {
		session.update(namespace + ".keepUpdate", vo);
	}

	@Override
	public List<RecipeVO> klist(int pageStart, int perPageNum, String user_id) throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		map.put("pageStart", pageStart);
		map.put("perPageNum", perPageNum);
		map.put("user_id", user_id);		
		return session.selectList(namespace + ".klist", map);
	}

	@Override
	public String nextNum(int recipe_bno) throws Exception {
		return session.selectOne(namespace + ".nextNum", recipe_bno);
	}

	@Override
	public String preNum(int recipe_bno) throws Exception {
		return session.selectOne(namespace + ".preNum", recipe_bno);
	}

	@Override
	public String maxNum() throws Exception {
		return session.selectOne(namespace + ".maxNum");
	}

	@Override
	public String minNum() throws Exception {
		return session.selectOne(namespace + ".minNum");
	}
}
