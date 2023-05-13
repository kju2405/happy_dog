package happy_dog.happy_dog.basic;

import com.fasterxml.jackson.databind.ObjectMapper;
import happy_dog.happy_dog.connection.DBConnectionUtil;
import happy_dog.happy_dog.domain.Dog;
import happy_dog.happy_dog.domain.User;
import happy_dog.happy_dog.repository.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "findDogByEmailServlet",urlPatterns = "/dog/info")
public class FindDogByEmailServlet extends HttpServlet {

    private ObjectMapper objectMapper = new ObjectMapper();

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserRepository userRepository = DBConnectionUtil.getConnetion();
        String email=request.getParameter("email");

        System.out.println("email = " + email);
        try {
            Dog dog = userRepository.findDogByEmail(email);
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            String userInfoResult = objectMapper.writeValueAsString(dog);
            response.getWriter().write(userInfoResult);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
}
