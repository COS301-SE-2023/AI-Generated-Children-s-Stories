package fullstack_fox;

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

//to use docker
//build:  docker build -t fullstack_fox/backend .
//run: docker run -p 8080:8080 fullstack_fox/backend

@SpringBootApplication
public class BackendApplication {

	public static void main(String[] args) {
		SpringApplication.run(BackendApplication.class, args);
	}

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
