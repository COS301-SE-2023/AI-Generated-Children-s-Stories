package fullstack_fox.Entities;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.*;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Table(name="Story")
public class Story {

    @Id 
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column()
    private final String title;
    @Column(length = 2048)
    private final String trailer;

    // Pages table relationship
    @JsonManagedReference("story-pages") //prevent infinite loop
    @OneToMany(
        mappedBy="story",
        cascade = CascadeType.ALL, //cascade operations
        orphanRemoval = true //delete story = delete pages
    )
    private List<Page> pages = new ArrayList<>();

    // UserStories table relationship
    @JsonManagedReference("story-userStories") //prevent infinite loop
    @OneToMany(
            mappedBy="story",
            cascade = CascadeType.ALL, //cascade operations
            orphanRemoval = true //delete story = delete pages
    )
    private List<UserStories> userStories = new ArrayList<>();

    public Story() {
        this.title = "";
        this.trailer = "";
    }

    public Story(String title, String trailer) {
        this.title = title;
        this.trailer = trailer;
    }

    public Long getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getTrailer() {
        return trailer;
    }

    public List<Page> getPages() {
        return pages;
    }

    public void setPages(List<Page> pages) {
        this.pages.clear();
        this.pages.addAll(pages);
    }

    public List<UserStories> getUserStories() {
        return userStories;
    }

    public void setUserStories(List<UserStories> userStories) {
        this.userStories = userStories;
    }
}