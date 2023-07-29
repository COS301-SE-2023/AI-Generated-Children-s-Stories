package fullstack_fox.Controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import fullstack_fox.Repositories.StoryRepository;
import fullstack_fox.Entities.Story;

import java.util.Optional;

@RestController
public class StoryController {

    @Autowired
    StoryRepository storyRespository;

    @GetMapping("/story/{id}")
    public Optional<Story> getStoryById(@PathVariable String id){
        Long storyId = Long.parseLong(id);
        Optional<Story> byId = storyRespository.findById(storyId);
        return byId;
    }

    @PostMapping( path = "/story",
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE
    )

    public Story create(@RequestBody Story story){
        storyRespository.save(story);
        return story;
    }
}