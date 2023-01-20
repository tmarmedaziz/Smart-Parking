package tn.supcom.repository;


import jakarta.nosql.mapping.Repository;
import tn.supcom.models.User;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends Repository<User ,String> {

    Optional<User> findByEmail(String email ) ;
    List<User> findAll() ;

}
