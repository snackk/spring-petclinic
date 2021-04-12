/*
 * Copyright 2012-2019 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.springframework.samples.petclinic.visit;

import com.frontier.api.annotation.processor.annotation.provider.FrontierProperties;
import com.frontier.api.annotation.processor.annotation.provider.FrontierProviderRepository;
import java.util.List;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

/**
 * Repository class for <code>Visit</code> domain objects All method names are compliant with Spring
 * Data naming conventions so this interface can easily be extended for Spring Data. See:
 * https://docs.spring.io/spring-data/jpa/docs/current/reference/html/#repositories.query-methods.query-creation
 *
 * @author Ken Krebs
 * @author Juergen Hoeller
 * @author Sam Brannen
 * @author Michael Isvy
 */
@FrontierProviderRepository
public interface VisitRepository extends CrudRepository<Visit, Integer> {

	@FrontierProperties(guarantee = "synchronous")
	List<Visit> findByPetId(Integer petId);

	@FrontierProperties(guarantee = "asynchronous")
	@FrontierCompensate
	@Modifying
	@Query(value =
		"UPDATE visits v set v.description = :desc where v.pet_id = :id", nativeQuery = true)
	void updateVisit(@Param(value = "desc") String description, @Param(value = "id") Integer petId);

}
