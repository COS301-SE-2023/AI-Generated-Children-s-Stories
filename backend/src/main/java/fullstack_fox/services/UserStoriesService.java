package fullstack_fox.services;

import fullstack_fox.Entities.Story;
import fullstack_fox.Entities.UserStories;
import fullstack_fox.Repositories.UserStoriesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class UserStoriesService {
    private final UserStoriesRepository userStoriesRepository;

    @Autowired
    public UserStoriesService(UserStoriesRepository userStoriesRepository) {
        this.userStoriesRepository = userStoriesRepository;
    }

    // Service to find stories by user id
    public List<Story> findStoriesByUserId(Long userId) {
        List<UserStories> userStories = userStoriesRepository.findUserStoriesByUserId(userId);
        return userStories.stream().map(UserStories::getStory).collect(Collectors.toList());
    }

}
