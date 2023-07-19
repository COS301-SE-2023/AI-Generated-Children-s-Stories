package fullstack_fox.Entities;

import com.fasterxml.jackson.annotation.JsonBackReference;

import javax.persistence.*;

@Entity
@Table(name="UserStories")
public class UserStories {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @JsonBackReference //prevent infinite loop
    @ManyToOne
    @JoinColumn(name="userId")
    private User user;

    // Story table relationship
    @JsonBackReference("story-userStories") //prevent infinite loop
    @ManyToOne
    @JoinColumn(name="storyId")
    private Story story;

    @Column()
    private boolean liked;
    @Column()
    private int pageNumber;
}
