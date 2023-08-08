package fullstack_fox;

import fullstack_fox.Entities.Page;
import fullstack_fox.Entities.Story;
import fullstack_fox.Entities.User;
import fullstack_fox.Repositories.PageRepository;
import fullstack_fox.Repositories.StoryRepository;
import fullstack_fox.Repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

//to run:
/*
1. mvn clean package
2. cd target
2. java -jar .\target\backend-1.0-SNAPSHOT.jar
*/

//to compile into jar:
//mvn package
//run the jar file: java -jar demo-0.0.1-SNAPSHOT.jar

@SpringBootApplication
public class DemoApplication implements CommandLineRunner{

	@Autowired private PageRepository pageRepo;
	@Autowired private StoryRepository storyRepo;

	@Autowired private UserRepository userRepository;

	public static void main(String[] args) {
		SpringApplication.run(fullstack_fox.DemoApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		FirebaseConfig firebaseConfig = new FirebaseConfig();
//        createStoryAndPage();
//        createUser();
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

//-- Drop the view if it already exists (optional, to handle changes in the view definition)
//    DROP VIEW IF EXISTS user_story_info;
//-- Create the view
//    CREATE OR REPLACE VIEW user_story_info AS
//    SELECT
//    ROW_NUMBER() OVER () AS auto_id,
//    u.id AS user_id,
//    s.id AS story_id,
//    s.title,
//    s.trailer,
//            (CASE WHEN l.story_id IS NOT NULL THEN true ELSE false END) AS liked,
//    (CASE WHEN pr.page_number IS NOT NULL THEN pr.page_number ELSE 0 END) AS page_no
//    FROM
//    Story s
//    CROSS JOIN User u
//    LEFT JOIN Liked l ON s.id = l.story_id AND u.id = l.user_id
//    LEFT JOIN Progress pr ON s.id = pr.story_id AND u.id = pr.user_id;
}