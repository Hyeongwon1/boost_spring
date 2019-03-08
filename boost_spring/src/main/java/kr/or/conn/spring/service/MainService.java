package kr.or.conn.spring.service;

import java.util.HashMap;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.conn.spring.dao.MainDao;
import kr.or.conn.spring.dto.ProductDTO;
import kr.or.conn.spring.dto.DisplayInfoDTO;

@Service
public class MainService {
	
	@Autowired
	MainDao MainDao;


//	public List<HashMap<String, Object>> BoardList(HashMap<String, Object> param){
//
//		return boardDao.BoardList(param);
//	}

	public List<HashMap<String, Object>> mainList(ProductDTO prdto) {
		// TODO Auto-generated method stub
		
		
		return MainDao.MainList(prdto);
	}


	public List<HashMap<String, Object>> promoList() {
		// TODO Auto-generated method stub
		
		return MainDao.PromoList();
	}


	public int mainListCount(ProductDTO prddto) {
		// TODO Auto-generated method stub
		return MainDao.MainListCount(prddto);
	}


	public HashMap<String, Object> detailEntry(HashMap<String, Object> param) {
		// TODO Auto-generated method stub
		return MainDao.DetailEntry(param);
	}


	public List<HashMap<String, Object>> DetailComentList(HashMap<String, Object> param) {
		// TODO Auto-generated method stub
		return MainDao.DetailComentList(param);
	}


	public int DetailComentListCount(HashMap<String, Object> param) {
		// TODO Auto-generated method stub
		return MainDao.DetailComentListCount(param);
	}


	public float DetailComentScore(HashMap<String, Object> param) {
		// TODO Auto-generated method stub
		return MainDao.DetailComentScore(param);
	}


	public HashMap<String, Object> DetailEtcImage(HashMap<String, Object> param) {
		// TODO Auto-generated method stub
		return MainDao.DetailEtcImage(param);
	}

//	public int getTotalRows(HashMap<String, Object> param) {
//		
//		return boardDao.getTotalRows(param);
//	}
//
//
//	public int boardWriteAc(ProductDTO boardVo) {
//		
//		return boardDao.BoardWrite(boardVo);
//	}
//
//
//	public ProductDTO BoardRead(int seq) {
//		// TODO Auto-generated method stub
//		return boardDao.BoardRead(seq);
//	}




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
