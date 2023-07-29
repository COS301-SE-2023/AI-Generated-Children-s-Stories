package fullstack_fox.Controllers;

import fullstack_fox.DTOs.ProgressDTO;
import fullstack_fox.Entities.Progress;
import fullstack_fox.Repositories.ProgressRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;


@RestController
public class ProgressController {
    @Autowired
    ProgressRepository progressRepository;

    @PostMapping(path = "/progress")
    public Progress create(@RequestBody Progress progress) {
        return progressRepository.save(progress);
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
