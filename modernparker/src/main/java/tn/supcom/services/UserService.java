package tn.supcom.services;


import tn.supcom.exceptions.UserAlreadyExistsException;
import tn.supcom.exceptions.UserNotFoundException;
import tn.supcom.models.User;

public interface UserService {

    User createUser(User user) throws UserAlreadyExistsException;
    User addUser(User user) throws  UserAlreadyExistsException  ;
    void delete(String email) throws UserNotFoundException;

}
