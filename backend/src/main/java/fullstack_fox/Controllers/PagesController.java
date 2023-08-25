package fullstack_fox.Controllers;

import fullstack_fox.DTOs.PagesDTO;
import fullstack_fox.Entities.Page;
import fullstack_fox.Repositories.PageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@RestController
public class PagesController {

    @Autowired
    PageRepository pageRepository;
    @GetMapping("/pages/{storyId}")
    public List<PagesDTO> getPages(@PathVariable Long storyId) {
        Optional<List<Page>> optionalProgress = pageRepository.findPagesByStoryId(storyId);
        List<PagesDTO> pageDTOS = optionalProgress.stream()
                .flatMap(List::stream)
                .map(this::convertToPagesDTO)
                .collect(Collectors.toList());
        return pageDTOS;
    }

    public PagesDTO convertToPagesDTO(Page page) {
        return new PagesDTO(page);
    }
}
