package tn.supcom.security;



import tn.supcom.exceptions.UserAlreadyExistsException;
import tn.supcom.exceptions.UserForbiddenException;
import tn.supcom.exceptions.UserNotAuthorizedException;
import tn.supcom.exceptions.UserNotFoundException;
import tn.supcom.models.Role;
import tn.supcom.models.User;
import tn.supcom.repository.UserRepository;
import tn.supcom.util.Argon2Utility;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.security.enterprise.SecurityContext;
import java.security.Principal;
import java.util.List;
import java.util.Set;

@ApplicationScoped
public class SecurityService {

    @Inject
    private UserRepository userRepository;

    @Inject
    private Argon2Utility argon2Utility ;

    @Inject
    private SecurityContext securityContext;

     public void create(User user) {
        if (userRepository.findByEmail(user.getEmail()).isPresent()) {
            throw new UserAlreadyExistsException("There is user with email  " + user.getEmail());
        } else {
            // we must hash the  password  before saving it
            user.updatePassword(user.getPassword(), argon2Utility);
            userRepository.save(user);
        }
    }


     public    void delete(String email ) {
            userRepository.deleteById(email);

        }



   public void updatePassword(String email, User dto) {
        final Principal principal = securityContext.getCallerPrincipal();
        if (isForbidden(email, securityContext, principal)) {
            throw new UserForbiddenException();
        }
        final User user = userRepository.findById(email)
                .orElseThrow(() -> new UserNotFoundException(email));
        user.updatePassword(dto.getPassword(), argon2Utility);
        userRepository.save(user);

    }

    /**
     * @apiNote  used to roles  to user
     * @param email  : user  email
     * @param role : role to  add
     *
     */
    public void addRole(String email, Role role
    ) {

        final User user = userRepository.findById(email)
                .orElseThrow(() -> new UserNotFoundException(email));

        Set<Role> roles=user.getRoles() ;
        roles.add(role) ;
        user.setRoles(roles);
        userRepository.save(user);
    }


    /**
     * @apiNote  used to delete  roles to user
     * @param email
     * @param role
     */

    public void removeRole(String  email , Role role) {
        final User user = userRepository.findById(email)

                .orElseThrow(() -> new UserNotFoundException(email));

        Set<Role> roles=user.getRoles() ;
        roles.remove(role) ;
        user.setRoles(roles);
        userRepository.save(user);

    }

    public User getUser() {
        final Principal principal = securityContext.getCallerPrincipal();
        if (principal == null) {
            throw new UserNotAuthorizedException();
        }
        final User user = userRepository.findById(principal.getName())
                .orElseThrow(() -> new UserNotFoundException(principal.getName()));
        return user;
    }

    public List<User> getUsers() {
        return userRepository.findAll() ;

    }

    /**
     *
     * @param email
     * @param context
     * @param principal
     * @return
     */

    private boolean isForbidden(String  email, SecurityContext context, Principal principal) {
        return !(context.isCallerInRole(Role.ADMIN.name()));

    }


    public User findBy(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new UserNotAuthorizedException());
    }




    public User findBy(String email, String password) {
        System.out.println("------------------------------------------------");
        System.out.println(userRepository.findById(email).toString());
        final User user = userRepository.findById(email)
                .orElseThrow(() -> new UserNotAuthorizedException());
        System.out.println(argon2Utility.check(user.getPassword() ,password.toCharArray()));
        if (argon2Utility.check(user.getPassword() ,password.toCharArray() )) {

            return user;
        }
        throw new UserNotAuthorizedException();

    }
}
