package fullstack_fox.Repositories;

import fullstack_fox.Entities.Liked;
import fullstack_fox.Entities.Story;
import fullstack_fox.Entities.User;
import jdk.dynalink.linker.LinkerServices;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LikedRepository extends CrudRepository<Liked, Long> {
    boolean existsByUserAndStory(User user, Story story);

    Liked findByUserAndStory(User user, Story story);

    List<Liked> findByUser_Id(Long id);


}