package fullstack_fox.Repositories;

import fullstack_fox.Entities.Story;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface StoryRepository extends CrudRepository<Story, Long> {
    Optional<Story> findById(Long id);

    List<Story> findAll();
}