package fullstack_fox.Repositories;

import fullstack_fox.Entities.Story;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

@Repository
public interface StoryRepository extends CrudRepository<Story, Long> {
    Optional<Story> findById(Long id);

    List<Story> findAll();

    @Query("SELECT s FROM Story s WHERE s.id NOT IN (SELECT u.storyId FROM UserStoryInfoDTO u WHERE u.userId = :userId)")
    List<Story> findWhereNotReading(Long userId);

}