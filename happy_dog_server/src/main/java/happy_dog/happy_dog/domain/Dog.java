package happy_dog.happy_dog.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data @Getter @Setter
public class Dog {
    private String userEmail;
    private String dogName;
    private String dogAge;
    private String dogSex;
    private String dogKind;
    private String dogFeature;

    public Dog() {
    }
}
