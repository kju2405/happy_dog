package happy_dog.happy_dog.repository;

import happy_dog.happy_dog.domain.Dog;
import happy_dog.happy_dog.domain.Member;
import happy_dog.happy_dog.domain.User;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.support.JdbcUtils;

import javax.sql.DataSource;
import java.sql.*;
import java.util.NoSuchElementException;


@Slf4j
public class UserRepository {

    private final DataSource dataSource;

    public UserRepository(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public void saveDogInfo(String useremail) throws SQLException {
        //dog 테이블에 사용자 이메일 저장
        String sql="insert into dog(useremail) values(?)";

        Connection con = null;
        PreparedStatement pstmt = null;


        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, useremail);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            log.error("db error",e);
            throw e;
        }finally {
            close(con, pstmt, null);
        }
    }

    public void updateDogInfo(Dog dog) throws SQLException {
        String sql="update dog set dogname=?, dogage=?,dogsex=?, dogkind=?, dogfeature=? where useremail=?";

        Connection con = null;
        PreparedStatement pstmt = null;


        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, dog.getDogName());
            pstmt.setString(2, dog.getDogAge());
            pstmt.setString(3, dog.getDogSex());
            pstmt.setString(4, dog.getDogKind());
            pstmt.setString(5, dog.getDogFeature());
            pstmt.setString(6, dog.getUserEmail());
            int resultSize = pstmt.executeUpdate();
            log.info("resultSize={}", resultSize);
        } catch (SQLException e) {
            log.error("db error", e);
            throw e;
        }finally {
            close(con, pstmt, null);
        }
    }
    public void update(String email, String name,String sex,String age,String durationWalking,String walkTime,String job, String advice, String questionDog) throws SQLException {
        String sql = "update users set name=?, sex=?, age=?, durationWalking=?, walkTime=?, job=?, advice=?, questionDog=? where email=?";

        Connection con = null;
        PreparedStatement pstmt = null;

        
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, sex);
            pstmt.setString(3, age);
            pstmt.setString(4, durationWalking);
            pstmt.setString(5, walkTime);
            pstmt.setString(6, job);
            pstmt.setString(7, advice);
            pstmt.setString(8, questionDog);
            pstmt.setString(9, email);
            int resultSize = pstmt.executeUpdate();
            log.info("resultSize={}", resultSize);
        } catch (SQLException e) {
            log.error("db error", e);
            throw e;
        }finally {
            close(con, pstmt, null);
        }
    }

    public void delete(String memberid) throws SQLException {
        String sql = "delete from member where member_id = ?";

        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, memberid);
            int resultSize = pstmt.executeUpdate();

        } catch (SQLException e) {
            log.error("db error",e);
            throw e;
        }finally {
            close(con, pstmt, null);
        }
    }

    public User save(User user) throws SQLException {
        String sql = "insert into users(email,password,name) values (?, ?, ?)";

        Connection con = null;
        PreparedStatement pstmt = null;


        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, user.getEmail());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getName());
            pstmt.executeUpdate();
            return user;
        } catch (SQLException e) {
            log.error("db error",e);
            throw e;
        }finally {
            close(con, pstmt, null);
        }
    }

    public User findByEmail(String email) throws SQLException {
        String sql = "select * from users where email=?";

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;


        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setName(rs.getString("name"));
                user.setSex(rs.getString("sex"));
                user.setAge(rs.getString("age"));
                user.setDurationWalking(rs.getString("durationWalking"));
                user.setWalkTime(rs.getString("walkTime"));
                user.setJob(rs.getString("job"));
                user.setAdvice(rs.getString("advice"));
                user.setQuestionDog(rs.getString("questionDog"));

                return user;
            } else {
                throw new NoSuchElementException("user not found email = " + email);
            }
        } catch (SQLException e) {
            log.error("db error",e);
            throw e;
        }finally {
            close(con, pstmt, rs);
        }
    }
    private void close(Connection con, Statement stmt, ResultSet rs) {
        JdbcUtils.closeResultSet(rs);
        JdbcUtils.closeStatement(stmt);
        JdbcUtils.closeConnection(con);
    }

    private Connection getConnection() throws SQLException {
        Connection con = dataSource.getConnection();
        log.info("get connection = {}, class = {}", con, con.getClass());
        return con;
    }
}
