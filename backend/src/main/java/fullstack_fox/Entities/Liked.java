package fullstack_fox.Entities;

import com.fasterxml.jackson.annotation.JsonBackReference;

import javax.persistence.*;

@Entity
@Table(name="Liked")
public class Liked {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @JsonBackReference //prevent infinite loop
    @ManyToOne
    @JoinColumn(name="userId")
    private User user;

    @JsonBackReference //prevent infinite loop
    @ManyToOne
    @JoinColumn(name="storyId")
    private Story story;
}
