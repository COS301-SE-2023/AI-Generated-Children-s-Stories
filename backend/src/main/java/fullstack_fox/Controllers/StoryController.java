package fullstack_fox.Controllers;

import fullstack_fox.Entities.Story;
import fullstack_fox.Repositories.StoryRepository;
import fullstack_fox.services.StoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
public class StoryController {

    @Autowired
    StoryRepository storyRespository;

    private final StoryService storyService;

    public StoryController(StoryService storyService) {
        this.storyService = storyService;
    }

    @GetMapping("/story/{id}")
    public Optional<Story> getStoryById(@PathVariable String id){
        Long storyId = Long.parseLong(id);
        Optional<Story> byId = storyRespository.findById(storyId);
        return byId;
    }

    @PostMapping("/story")
    public Story create(@RequestBody Story story){
        storyRespository.save(story);
        return story;
    }

    @DeleteMapping("/stories/{id}")
    public ResponseEntity<String> deleteStory(@PathVariable Long id) {
        storyService.deleteStoryById(id);
        return ResponseEntity.ok("Story with id " + id + " and its pages have been deleted.");
    }
}