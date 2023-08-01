package fullstack_fox.services;

import fullstack_fox.DTOs.UserStoryInfoDTO;
import fullstack_fox.Repositories.UserStoryInfoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class UserStoryInfoService {

    private final UserStoryInfoRepository userStoryInfoRepository;

    @Autowired
    public UserStoryInfoService(UserStoryInfoRepository userStoryInfoRepository) {
        this.userStoryInfoRepository = userStoryInfoRepository;
    }

    public List<UserStoryInfoDTO> findByUserId(Long userId) {
        return userStoryInfoRepository.findByUserId(userId);
    }

    public List<UserStoryInfoDTO> findLikedByUserId(Long userId) {
        return userStoryInfoRepository.findLikedByUserId(userId);
    }
}
