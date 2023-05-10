package happy_dog.happy_dog.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data @Getter @Setter
public class User {
    private String userId;
    private String email;
    private String password;
    private String name;
    private String sex;
    private String age;
    private String durationWalking;
    private String walkTime;
    private String job;
    private String advice;
    private String questionDog;

    public User() {
    }

    public User(String userId, String email, String password) {
        this.userId = userId;
        this.email = email;
        this.password = password;
    }
}
