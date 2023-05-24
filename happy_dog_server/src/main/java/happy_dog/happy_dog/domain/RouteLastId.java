package happy_dog.happy_dog.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class RouteLastId {
    private int lastId;

    public RouteLastId() {
    }

    public RouteLastId(int lastId) {
        this.lastId = lastId;
    }
}
