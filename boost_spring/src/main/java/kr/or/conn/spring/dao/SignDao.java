package kr.or.conn.spring.dao;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.conn.spring.dto.UserVO;

@Repository
public class SignDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public int SignUpAc(UserVO UserVo) throws ClassNotFoundException {
		return sqlSession.insert("sign.signUpAction", UserVo);
	}

	public UserVO SignInAc(UserVO UserVo) {
		
		return sqlSession.selectOne("sign.signInAction", UserVo);
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
