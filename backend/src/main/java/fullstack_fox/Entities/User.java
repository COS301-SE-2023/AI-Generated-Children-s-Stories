package fullstack_fox.Entities;

import com.fasterxml.jackson.annotation.JsonManagedReference;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name="User")
public class User {


    //user class must have uid and api token
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column()
    private String firebaseUid;
    @Column(length = 4096)
    private String firebaseToken;

    // User table relationship
    @JsonManagedReference //prevent infinite loop
    @OneToMany(
            mappedBy="user",
            cascade = CascadeType.ALL, //cascade operations
            orphanRemoval = true //delete story = delete pages
    )
    private List<UserStories> userStories = new ArrayList<>();

    public User() {}

    public User(String firebaseToken) {
        this.firebaseToken = firebaseToken;
    }

    public Long getId() {
        return id;
    }

    public String getFirebaseToken() {
        return firebaseToken;
    }

    public void setFirebaseToken(String firebaseToken) {
        this.firebaseToken = firebaseToken;
    }

    public String getFirebaseUid() {
        return firebaseUid;
    }

    public void setFirebaseUid(String firebaseUid) {
        this.firebaseUid = firebaseUid;
    }

}
