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

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;
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

        Optional<Story> optionalStory = storyRepository.findById(progressDTO.getStory());
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

    @GetMapping("/progress/all")
    public List<ProgressDTO> getAllProgress() {
        Iterable<Progress> progresses = progressRepository.findAll();
        List<ProgressDTO> progressDTOList = StreamSupport.stream(progresses.spliterator(), false)
                .map(this::convertToDTO)
                .collect(Collectors.toList());
        return progressDTOList;
    }

    private ProgressDTO convertToDTO(Progress progress) {
        ProgressDTO dto = new ProgressDTO();
        dto.setId(progress.getId());
        dto.setPageNumber(progress.getPageNumber());
        dto.setUser(progress.getUser().getId());
        dto.setStory(progress.getStory().getId());
        // You can exclude other fields that you don't want to include in the DTO
        return dto;
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
