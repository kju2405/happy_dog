package happy_dog.happy_dog.basic;

import com.fasterxml.jackson.databind.ObjectMapper;
import happy_dog.happy_dog.connection.DBConnectionUtil;
import happy_dog.happy_dog.domain.Route;
import happy_dog.happy_dog.domain.RouteLastId;
import happy_dog.happy_dog.repository.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "findLastRouteIdServlet",urlPatterns = "/lastRouteId")
public class FindLastRouteIdServlet extends HttpServlet {

    private ObjectMapper objectMapper = new ObjectMapper();

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserRepository userRepository = DBConnectionUtil.getConnetion();
        try {
            RouteLastId id = userRepository.findLastRouteId();
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            String routeLastId = objectMapper.writeValueAsString(id);
            response.getWriter().write(routeLastId);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
}
