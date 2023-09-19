package fullstack_fox.Controllers;

import fullstack_fox.DTOs.PostStoryDTO;
import fullstack_fox.Entities.Story;
import fullstack_fox.Entities.User;
import fullstack_fox.Repositories.StoryRepository;
import fullstack_fox.Repositories.UserRepository;
import fullstack_fox.services.StoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
public class StoryController {

    @Autowired
    StoryRepository storyRepository;

    @Autowired
    UserRepository userRepository;

    private final StoryService storyService;

    public StoryController(StoryService storyService) {
        this.storyService = storyService;
    }

    @GetMapping("/story/{id}")
    public Optional<Story> getStoryById(@PathVariable String id){
        Long storyId = Long.parseLong(id);
        Optional<Story> byId = storyRepository.findById(storyId);
        return byId;
    }

    // Authenticated
    @PostMapping("/story")
    public ResponseEntity<Story> create(@RequestBody PostStoryDTO postStoryDTO){

        //Authenticate the admin user
        User adminUser = userRepository.getAdminUserId();

        if (!new AuthenticateApiCalls(userRepository).authenticateApiKey(adminUser.getId(), postStoryDTO.getApiKey())) {
            System.out.println("Unauthorised");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
        }

       storyRepository.save(postStoryDTO.getStory());
        return ResponseEntity.status(HttpStatus.OK).body(postStoryDTO.getStory());
    }

}