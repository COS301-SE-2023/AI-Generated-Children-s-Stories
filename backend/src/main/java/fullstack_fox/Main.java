package fullstack_fox;

import fullstack_fox.Entities.Page;
import fullstack_fox.Entities.Story;
import fullstack_fox.Entities.User;
import fullstack_fox.Repositories.PageRepository;
import fullstack_fox.Repositories.StoryRepository;

import fullstack_fox.Repositories.UserRepository;
import fullstack_fox.services.StoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.io.IOException;

@SpringBootApplication
public class Main implements CommandLineRunner{

    @Autowired private PageRepository pageRepo;
    @Autowired private StoryRepository storyRepo;

    @Autowired private UserRepository userRepository;

    public static void main(String[] args) {
        SpringApplication.run(Main.class, args);
    }

    @Override
    public void run(String... args) throws Exception {
        FirebaseConfig firebaseConfig = new FirebaseConfig();
        //createStoryAndPage();
        //createUser();


    }

    private void createStoryAndPage() {
        Story newStory = new Story("Benny the bear", "trailer 2");
        storyRepo.save(newStory);
        
        Page newPage = new Page("benny", "text", newStory);
        pageRepo.save(newPage);
        newPage = new Page("benny", "text2", newStory);
        pageRepo.save(newPage);
        newPage = new Page("benny", "text3", newStory);
        pageRepo.save(newPage);
    }

    private void createUser() {
        User user = new User("12");
        userRepository.save(user);
    }

}