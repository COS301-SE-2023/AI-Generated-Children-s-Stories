package fullstack_fox.Repositories;

import fullstack_fox.DTOs.UserStoryInfoDTO;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface UserStoryInfoRepository extends JpaRepository<UserStoryInfoDTO, Long> {

    // Define custom queries on the view
    @Query("SELECT u FROM UserStoryInfoDTO u WHERE u.userId = :userId")
    List<UserStoryInfoDTO> findByUserId(Long userId);

    @Query("SELECT u FROM UserStoryInfoDTO u WHERE u.userId = :userId AND u.liked = true")
    List<UserStoryInfoDTO> findLikedByUserId(Long userId);
}
