package happy_dog.happy_dog.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data @Getter @Setter
public class Route {
    private String userEmail;
    private int minutes;
    private String walkKind;
    private String walkLevel;
    private String keyword1;
    private String keyword2;

    public Route() {
    }
}