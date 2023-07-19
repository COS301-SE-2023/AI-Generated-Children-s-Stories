package fullstack_fox.Entities;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name="Page")
public class Page {

    @Id 
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column()
    private String image;
    @Column(length = 1024)
    private String text;

    @JsonBackReference("story-pages") //prevent infinite loop
    @ManyToOne 
    @JoinColumn(name="storyId")
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