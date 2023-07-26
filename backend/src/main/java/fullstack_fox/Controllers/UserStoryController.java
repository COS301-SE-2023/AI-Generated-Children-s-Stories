package fullstack_fox.Controllers;

import fullstack_fox.Entities.Story;
import fullstack_fox.Repositories.UserStoriesRepository;
import fullstack_fox.services.UserService;
import fullstack_fox.services.UserStoriesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class UserStoryController {
    UserStoriesService userStoriesService;

    @Autowired
    public UserStoryController(UserStoriesService userStoriesService) {
        this.userStoriesService = userStoriesService;
    }

    @GetMapping("/story/currentlyReading/{id}")
    public List<Story> getCurrentlyReading(@PathVariable String id) {
        Long userId = Long.parseLong(id);
        List<Story> currentlyReading = userStoriesService.findStoriesByUserId(userId);
        return currentlyReading;
    }
}
