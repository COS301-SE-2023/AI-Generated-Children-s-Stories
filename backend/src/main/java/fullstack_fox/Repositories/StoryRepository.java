package fullstack_fox.Repositories;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;

import fullstack_fox.Entities.Story;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StoryRepository extends CrudRepository<Story, Long> {

}