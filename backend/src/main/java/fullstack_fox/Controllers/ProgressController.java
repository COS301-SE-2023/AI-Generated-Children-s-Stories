package fullstack_fox.Controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import fullstack_fox.DTOs.PostProgressDTO;
import fullstack_fox.DTOs.UserStoryInfoDTO;
import fullstack_fox.Entities.Progress;
import fullstack_fox.Entities.Story;
import fullstack_fox.Entities.User;
import fullstack_fox.Repositories.ProgressRepository;
import fullstack_fox.Repositories.StoryRepository;
import fullstack_fox.Repositories.UserRepository;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;


@RestController
public class ProgressController {
    @Autowired
    ProgressRepository progressRepository;

    @Autowired
    UserRepository userRepository;

    @Autowired
    StoryRepository storyRepository;

    // Authenticated
    @PostMapping(path = "/progress")
    public ResponseEntity<Progress> createProgress(@RequestBody PostProgressDTO postProgress) {

        if (!new AuthenticateApiCalls(userRepository).authenticateApiKey(postProgress.getUserId(), postProgress.getApiKey())) {
            System.out.println("Unauthorised");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
        }

        // Get the user and story from the provided IDs in the DTO
        Optional<User> optionalUser = userRepository.findById(postProgress.getUserId());
        User user = optionalUser.orElseThrow(() -> new NoSuchElementException("User not found"));

        Optional<Story> optionalStory = storyRepository.findById(postProgress.getStoryId());
        Story story = optionalStory.orElseThrow(() -> new NoSuchElementException("Story not found"));

        // Check if a progress entry already exists for the given user and story
        Optional<Progress> optionalProgress = progressRepository.findByUserAndStory(user, story);

        if (optionalProgress.isPresent()) {
            // If a progress entry already exists, update the pageNumber and return the existing progress
            Progress existingProgress = optionalProgress.get();
            existingProgress.setPageNumber(postProgress.getPageNumber());
            Progress saved = progressRepository.save(existingProgress);
            return ResponseEntity.ok().body(saved);
        } else {
            // If a progress entry does not exist, create a new one and save it
            Progress newProgress = new Progress(user, story, postProgress.getPageNumber());
            Progress saved = progressRepository.save(newProgress);
            return ResponseEntity.ok().body(saved);
        }
    }

    // Authenticated
    @DeleteMapping(path = "/deleteProgress")
    public ResponseEntity<String> deleteProgress(@RequestBody PostProgressDTO postProgress) {

        if (!new AuthenticateApiCalls(userRepository).authenticateApiKey(postProgress.getUserId(), postProgress.getApiKey())) {
            System.out.println("Unauthorised");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
        }

        Progress progressToDelete = progressRepository.findByUser_IdAndStory_Id(postProgress.getUserId(), postProgress.getStoryId());

        if (progressToDelete != null) {
            progressRepository.delete(progressToDelete);
            return ResponseEntity.ok("Progress entry deleted successfully.");
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Progress entry not found.");
        }
    }

}
