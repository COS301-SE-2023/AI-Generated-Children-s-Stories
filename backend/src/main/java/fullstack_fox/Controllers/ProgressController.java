package fullstack_fox.Controllers;

import fullstack_fox.Repositories.ProgressRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ProgressController {
    @Autowired
    ProgressRepository progressRepository;
}
