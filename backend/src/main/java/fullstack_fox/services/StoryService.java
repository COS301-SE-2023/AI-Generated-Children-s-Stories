package fullstack_fox.services;

import fullstack_fox.DTOs.UserStoryInfoDTO;
import fullstack_fox.Entities.Story;
import fullstack_fox.Repositories.StoryRepository;
import jakarta.persistence.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class StoryService {
    private final StoryRepository storyRepository;

    @Autowired
    public StoryService(StoryRepository storyRepository) {
        this.storyRepository = storyRepository;
    }

    List<Story> getAll() {
        return (List<Story>) storyRepository.findAll();
    }

    public void deleteStoryById(Long id) {
        // First, find the Story entity by its id
        Optional<Story> optionalStory = storyRepository.findById(id);
        if (optionalStory.isPresent()) {
            Story story = optionalStory.get();
            // Now, delete the Story entity
            storyRepository.delete(story);
        } else {
            // Handle the case when the Story with the given id does not exist
            throw new EntityNotFoundException("Story with id " + id + " not found.");
        }
    }

    public List<Story> findWhereNotReading(Long userId) {
        return storyRepository.findWhereNotReading(userId);
    }
}
