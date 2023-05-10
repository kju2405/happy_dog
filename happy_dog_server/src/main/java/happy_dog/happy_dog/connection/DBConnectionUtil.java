package happy_dog.happy_dog.connection;

import com.zaxxer.hikari.HikariDataSource;
import happy_dog.happy_dog.repository.UserRepository;
import lombok.extern.slf4j.Slf4j;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import static happy_dog.happy_dog.connection.ConnectionConst.*;

@Slf4j
public class DBConnectionUtil {
    public static UserRepository getConnetion(){

        HikariDataSource dataSource = new HikariDataSource();
        dataSource.setJdbcUrl(MySqlURL);
        dataSource.setUsername(MySqlUSERNAME);
        dataSource.setPassword(MySqlPASSWORD);
        UserRepository userRepository = new UserRepository(dataSource);
        return userRepository;
    }
}
