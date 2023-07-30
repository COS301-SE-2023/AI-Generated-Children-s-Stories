package fullstack_fox.Repositories;

import fullstack_fox.Entities.Liked;
import fullstack_fox.Entities.Story;
import fullstack_fox.Entities.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LikedRepository extends CrudRepository<Liked, Long> {
    boolean existsByUserAndStory(User user, Story story);

    Liked findByUserAndStory(User user, Story story);
}