package fullstack_fox.Entities;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

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
    @JsonManagedReference("story-pages")
    @OneToMany(mappedBy = "story", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Page> pages = new ArrayList<>();

    // UserStories table relationship
    @JsonManagedReference("story-progress")
    @OneToMany(
            mappedBy="story",
            cascade = CascadeType.ALL, //cascade operations
            orphanRemoval = true //delete story = delete pages
    )
    private List<Progress> progress = new ArrayList<>();

    @JsonManagedReference("story-liked")
    @OneToMany(mappedBy = "story", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Liked> likedList = new ArrayList<>();

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

    public List<Progress> getProgress() {
        return progress;
    }

    public void setProgress(List<Progress> progress) {
        this.progress = progress;
    }
}