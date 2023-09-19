package fullstack_fox.Controllers;

import fullstack_fox.Entities.Liked;
import fullstack_fox.Entities.Story;
import fullstack_fox.Entities.User;
import fullstack_fox.Repositories.LikedRepository;
import fullstack_fox.Repositories.StoryRepository;
import fullstack_fox.Repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
public class LikedController {
    @Autowired
    LikedRepository likedRepository;

    @Autowired
    UserRepository userRepository;

    @Autowired
    StoryRepository storyRepository;

    //Like a story
    @PostMapping("/liked/stories")
    public ResponseEntity<String> likeStory(@RequestParam Long userId, @RequestParam Long storyId, @RequestParam String apiKey) {

        AuthenticateApiCalls authenticateApiCalls = new AuthenticateApiCalls(userRepository);
        if (!authenticateApiCalls.authenticateApiKey(userId, apiKey)) {
            System.out.println("Unauthorised");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
        }

        // Check if the user and story exist in the database
        User user = userRepository.findById(userId).orElse(null);
        Story story = storyRepository.findById(storyId).orElse(null);

        if (user == null || story == null) {
            return ResponseEntity.badRequest().body("User or Story not found.");
        }

        // Check if the story is already liked by the user
        boolean isLiked = likedRepository.existsByUserAndStory(user, story);
        if (isLiked) {
            return ResponseEntity.badRequest().body("Story is already liked by the user.");
        }

        // Create the new Liked entity and save it to the database
        Liked liked = new Liked();
        liked.setUser(user);
        liked.setStory(story);

        likedRepository.save(liked);

        return ResponseEntity.ok("Story added to the liked page.");
    }

    //Unlike a story
    @DeleteMapping("/liked/stories")
    public ResponseEntity<String> deleteStoryFromLikedPage(@RequestParam Long userId, @RequestParam Long storyId) {
        // Check if the user and story exist in the database
        User user = userRepository.findById(userId).orElse(null);
        Story story = storyRepository.findById(storyId).orElse(null);

        if (user == null || story == null) {
            return ResponseEntity.badRequest().body("User or Story not found.");
        }

        // Find the Liked entity associated with the user and story
        Optional<Liked> isLiked = likedRepository.findByUserAndStory(user, story);
        if (isLiked.isPresent()) {
            Liked liked = isLiked.get();

            // Delete the Liked entity from the database
            likedRepository.delete(liked);
            return ResponseEntity.ok("Story deleted from the liked page.");
        }

        return ResponseEntity.badRequest().body("Story is not liked by the user.");
    }
}
