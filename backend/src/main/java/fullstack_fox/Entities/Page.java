package fullstack_fox.Entities;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Entity
@Table(name="Page")
public class Page {

    @Id 
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(length = 2048)
    private String image;
    @Column(length = 2048)
    private String text;

    @JsonBackReference("story-pages") //prevent infinite loop
    @ManyToOne
    @JoinColumn(name="storyId")
    @OnDelete(action = OnDeleteAction.CASCADE)
    private Story story;

    public Page() {
        this.image = "";
        this.text = "";
    }

    public Page(String image, String text, Story story) {
        this.image = image;
        this.text = text;
        this.story = story;
    }

    public Long getId() {
        return id;
    }

    public String getImage() {
        return image;
    }

    public String getText() {
        return text;
    }

    public Story getStory() {
        return story;
    }
}