package fullstack_fox.Repositories;

import fullstack_fox.Entities.Progress;
import fullstack_fox.Entities.Story;
import fullstack_fox.Entities.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ProgressRepository extends CrudRepository<Progress, Long> {
    Progress findByUser_IdAndStory_Id(Long userId, Long storyId);

    Optional<Progress> findByUserAndStory(User user, Story story);

    Optional<List<Progress>> findProgressByUserId(Long userId);
}
