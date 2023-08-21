package fullstack_fox.Controllers;

import fullstack_fox.DTOs.UserStoryInfoDTO;
import fullstack_fox.Entities.Liked;
import fullstack_fox.Entities.Story;
import fullstack_fox.Entities.User;
import fullstack_fox.Repositories.LikedRepository;
import fullstack_fox.Repositories.StoryRepository;
import fullstack_fox.Repositories.UserRepository;
import fullstack_fox.services.UserStoryInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import javax.swing.text.html.Option;
import java.util.*;

@RestController
public class UserStoryInfoController {

    @Autowired
    StoryRepository storyRepository;

    @Autowired
    LikedRepository likedRepository;

    @Autowired
    UserRepository userRepository;

    private final UserStoryInfoService userStoryInfoService;

    @Autowired
    public UserStoryInfoController(UserStoryInfoService userStoryInfoService) {
        this.userStoryInfoService = userStoryInfoService;
    }

    //todo: should not be callable endpoint!!!!, can return null
    @GetMapping("/userStoryInfo/all/{userId}")
    public List<UserStoryInfoDTO> getEntriesByUserId(@PathVariable Long userId) {
        return userStoryInfoService.findByUserId(userId);
    }

    @GetMapping("/userStoryInfo/liked/{userId}")
    public List<UserStoryInfoDTO> getLikedEntriesByUserId(@PathVariable Long userId) {
        return userStoryInfoService.findLikedByUserId(userId);
    }

    private UserStoryInfoDTO convertToUserStoryInfoDTO(Story story, Long userId, int pageNumber) {
        //get the user
        Optional<User> optionalUser = userRepository.findById(userId);

        if (optionalUser.isPresent()) {

            User u  = optionalUser.get();
            Optional<Liked> liked = likedRepository.findByUserAndStory(u, story);
            boolean isLiked = false;

            if (liked.isPresent())
                isLiked = true;

            //get page number

            return new UserStoryInfoDTO(userId, story.getId(), story.getTitle(), story.getTrailer(),
                    isLiked, pageNumber, story.getPages().size());

        }

        throw new NoSuchElementException("User not found");

    }

    @GetMapping("/userStoryInfo/random/{userId}")
    private List<UserStoryInfoDTO> getRandomBook(@PathVariable Long userId) {
        List<Story> allBooks =  storyRepository.findAll();

        List<UserStoryInfoDTO> currentList = new ArrayList<>();

        if (allBooks.isEmpty()) {
            throw new NoSuchElementException("Empty books");
        }

        //get random index
        Random random = new Random();
        Story randomStory = allBooks.get(random.nextInt(allBooks.size()));

        Optional<User> optionalUser = userRepository.findById(userId);
        User u = null;
        if (optionalUser.isPresent()){
            u = optionalUser.get();
        }

        currentList.add(convertToUserStoryInfoDTO(randomStory, u.getId(), 0));

        return currentList;

    }

}
