package kr.or.conn.spring.dao;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.conn.spring.dto.DisplayInfoDTO;
import kr.or.conn.spring.dto.ProductDTO;

@Repository
public class MainDao {
	
	@Autowired
	SqlSession sqlSession;
	
//	public List<HashMap<String, Object>> BoardList(HashMap<String, Object> param) {
////		int pageBlock = 10;
////		int startRow  = (searchVo.getCpage() - 1) * pageBlock + 1;
////		int endRow    = startRow  + pageBlock - 1;
////		
////        HashMap <String,Object> map = new HashMap<String, Object>();
////        System.out.println("111111111111111110"+searchVo.getSearchWord());
////        System.out.println("1111111111111123233"+searchVo.getSearchKey());
////        map.put("searchWord", 			searchVo.getSearchWord());
////		map.put("searchKey" ,              searchVo.getSearchKey());
////        map.put("startRow"  ,               startRow);
////		map.put("endRow"    ,                 endRow);
////		
//		return sqlSession.selectList("board.boardList", param);
//	}
//
//	public int getTotalRows(HashMap<String, Object> param) {
//		
////		HashMap <String,Object> map1 = new HashMap<String, Object>();
////        map1.put("searchWord", param.getSearchWord());
////		map1.put("searchKey" ,              param.getSearchKey());
//        
//		return sqlSession.selectOne("board.getTotalRows", param);
//	}
//
//	public int BoardWrite(ProductDTO boardVo) {
//		return sqlSession.insert("board.boardWrite", boardVo);
//	}
//
//	public ProductDTO BoardRead(int seq) {
////		
////		 HashMap <Object,Object> map = new HashMap<Object, Object>();
////	     map.put("SEQ", seq);
//			
//		return  sqlSession.selectOne("board.boardRead", seq);
//	}

	public List<HashMap<String, Object>> MainList(ProductDTO prddto) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("main.MainList",prddto);
	}
	
	public List<HashMap<String, Object>> PromoList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("main.PromoList");
	}

	public int MainListCount(ProductDTO prddto) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("main.MainListCount",prddto);
	}

	public HashMap<String, Object> DetailEntry(HashMap<String, Object> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("main.DetailEntry",param);
	}

	public List<HashMap<String, Object>> DetailComentList(HashMap<String, Object> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("main.DetailComentList",param);
	}

	public int DetailComentListCount(HashMap<String, Object> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("main.DetailComentListCount",param);
	}

	public float DetailComentScore(HashMap<String, Object> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("main.DetailComentScore",param);
	}

	public HashMap<String, Object> DetailEtcImage(HashMap<String, Object> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("main.DetailEtcImage",param);
	}
	
//
//	public int Signchk(String userId, String userPw) throws ClassNotFoundException {
//		
//		Object[] sqlParameter = new Object[] {userId};
//		
//		String chkSql = "SELECT COUNT(*) FROM CM_USER WHERE USER_ID = ?";
//		int flag = 0;
//	
//		if(userPw != null){
//			sqlParameter = new Object[] {userId,userPw};
//			chkSql += (" AND USER_PW = ?");
//		}
//		
//			flag = jdbcTemplate.queryForObject(chkSql, sqlParameter, Integer.class);
//			System.out.println("chk success");
//	
//		return flag;
//	}
//	
//
//	public UserVO SignIn(String userId, String userPw) {
//
//		String CheckSql = "SELECT * FROM CM_USER WHERE USER_ID=? AND USER_PW=?";
//		
//		return jdbcTemplate.queryForObject(CheckSql,new Object[]{userId,userPw},new RowMapper<UserVO>(){
//					public UserVO mapRow(ResultSet rs, int rowCnt) throws SQLException{
//						UserVO vo = new UserVO();
//						vo.setUser_id(rs.getString("user_id"));
//						vo.setUser_nm(rs.getString("user_nm"));
//						
//						return vo; 
//						
//					}
//				});
		
//		Map<String, String> SImap = new HashMap<>();
//		SImap.put("USER_ID",vo2.getUser_id());
//		SImap.put("USER_PW",vo2.getUser_nm());
//		
//		return SImap;
//	}

}
