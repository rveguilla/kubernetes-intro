package example.app

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface RowRepository extends JpaRepository<Row, Integer> {

    List<Row> findAll();
}


