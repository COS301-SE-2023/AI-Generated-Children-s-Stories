package fullstack_fox.Controllers;

import fullstack_fox.Entities.Story;
import fullstack_fox.Entities.User;
import fullstack_fox.Entities.UserStories;
import fullstack_fox.Repositories.StoryRepository;
import fullstack_fox.Repositories.UserRepository;
import fullstack_fox.Repositories.UserStoriesRepository;
import fullstack_fox.services.UserStoriesService;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.Random;
import java.util.stream.Collectors;

@RestController
public class UserStoryController {
    @Autowired
    UserStoriesService userStoriesService;

    @Autowired
    private UserStoriesRepository userStoriesRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private StoryRepository storyRepository;

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

    @PostMapping( path = "/story/updateProgress",
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<String> updateProgress(@RequestBody UserStories userStories) {

        // First, check if the UserStories entry with the given userId and storyId exists
        UserStories userStoryToUpdate = userStoriesRepository.findByUserIdAndStoryId(
                userStories.getUser().getId(), userStories.getStory().getId());

        Optional<User> userToPass = userRepository.findById(userStories.getUser().getId());
        User user = null;
        if (userToPass.isPresent())
            user = userToPass.get();

        if (userStoryToUpdate != null) {
            // Update the page number
            userStoryToUpdate.setPageNumber(userStories.getPageNumber());

            // Save the updated UserStories object back to the database
            UserStories updatedUserStory = userStoriesRepository.save(userStoryToUpdate);

            return ResponseEntity.ok("Story updated");
        } else {

            Optional<Story> storyToUpdate = storyRepository.findById(userStories.getStory().getId());

            Story story = null;
            if (storyToUpdate.isPresent()) {
                story = storyToUpdate.get();

            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Story not found");
            }

            UserStories newUserStory = new UserStories(user, story, false, userStories.getPageNumber());

            return null;
        }
    }

    @PostMapping( path = "/story/updateLiked",
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<String> updateLiked(@RequestBody UserStories userStories) {

        // First, check if the UserStories entry with the given userId and storyId exists
        UserStories userStoryToUpdate = userStoriesRepository.findByUserIdAndStoryId(
                userStories.getUser().getId(), userStories.getStory().getId());

        Optional<User> userToPass = userRepository.findById(userStories.getUser().getId());
        User user = null;
        if (userToPass.isPresent())
            user = userToPass.get();

        if (userStoryToUpdate != null) {
            // Update the page number
            userStoryToUpdate.setLiked(userStories.getLiked());

            // Save the updated UserStories object back to the database
            UserStories updatedUserStory = userStoriesRepository.save(userStoryToUpdate);

            return ResponseEntity.ok("Story updated");
        } else {

            Optional<Story> storyToUpdate = storyRepository.findById(userStories.getStory().getId());

            Story story = null;
            if (storyToUpdate.isPresent()) {
                story = storyToUpdate.get();

            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Story not found");
            }

            UserStories newUserStory = new UserStories(user, story, false, userStories.getPageNumber());

            return null;
        }
    }
}
