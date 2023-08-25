package fullstack_fox.Controllers;

import fullstack_fox.DTOs.PagesDTO;
import fullstack_fox.DTOs.PostProgressDTO;
import fullstack_fox.Entities.Page;
import fullstack_fox.Entities.Progress;
import fullstack_fox.Entities.Story;
import fullstack_fox.Repositories.PageRepository;
import fullstack_fox.Repositories.StoryRepository;
import fullstack_fox.services.StoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@RestController
public class StoryController {

    @Autowired
    StoryRepository storyRespository;

    @Autowired
    PageRepository pageRepository;

    private final StoryService storyService;

    public StoryController(StoryService storyService) {
        this.storyService = storyService;
    }

    @GetMapping("/story/{id}")
    public Optional<Story> getStoryById(@PathVariable String id){
        Long storyId = Long.parseLong(id);
        Optional<Story> byId = storyRespository.findById(storyId);
        return byId;
    }

    @PostMapping("/story")
    public Story create(@RequestBody Story story){
        storyRespository.save(story);
        return story;
    }

    @DeleteMapping("/story/{id}")
    public ResponseEntity<String> deleteStory(@PathVariable Long id) {
        storyService.deleteStoryById(id);
        return ResponseEntity.ok("Story with id " + id + " and its pages have been deleted.");
    }

    @GetMapping("/pages/{storyId}")
    public List<PagesDTO> getPages(@PathVariable Long storyId) {
        return getAllPages(storyId);
    }

    public List<PagesDTO> getAllPages(Long storyId) {
        Optional<List<Page>> optionalProgress = pageRepository.findPagesByStoryId(storyId);
        List<PagesDTO> pageDTOS = optionalProgress.stream()
                .flatMap(List::stream)
                .map(this::convertToPagesDTO)
                .collect(Collectors.toList());
        return pageDTOS;
    }

    public PagesDTO convertToPagesDTO(Page page) {
        return new PagesDTO(page);
    }
}