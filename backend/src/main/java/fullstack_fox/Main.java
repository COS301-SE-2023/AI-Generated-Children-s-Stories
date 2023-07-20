package fullstack_fox;

import fullstack_fox.Entities.Page;
import fullstack_fox.Entities.Story;
import fullstack_fox.Repositories.PageRepository;
import fullstack_fox.Repositories.StoryRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.io.IOException;

@SpringBootApplication
public class Main implements CommandLineRunner{

    @Autowired private PageRepository pageRepo;
    @Autowired private StoryRepository storyRepo;


    public static void main(String[] args) {
        SpringApplication.run(Main.class, args);
    }

    @Override
    public void run(String... args) throws Exception {
       // createStoryAndPage();
        FirebaseConfig firebaseConfig = new FirebaseConfig();
        //createStoryAndPage();
    }

    private void createStoryAndPage() {
        Story newStory = new Story("Andy the ant", "trailer");
        storyRepo.save(newStory);
        
        Page newPage = new Page("image", "text", newStory);
        pageRepo.save(newPage);
        newPage = new Page("image2", "text2", newStory);
        pageRepo.save(newPage);
        newPage = new Page("image3", "text3", newStory);
        pageRepo.save(newPage);
    }

}