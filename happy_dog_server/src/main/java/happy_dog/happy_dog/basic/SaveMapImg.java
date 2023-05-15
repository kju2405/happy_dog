package happy_dog.happy_dog.basic;

import happy_dog.happy_dog.connection.DBConnectionUtil;
import happy_dog.happy_dog.repository.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet(name = "saveMapImg",urlPatterns = "/map/upload")
public class SaveMapImg extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String filename = request.getParameter("filename");
        Part filePart = request.getPart("file");
        byte[] data = filePart.getInputStream().readAllBytes();

        request.getParameterNames().asIterator().forEachRemaining(paramName -> System.out.println(paramName+"!!!!"));


        UserRepository userRepository = DBConnectionUtil.getConnetion();

        try {
            userRepository.saveImg(filename,new ByteArrayInputStream(data));
        }catch (SQLException e) {
            throw new RuntimeException(e);
        }
        response.getWriter().write("ok");

    }
}
