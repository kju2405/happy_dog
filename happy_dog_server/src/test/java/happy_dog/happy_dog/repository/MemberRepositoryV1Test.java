package happy_dog.happy_dog.repository;

import com.zaxxer.hikari.HikariDataSource;
import happy_dog.happy_dog.connection.ConnectionConst;
import happy_dog.happy_dog.domain.Member;
import lombok.extern.slf4j.Slf4j;
import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import java.sql.SQLException;
import java.util.NoSuchElementException;

import static happy_dog.happy_dog.connection.ConnectionConst.*;

@Slf4j
class MemberRepositoryV1Test {
    UserRepository memberRepository;

    @BeforeEach
    void beforeEach(){
//        DriverManagerDataSource dataSource = new DriverManagerDataSource(URL, USERNAME, PASSWORD);

        HikariDataSource dataSource = new HikariDataSource();
        dataSource.setJdbcUrl(MySqlURL);
        dataSource.setUsername(MySqlUSERNAME);
        dataSource.setPassword(MySqlPASSWORD);

        memberRepository = new UserRepository(dataSource);
    }

    @Test
    void crud() throws SQLException {
        //save
        Member member = new Member("memberV5", 10000);
//        memberRepository.save();

        //findById
        Member findMember = memberRepository.findById(member.getMemberId());
        log.info("findMember={}", findMember);
        Assertions.assertThat(findMember).isEqualTo(member);

        //update
        memberRepository.update(member.getMemberId(), 20000);
        Member updateMember = memberRepository.findById(member.getMemberId());
        Assertions.assertThat(updateMember.getMoney()).isEqualTo(20000);

        //delete
        memberRepository.delete(member.getMemberId());
        Assertions.assertThatThrownBy(() -> memberRepository.findById(member.getMemberId())).isInstanceOf(NoSuchElementException.class);
    }

}