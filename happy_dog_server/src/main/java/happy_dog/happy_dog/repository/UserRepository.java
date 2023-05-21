package happy_dog.happy_dog.repository;

import happy_dog.happy_dog.domain.Dog;
import happy_dog.happy_dog.domain.Route;
import happy_dog.happy_dog.domain.User;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.support.JdbcUtils;

import javax.sql.DataSource;
import java.io.ByteArrayInputStream;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;


@Slf4j
public class UserRepository {

    private final DataSource dataSource;

    public UserRepository(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public void saveDogInfo(String useremail) throws SQLException {
        //dog 테이블에 사용자 이메일 저장
        String sql="insert into dog(useremail,dogname,dogage,dogsex,dogkind,dogfeature) values(?,?,?,?,?,?);";

        Connection con = null;
        PreparedStatement pstmt = null;


        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, useremail);
            pstmt.setString(2, "");
            pstmt.setString(3, "");
            pstmt.setString(4, "");
            pstmt.setString(5, "");
            pstmt.setString(6, "");
            pstmt.executeUpdate();
        } catch (SQLException e) {
            log.error("db error",e);
            throw e;
        }finally {
            close(con, pstmt, null);
        }
    }

    public void updateDogInfo(Dog dog) throws SQLException {
        String sql="update dog set dogname=?, dogage=?,dogsex=?, dogkind=?, dogfeature=? where useremail=?;";

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
    public void saveImg(String filename, ByteArrayInputStream data) throws SQLException {
        String sql="INSERT INTO images (filename, data) VALUES (?, ?)";

        Connection con=null;
        PreparedStatement pstmt=null;

        try {
            con=getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, filename);
            pstmt.setBinaryStream(2,data);
            pstmt.executeUpdate();
        }catch (SQLException e){
            log.error("db error",e);
            throw e;
        }finally {
            close(con, pstmt, null);
        }
    }

    public void saveRoute(Route route) throws SQLException {
        String sql="insert into routes (useremail, minutesWord, walkKind, walkLevel, keyword1, keyword2,minutes,personAge,dogAge,walkStatis) values (?,?,?,?,?,?,?,?,?,?);";

        Connection con=null;
        PreparedStatement pstmt=null;

        try {
            con=getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, route.getUserEmail());
            if (route.getMinutes() <= 30) {
                pstmt.setString(2,"VERYLOW");
            } else if (route.getMinutes() <= 60) {
                pstmt.setString(2, "LOW");
            } else if (route.getMinutes() <= 90) {
                pstmt.setString(2, "MIDDLE");
            } else if (route.getMinutes() <= 120) {
                pstmt.setString(2, "HIGH");
            } else {
                pstmt.setString(2,"TOOHIGH");
            }

            if (route.getWalkKind().equals("걷기")) {
                pstmt.setString(3, "WALK");
            } else if (route.getWalkKind().equals("달리기")) {
                pstmt.setString(3, "RUN");
            } else {
                pstmt.setString(3, "CLIMB");
            }

            if (route.getWalkLevel().equals("편함")) {
                pstmt.setString(4, "EASY");
            } else if (route.getWalkLevel().equals("보통")) {
                pstmt.setString(4,"NORMAL");
            } else {
                pstmt.setString(4,"HARD");
            }

            pstmt.setString(5, route.getKeyword1());
            pstmt.setString(6, route.getKeyword2());
            pstmt.setInt(7,route.getMinutes());
            pstmt.setString(8,route.getPersonAge());
            pstmt.setString(9, route.getDogAge());
            pstmt.setString(10, route.getWalkStatis());
            pstmt.executeUpdate();
        }catch (SQLException e){
            log.error("db error",e);
            throw e;
        }finally {
            close(con, pstmt, null);
        }
    }
    public void update(String email, String name,String sex,String age,String durationWalking,String walkTime,String job, String advice, String questionDog) throws SQLException {
        String sql = "update users set name=?, sex=?, age=?, durationWalking=?, walkTime=?, job=?, advice=?, questionDog=? where email=?;";

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
        String sql = "delete from member where member_id = ?;";

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
        String sql = "insert into users(email,password,name,sex,age,durationWalking,walkTime,job,advice,questionDog) values (?, ?, ?,?,?,?,?,?,?,?);";

        Connection con = null;
        PreparedStatement pstmt = null;


        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, user.getEmail());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getName());
            pstmt.setString(4, user.getSex());
            pstmt.setString(5, user.getAge());
            pstmt.setString(6, user.getDurationWalking());
            pstmt.setString(7, user.getWalkTime());
            pstmt.setString(8, user.getJob());
            pstmt.setString(9, user.getAdvice());
            pstmt.setString(10, user.getQuestionDog());

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
        String sql = "select * from users where email=?;";

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

    public Dog findDogByEmail(String email) throws SQLException {
        String sql = "select * from dog where useremail=?;";

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;


        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                Dog dog = new Dog();
                dog.setUserEmail(rs.getString("useremail"));
                dog.setDogName(rs.getString("dogname"));
                dog.setDogAge(rs.getString("dogage"));
                dog.setDogSex(rs.getString("dogsex"));
                dog.setDogKind(rs.getString("dogkind"));
                dog.setDogFeature(rs.getString("dogfeature"));

                return dog;
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

    public List<Route> findRoutes() throws SQLException {
        String sql = "select * from routes;";

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Route> routeResult = new ArrayList<>();


        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Route route = new Route();
                route.setUserEmail(rs.getString("useremail"));
                route.setMinutes(rs.getInt("minutes"));
                route.setWalkKind(rs.getString("walkKind"));
                route.setWalkLevel(rs.getString("walkLevel"));
                route.setKeyword1(rs.getString("keyword1"));
                route.setKeyword2(rs.getString("keyword2"));
                route.setPersonAge(rs.getString("personAge"));
                route.setDogAge(rs.getString("dogAge"));
                route.setWalkStatis(rs.getString("walkStatis"));
                route.setMinutesWord(rs.getString("minutesWord"));
                routeResult.add(route);
            }
        } catch (SQLException e) {
            log.error("db error",e);
            throw e;
        }finally {
            close(con, pstmt, rs);
        }
        return routeResult;
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
