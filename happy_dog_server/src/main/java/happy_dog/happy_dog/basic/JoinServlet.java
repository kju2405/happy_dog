package happy_dog.happy_dog.basic;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.zaxxer.hikari.HikariDataSource;
import happy_dog.happy_dog.connection.DBConnectionUtil;
import happy_dog.happy_dog.domain.User;
import happy_dog.happy_dog.repository.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletInputStream;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.util.StreamUtils;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;

import static happy_dog.happy_dog.connection.ConnectionConst.*;

@WebServlet(name = "joinServlet",urlPatterns = "/users/join")
public class JoinServlet extends HttpServlet {

    private ObjectMapper objectMapper = new ObjectMapper();
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        UserRepository userRepository = DBConnectionUtil.getConnetion();

        ServletInputStream inputStream = request.getInputStream();
        String messageBody = StreamUtils.copyToString(inputStream, StandardCharsets.UTF_8);
        User user = objectMapper.readValue(messageBody, User.class);
        String email = user.getEmail();
        String password = user.getPassword();
        String name = user.getName();
        System.out.println("email = " + email);
        System.out.println("password = " + password);
        System.out.println("name = " + name);

        try {
            userRepository.save(user);
            userRepository.saveDogInfo(email);
            response.setContentType("text/plain");
            response.setCharacterEncoding("utf-8");
            response.getWriter().write("email = " + email+"\n");
            response.getWriter().write("password = " + password+"\n");
            response.getWriter().write("name = "+name+"\n");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        response.getWriter().write("ok");
    }

}
