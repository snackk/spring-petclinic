package org.springframework.samples.petclinic.vet;

import com.frontier.api.annotation.processor.annotation.consumer.FrontierConsumerRepository;
import java.util.List;
import org.springframework.samples.petclinic.visit.Visit;
import org.springframework.stereotype.Service;

@Service(value = "anotherVisitService")
public class VisitRepository {

	@FrontierConsumerRepository(guarantee = "synchronous")
	public List<Visit> findByPetId(Integer petId) {
		return null;
	}

	@FrontierConsumerRepository(guarantee = "asynchronous")
	public Void updateVisit(String description, Integer petId) {
		return null;
	}
}
