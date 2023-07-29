package fullstack_fox.Controllers;

import fullstack_fox.Entities.Story;
import fullstack_fox.Entities.User;
import fullstack_fox.Entities.UserStories;
import fullstack_fox.Repositories.StoryRepository;
import fullstack_fox.Repositories.UserRepository;
import fullstack_fox.Repositories.UserStoriesRepository;
import fullstack_fox.services.StoryService;
import fullstack_fox.services.UserStoriesService;

import java.util.ArrayList;
import java.util.Random;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
public class UserStoryController {
    @Autowired
    UserStoriesService userStoriesService;

    @Autowired
    StoryService storyService;

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

    List<Story> getRandomCurrentlyReading(Long id) {
        //first check if there are stories that are being read....
        return userStoriesService.getCurrentlyReading(id);

    }

    //if there are stories in progress
    //display all stories in progress

    //if there are no stories in progress
    //pick a random story and show it

    @GetMapping("/story/random/{id}")
    public List<Story> getRandomUnreadUnlikedStory(@PathVariable Long id) {
        //get currently reading
        List<Story> currentlyReading = userStoriesService.getCurrentlyReading(id);

        //currently reading has content
        if (!currentlyReading.isEmpty())
            return currentlyReading;

        //get a random story and show it
        List<Story> allStories = (List<Story>) storyRepository.findAll();

        if (allStories.size() == 0) {
            System.out.println("There are no stories in the database!");
            return null;
        }

        Random random = new Random();
        int randomIndex = random.nextInt(allStories.size());
        //get a random index and return it
        Story story = allStories.get(randomIndex);
        List<Story> toRet = new ArrayList<>();
        toRet.add(story);
        return toRet;
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
