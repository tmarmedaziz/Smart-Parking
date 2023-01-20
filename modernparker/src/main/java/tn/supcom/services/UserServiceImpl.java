package tn.supcom.services;



import tn.supcom.exceptions.UserAlreadyExistsException;
import tn.supcom.exceptions.UserNotFoundException;
import tn.supcom.models.User;
import tn.supcom.repository.UserRepository;
import tn.supcom.util.Argon2Utility;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.util.List;
import java.util.stream.Stream;

@ApplicationScoped
public class UserServiceImpl  implements  UserService{

    @Inject
    private UserRepository userRepository;
    @Inject
    Argon2Utility argon2Utility ;




    /**
     *
     * @param user
     * @return User
     * @apiNote  THis methode  is used  to create Admin account
     */

    public User createUser(User user){
        if(userRepository.findById(user.getEmail()).isPresent()){
            throw  new UserAlreadyExistsException(user.getEmail()+" is already exists") ;
        }
        user.updatePassword(user.getPassword(),argon2Utility);
        return  userRepository.save(user) ;
    }



    public List<User> findall(){
        return userRepository.findAll();
    }

    /**
     *
     * @param user
     * @return User
     * @throws UserAlreadyExistsException
     * @apiNote  This methode is  used   when the admin add some users to maintain  racks
     */
    @Override
    public User addUser(User user)  {
         if(userRepository.findById(user.getEmail()).isPresent()){
             throw new UserAlreadyExistsException(user.getEmail() +" already exists") ;
         }
         user.updatePassword(user.getPassword(),argon2Utility);
         return userRepository.save(user) ;

    }

    /**
     *
     * @param email
     * @throws  UserNotFoundException
     * @apiNote this methode used by the admin to delete users
     */

    @Override
    public void delete(String email)  {
        if(!userRepository.findById(email).isPresent()){
            throw new UserNotFoundException("there is  no user with email :"+email) ;
        }
        userRepository.deleteById(email);

    }
}
