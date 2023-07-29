package fullstack_fox.Entities;

import com.fasterxml.jackson.annotation.JsonBackReference;

import javax.persistence.*;

@Entity
@Table(name="Progress")
public class Progress {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @JsonBackReference //prevent infinite loop
    @ManyToOne
    @JoinColumn(name="userId")
    private User user;

    // Story table relationship
    @JsonBackReference("progress") //prevent infinite loop
    @ManyToOne
    @JoinColumn(name="storyId")
    private Story story;

    @Column()
    private int pageNumber;

    public Progress(User user, Story story, int pageNumber) {
        this.user = user;
        this.story = story;
        this.pageNumber = pageNumber;
    }

    public Story getStory() {
        return story;
    }


}
