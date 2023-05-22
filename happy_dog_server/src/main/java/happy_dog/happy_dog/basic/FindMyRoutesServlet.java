package happy_dog.happy_dog.basic;

import com.fasterxml.jackson.databind.ObjectMapper;
import happy_dog.happy_dog.connection.DBConnectionUtil;
import happy_dog.happy_dog.domain.Route;
import happy_dog.happy_dog.repository.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "findMyRoutesServlet",urlPatterns = "/myroutes")
public class FindMyRoutesServlet extends HttpServlet {

    private ObjectMapper objectMapper = new ObjectMapper();
    private List<Route> routeList = new ArrayList<>();

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserRepository userRepository = DBConnectionUtil.getConnetion();
        String email=request.getParameter("email");

        System.out.println("myroutes_email = " + email);

        try {
            routeList = userRepository.findMyRoutes(email);
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            String routesResult = objectMapper.writeValueAsString(routeList);
            response.getWriter().write(routesResult);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
}
