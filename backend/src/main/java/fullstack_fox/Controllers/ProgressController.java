package fullstack_fox.Controllers;

import fullstack_fox.DTOs.ProgressDTO;
import fullstack_fox.Entities.Progress;
import fullstack_fox.Entities.Story;
import fullstack_fox.Entities.User;
import fullstack_fox.Repositories.ProgressRepository;
import fullstack_fox.Repositories.StoryRepository;
import fullstack_fox.Repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.awt.print.Book;
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
    public Progress create(@RequestBody ProgressDTO progressDTO) {
        // Get the user and story from the provided IDs in the DTO
        Optional<User> optionalUser = userRepository.findById(progressDTO.getUser());
        User user = optionalUser.orElseThrow(() -> new NoSuchElementException("User not found"));

        Optional<Story> optionalStory = storyRepository.findById(progressDTO.getStory().getId());
        Story story = optionalStory.orElseThrow(() -> new NoSuchElementException("Story not found"));

        // Check if a progress entry already exists for the given user and story
        Optional<Progress> optionalProgress = progressRepository.findByUserAndStory(user, story);

        if (optionalProgress.isPresent()) {
            // If a progress entry already exists, update the pageNumber and return the existing progress
            Progress existingProgress = optionalProgress.get();
            existingProgress.setPageNumber(progressDTO.getPageNumber());
            return progressRepository.save(existingProgress);
        } else {
            // If a progress entry does not exist, create a new one and save it
            Progress newProgress = new Progress(user, story, progressDTO.getPageNumber());
            return progressRepository.save(newProgress);
        }
    }

    public List<ProgressDTO> getAllBooksInProgress(Long userId) {
        Optional<List<Progress>> optionalProgress = progressRepository.findProgressByUserId(userId);

        List<ProgressDTO> progressDTOs = optionalProgress.stream()
                .flatMap(List::stream)
                .map(this::convertToProgressDTO)
                .collect(Collectors.toList());

        return progressDTOs;
    }

    public ProgressDTO getRandomBook(Long userId) {
        Iterable<Story> allBooks = storyRepository.findAll();
        List<ProgressDTO> progressDTOList = new ArrayList<>();

        Optional<User> currentUser = userRepository.findById(userId);
        User myUser = null;
        if (currentUser.isPresent()){
            myUser = currentUser.get();
        } else {
            throw new NoSuchElementException("No user found");
        }

        for (Story story : allBooks) {
            Progress progress = new Progress(myUser, story, 0);
            progressDTOList.add(convertToProgressDTO(progress));
        }

        if (progressDTOList.size() == 0)
            throw new NoSuchElementException("Progress list is empty");

        Random random = new Random();
        return progressDTOList.get(random.nextInt(progressDTOList.size()));
    }

    @GetMapping("/progress/{userId}")
    public List<ProgressDTO> getProgressForUser(@PathVariable Long userId) {
        List<ProgressDTO> currentlyReadingList = getAllBooksInProgress(userId);

        if (!currentlyReadingList.isEmpty())
            return currentlyReadingList;

        //currently reading is empty, return a random book
        currentlyReadingList.add(getRandomBook(userId));

        return currentlyReadingList;
    }

    //converts a progress object to a DTO
    public ProgressDTO convertToProgressDTO(Progress progress) {
        ProgressDTO progressDTO = new ProgressDTO();
        progressDTO.setStory(progress.getStory());
        progressDTO.setUser(progress.getUser().getId());
        progressDTO.setPageNumber(progressDTO.getPageNumber());

        return progressDTO;
    }

    @DeleteMapping(path = "/deleteProgress/{storyId}/{userId}")
    public ResponseEntity<String> delete(@PathVariable Long storyId, @PathVariable Long userId) {
        Progress progressToDelete = progressRepository.findByUserIdAndStoryId(userId, storyId);

        if (progressToDelete != null) {
            progressRepository.delete(progressToDelete);
            return ResponseEntity.ok("Progress entry deleted successfully.");
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Progress entry not found.");
        }
    }
}
