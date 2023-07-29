package fullstack_fox.services;

import fullstack_fox.Entities.Story;
import fullstack_fox.Repositories.StoryRepository;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class StoryService {
    private final StoryRepository storyRepository;

    @Autowired
    public StoryService(StoryRepository storyRepository) {
        this.storyRepository = storyRepository;
    }

    List<Story> getAll() {
        return (List<Story>) storyRepository.findAll();
    }
}
