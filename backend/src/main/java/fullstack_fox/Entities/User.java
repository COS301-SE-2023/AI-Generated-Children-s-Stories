package fullstack_fox.Entities;

import com.fasterxml.jackson.annotation.JsonManagedReference;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name="User")
public class User {
    
    //user class must have uid and api token
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(length = 36)
    private String apiToken;
    @Column()
    private String firebaseUid;

    // User table relationship
    @JsonManagedReference //prevent infinite loop
    @OneToMany(
            mappedBy="user",
            cascade = CascadeType.ALL, //cascade operations
            orphanRemoval = true //delete story = delete pages
    )
    private List<UserStories> userStories = new ArrayList<>();

    public User() {}
    public User(String firebaseUid) {
        this.firebaseUid = firebaseUid;
        //generate API token
        this.apiToken = generateAPIToken();
    }

    public String generateAPIToken() {
        return  UUID.randomUUID().toString();
    }

    public Long getId() {
        return id;
    }

    public String getApiToken() {
        return apiToken;
    }

    public void nullifyApiToken() {
        this.apiToken = null;
    }

    public String getFirebaseUid() {
        return firebaseUid;
    }

}
