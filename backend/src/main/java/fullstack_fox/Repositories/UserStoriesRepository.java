package fullstack_fox.Repositories;

import fullstack_fox.Entities.UserStories;
import org.springframework.data.repository.CrudRepository;

public interface UserStoriesRepository extends CrudRepository<UserStories, Long> {

}
