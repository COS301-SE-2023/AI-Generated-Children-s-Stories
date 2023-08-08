package fullstack_fox.Entities;

import com.fasterxml.jackson.annotation.JsonManagedReference;

import jakarta.persistence.*;
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
    @JsonManagedReference("user-progress") // Define the owner of the relationship
    @OneToMany(mappedBy = "user")
    private List<Progress> progress = new ArrayList<>();

    @JsonManagedReference("user-liked")
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Liked> liked = new ArrayList<>();

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

    public List<Progress> getProgress() {
        return progress;
    }

    public List<Liked> getLiked() {
        return liked;
    }

    public void setLiked(List<Liked> liked) {
        this.liked = liked;
    }
}
