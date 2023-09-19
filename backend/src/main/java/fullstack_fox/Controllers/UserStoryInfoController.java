package fullstack_fox.Controllers;

import fullstack_fox.DTOs.PostProgressDTO;
import fullstack_fox.DTOs.UserStoryInfoDTO;
import fullstack_fox.Entities.Liked;
import fullstack_fox.Entities.Progress;
import fullstack_fox.Entities.Story;
import fullstack_fox.Entities.User;
import fullstack_fox.Repositories.LikedRepository;
import fullstack_fox.Repositories.ProgressRepository;
import fullstack_fox.Repositories.StoryRepository;
import fullstack_fox.Repositories.UserRepository;
import fullstack_fox.services.StoryService;
import fullstack_fox.services.UserStoryInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;
import java.util.stream.Collectors;

@RestController
public class UserStoryInfoController {

    @Autowired
    StoryRepository storyRepository;

    @Autowired
    LikedRepository likedRepository;

    @Autowired
    UserRepository userRepository;

    @Autowired
    ProgressRepository progressRepository;


    private final UserStoryInfoService userStoryInfoService;

    private final StoryService storyService;

    @Autowired
    public UserStoryInfoController(UserStoryInfoService userStoryInfoService, StoryService storyService) {
        this.userStoryInfoService = userStoryInfoService;
        this.storyService = storyService;
    }

    //for library page
    @GetMapping("/library/{userId}")
    public List<UserStoryInfoDTO> getEntriesByUserId(@PathVariable Long userId) {

        //stories being read
        List<UserStoryInfoDTO> storiesForUser = userStoryInfoService.findByUserId(userId);

        List<Story> allOtherStories = storyService.findWhereNotReading(userId);

        //add the other stories to the stories for the user by converting it to the DTO
        for (Story s : allOtherStories) {
            storiesForUser.add(new UserStoryInfoDTO(
                    userId, s.getId(), s.getTitle(), s.getTrailer(), false, 0, s.getPages().size()
            ));
        }

        return storiesForUser;
    }
    public List<UserStoryInfoDTO> getAllBooksInProgress(Long userId) {
        Optional<List<Progress>> optionalProgress = progressRepository.findProgressByUserId(userId);
        List<UserStoryInfoDTO> UserStoryInfoDTOs = optionalProgress.stream()
                .flatMap(List::stream)
                .map(this::convertToUserStoryInfoDTO)
                .collect(Collectors.toList());
        return UserStoryInfoDTOs;
    }

    private UserStoryInfoDTO convertToUserStoryInfoDTO(Progress progress) {
        boolean isLiked = likedRepository.existsByUserAndStory(progress.getUser(), progress.getStory());

        return new UserStoryInfoDTO(progress.getUser().getId(),
                progress.getStory().getId(),
                progress.getStory().getTitle(),
                progress.getStory().getTrailer(),
                isLiked,
                progress.getPageNumber(),
                progress.getStory().getPages().size()
        );
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

    private UserStoryInfoDTO convertToUserStoryInfoDTOFromStory(Story story, Long userId) {
        return new UserStoryInfoDTO(
                userId,
                story.getId(),
                story.getTitle(),
                story.getTrailer(),
                false,
                0,
                story.getPages().size()
        );
    }

    @GetMapping("/userStoryInfo/random/{userId}")
    private List<UserStoryInfoDTO> getRandomBook(@PathVariable Long userId) {

        //return list of all in progress, else return 1 random book
        List<UserStoryInfoDTO> storiesForUser = userStoryInfoService.findProgressByUserId(userId);
        if (!storiesForUser.isEmpty()) {
            Random random = new Random();
            List<UserStoryInfoDTO> list = new ArrayList<>();
            list.add(storiesForUser.get(random.nextInt(storiesForUser.size())));
            return list;
        }

        //all books
        storiesForUser = userStoryInfoService.findByUserId(userId);
        Random random = new Random();
        List<UserStoryInfoDTO> list = new ArrayList<>();
        list.add(storiesForUser.get(random.nextInt(storiesForUser.size())));
        return list;

    }

}
