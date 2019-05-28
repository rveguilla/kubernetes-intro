package example.app

import com.fasterxml.jackson.annotation.JsonProperty

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Id
import javax.persistence.Table
import javax.validation.constraints.NotNull

@Entity
@Table(name = "app_table")
@SuppressWarnings("unused")
class Row {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @JsonProperty("id")
    Integer id

    @NotNull
    @Column(name = "app_column", nullable = false)
    @JsonProperty("app_column")
    String appColumn

}