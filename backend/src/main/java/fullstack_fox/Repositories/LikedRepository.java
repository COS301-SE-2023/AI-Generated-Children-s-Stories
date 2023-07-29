package fullstack_fox.Repositories;

import fullstack_fox.Entities.Progress;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LikedRepository extends CrudRepository<Progress, Long> {

}