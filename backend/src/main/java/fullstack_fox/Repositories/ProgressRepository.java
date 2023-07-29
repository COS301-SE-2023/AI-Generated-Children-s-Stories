package fullstack_fox.Repositories;

import fullstack_fox.Entities.Progress;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProgressRepository extends CrudRepository<Progress, Long> {

    Progress findByUserIdAndStoryId(Long userId, Long storyId);
}
