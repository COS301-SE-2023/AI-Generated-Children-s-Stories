package fullstack_fox.Repositories;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;

import fullstack_fox.Entities.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PageRepository {

    @Autowired private EntityManager entityManager;

    @Transactional
    public void save(Page page) {
        entityManager.persist(page);
    }

    public Page findById(int id) {
        return entityManager.find(Page.class, id);
    }
}