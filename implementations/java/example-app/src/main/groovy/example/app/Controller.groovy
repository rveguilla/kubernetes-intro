package example.app

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class Controller {

    @Autowired
    private RowRepository rowRepository

    @GetMapping()
    Response getRows() {
        return new Response(rowRepository.findAll())
    }
}

