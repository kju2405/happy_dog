package happy_dog.happy_dog.basic;

import com.fasterxml.jackson.databind.ObjectMapper;
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

@WebServlet(name = "updateUserServlet",urlPatterns = "/users/update")
public class UpdateDogServlet extends HttpServlet {

    private ObjectMapper objectMapper = new ObjectMapper();

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserRepository userRepository = DBConnectionUtil.getConnetion();
        ServletInputStream inputStream = request.getInputStream();
        String messageBody = StreamUtils.copyToString(inputStream, StandardCharsets.UTF_8);
        User user = objectMapper.readValue(messageBody, User.class);
        String email = user.getEmail();
        String name = user.getName();
        String sex = user.getSex();
        String age = user.getAge();
        String durationWalking = user.getDurationWalking();
        String walkTime = user.getWalkTime();
        String job = user.getJob();
        String advice = user.getAdvice();
        String questionDog = user.getQuestionDog();
        try {
            userRepository.update(email, name, sex, age, durationWalking, walkTime, job, advice, questionDog);
            response.setContentType("text/plain");
            response.setCharacterEncoding("utf-8");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        response.getWriter().write("ok");

    }
}
