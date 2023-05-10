package happy_dog.happy_dog.basic;

import com.zaxxer.hikari.HikariDataSource;
import happy_dog.happy_dog.connection.ConnectionConst;
import happy_dog.happy_dog.domain.Member;
import happy_dog.happy_dog.repository.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.SQLException;

import static happy_dog.happy_dog.connection.ConnectionConst.*;

@WebServlet(name = "helloServlet", urlPatterns = "/hello")
public class HelloServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        System.out.println("HelloServlet.service");
//        System.out.println("request = " + request);
//        System.out.println("response = " + response);
//
//
//        HikariDataSource dataSource = new HikariDataSource();
//        dataSource.setJdbcUrl(MySqlURL);
//        dataSource.setUsername(MySqlUSERNAME);
//        dataSource.setPassword(MySqlPASSWORD);
//        UserRepository memberRepository = new UserRepository(dataSource);
//
//
//        String memberId = request.getParameter("memberId");
//        int money = Integer.parseInt(request.getParameter("money"));
//        Member member = new Member(memberId, money);
//        System.out.println(request.getServletPath());
//        System.out.println(request.getServerName());
//        try {
//            memberRepository.save(member);
//            response.setContentType("text/plain");
//            response.setCharacterEncoding("utf-8");
//            response.getWriter().write("memberId = "+memberId+"\n");
//            response.getWriter().write("money = " + money);
//        } catch (SQLException e) {
//            throw new RuntimeException(e);
//        }
    }
}
