package fullstack_fox.Controllers;

import fullstack_fox.Entities.Story;
import fullstack_fox.Entities.UserStories;
import fullstack_fox.Repositories.UserStoriesRepository;
import fullstack_fox.services.UserStoriesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;

@RestController
public class UserStoryController {
    @Autowired
    UserStoriesService userStoriesService;

    @Autowired
    private UserStoriesRepository userStoriesRepository;

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


    @GetMapping("/story/random/{id}")
    public Story getRandomUnreadUnlikedStory(@PathVariable Long id) {

        //first check if there are stories that are being read....
        List<Story> currentlyReading = userStoriesService.getCurrentlyReading(id);

        if (!currentlyReading.isEmpty()) {
            int index = new Random().nextInt(currentlyReading.size());
            return currentlyReading.get(index);
        } else {
            System.out.println("Currently reading null");
        }

        //Fetch all unliked stories (in story table but not in liked table)
        List<Story> allUnlikedStories = userStoriesService.getAllUnlikedStories(id);

        //get all the stories in the table
        List<UserStories> userStories = userStoriesRepository.findByUserId(id);

        //get the stories that aren't overlapping
        //present in all unlikedStories
        //not present in userStories
        List<Story> unreadUnlikedStories = allUnlikedStories.stream()
                .filter(story -> userStories.stream()
                        .noneMatch(userStory -> userStory.getStory().getId().equals(story.getId())))
                .collect(Collectors.toList());

        //Get a random story in the list
        if (!unreadUnlikedStories.isEmpty()) {
            int index = new Random().nextInt(unreadUnlikedStories.size());
            return unreadUnlikedStories.get(index);
        }else {
            System.out.println("Unread Unliked null");
        }

        return null;
    }


}
