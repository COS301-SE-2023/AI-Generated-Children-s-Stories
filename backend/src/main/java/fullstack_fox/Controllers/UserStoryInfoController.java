package fullstack_fox.Controllers;

import fullstack_fox.DTOs.UserStoryInfoDTO;
import fullstack_fox.services.UserStoryInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class UserStoryInfoController {

    private final UserStoryInfoService userStoryInfoService;

    @Autowired
    public UserStoryInfoController(UserStoryInfoService userStoryInfoService) {
        this.userStoryInfoService = userStoryInfoService;
    }

    // Define the endpoint to get all entries by user ID
    @GetMapping("/userStoryInfo/all/{userId}")
    public List<UserStoryInfoDTO> getEntriesByUserId(@PathVariable Long userId) {
        return userStoryInfoService.findByUserId(userId);
    }

    @GetMapping("/userStoryInfo/liked/{userId}")
    public List<UserStoryInfoDTO> getLikedEntriesByUserId(@PathVariable Long userId) {
        return userStoryInfoService.findLikedByUserId(userId);
    }

    @GetMapping("/userStoryInfo/progress/{userId}")
    public List<UserStoryInfoDTO> getProgressEntriesByUserId(@PathVariable Long userId) {
        return userStoryInfoService.findProgressByUserId(userId);
    }
}
