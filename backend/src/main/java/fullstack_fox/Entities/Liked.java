package fullstack_fox.Entities;

import com.fasterxml.jackson.annotation.JsonBackReference;

import javax.persistence.*;

@Entity
@Table(name="Liked")
public class Liked {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    public Liked() {};

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Story getStory() {
        return story;
    }

    public void setStory(Story story) {
        this.story = story;
    }

    @JsonBackReference //prevent infinite loop
    @ManyToOne
    @JoinColumn(name="userId")
    private User user;

    @JsonBackReference //prevent infinite loop
    @ManyToOne
    @JoinColumn(name="storyId")
    private Story story;
}
