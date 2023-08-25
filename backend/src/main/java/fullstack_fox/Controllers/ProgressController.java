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

    @PostMapping(path = "/progress")
    public ResponseEntity<Progress> createProgress(@RequestBody Map<String, Object> requestBody) {

        String apiKey = (String) requestBody.get("apiKey");

        // Extract progress data
        ObjectMapper objectMapper = new ObjectMapper();
        PostProgressDTO postProgress = objectMapper.convertValue(requestBody.get("progressData"), PostProgressDTO.class);

        AuthenticateApiCalls authenticateApiCalls = new AuthenticateApiCalls(userRepository);

        if (authenticateApiCalls.authenticateApiKey(postProgress.getUserId(), apiKey))
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);

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

    public PostProgressDTO getRandomBook(Long userId) {
        Iterable<Story> allBooks = storyRepository.findAll();
        List<PostProgressDTO> progressLikedDTOList = new ArrayList<>();

        Optional<User> currentUser = userRepository.findById(userId);
        User myUser = null;
        if (currentUser.isPresent()){
            myUser = currentUser.get();
        } else {
            throw new NoSuchElementException("No user found");
        }

        for (Story story : allBooks) {
            Optional<Progress> progress = progressRepository.findByUserAndStory(myUser, story);
            if (progress.isPresent()) {
                Progress p = progress.get();
                progressLikedDTOList.add(convertToProgressDTO(p));
            }
        }

        if (progressLikedDTOList.size() != 0) {
            Random random = new Random();
            return progressLikedDTOList.get(random.nextInt(progressLikedDTOList.size()));
        }

        // If no available books, return a random book from allBooks
        List<Story> allBooksList = StreamSupport.stream(allBooks.spliterator(), false)
                .collect(Collectors.toList());
        Random random = new Random();
        Story randomStory = allBooksList.get(random.nextInt(allBooksList.size()));

        //convert to progress DTO
        Progress progress = new Progress(myUser, randomStory, 0);
        return new PostProgressDTO(progress);
    }

    //converts a progress object to a DTO
    public PostProgressDTO convertToProgressDTO(Progress progress) {
        return new PostProgressDTO(progress);
    }

    @DeleteMapping(path = "/deleteProgress")
    public ResponseEntity<String> deleteProgress(@RequestParam Long storyId, @RequestParam Long userId,
                                                 @RequestParam String apiKey) {

        //todo: authenticate api key...

        Progress progressToDelete = progressRepository.findByUser_IdAndStory_Id(userId, storyId);

        if (progressToDelete != null) {
            progressRepository.delete(progressToDelete);
            return ResponseEntity.ok("Progress entry deleted successfully.");
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Progress entry not found.");
        }
    }

    //insert: page number is set to 1
    //insert with page number set

    @PostMapping(path = "/createProgress")
    public ResponseEntity<String> postProgress(@RequestBody PostProgressDTO progress) {
        if (progress.getUserId() == null || progress.getStoryId() == null) {
            return ResponseEntity.badRequest().body("User ID or Story ID cannot be null.");
        }

        Progress progressToUpdate = progressRepository.findByUser_IdAndStory_Id(progress.getUserId(), progress.getStoryId());

        if (progressToUpdate != null) { //update
            progressToUpdate.setPageNumber(progress.getPageNumber());
            progressRepository.save(progressToUpdate);
            return ResponseEntity.ok("Progress updated.");
        } else { //update
            Optional<User> userToPostOptional = userRepository.findById(progress.getUserId());
            Optional<Story> storyToPostOptional = storyRepository.findById(progress.getStoryId());
            User userToPost = null;
            Story storyToPost = null;
            if (userToPostOptional.isPresent() && storyToPostOptional.isPresent()) {
                userToPost = userToPostOptional.get();
                storyToPost = storyToPostOptional.get();

                Progress newProgress = new Progress(userToPost, storyToPost, progress.getPageNumber());
                progressRepository.save(newProgress);
                return ResponseEntity.ok("Progress created.");
            }
            return ResponseEntity.badRequest().body("User or story is not present: " + userToPostOptional.isPresent() + ", " + storyToPostOptional.isPresent());
        }

    }
    //delete progress
}
