package fullstack_fox.Repositories;

import fullstack_fox.Entities.Liked;
import fullstack_fox.Entities.Story;
import fullstack_fox.Entities.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface LikedRepository extends CrudRepository<Liked, Long> {
    boolean existsByUserAndStory(User user, Story story);

    Optional<Liked> findByUserAndStory(User user, Story story);

    List<Liked> findByUser_Id(Long id);
}