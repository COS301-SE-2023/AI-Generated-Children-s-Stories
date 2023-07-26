package fullstack_fox.Repositories;

import fullstack_fox.Entities.Story;
import fullstack_fox.Entities.UserStories;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface UserStoriesRepository extends CrudRepository<UserStories, Long> {
     @Query("SELECT us FROM UserStories us WHERE us.user.id = :userId")
    List<UserStories> findUserStoriesByUserId(Long userId);

    @Query("SELECT us FROM UserStories us WHERE us.user.id = :userId AND us.liked = false")
    List<UserStories> getAllUnlikedStories(Long userId);

    List<UserStories> findByUserId(Long userId);

    @Query("SELECT us FROM UserStories us WHERE us.user.id = :userId AND us.pageNumber != 0")
    List<UserStories> getCurrentlyReading(Long userId);

}

