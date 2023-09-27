package fullstack_fox.Repositories;

import fullstack_fox.Entities.Page;
import fullstack_fox.Entities.Progress;
import fullstack_fox.Entities.Story;
import fullstack_fox.Entities.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PageRepository extends CrudRepository<Page, Long> {

    Optional<List<Page>> findPagesByStoryId(Long storyId);
}