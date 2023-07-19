package fullstack_fox.Repositories;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;

import fullstack_fox.Entities.Story;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class StoryRepository {

    @Autowired private EntityManager entityManager;

    @Transactional
    public void save(Story story) {
        entityManager.persist(story);
    }

    public Story findById(Long id) {
        return entityManager.find(Story.class, id);
    }
}