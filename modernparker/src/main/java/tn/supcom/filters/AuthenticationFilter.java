package tn.supcom.filters;




import tn.supcom.repository.UserTokenRepository;
import tn.supcom.security.AccessToken;
import tn.supcom.security.UserJWT;

import javax.annotation.Priority;
import javax.inject.Inject;
import javax.security.enterprise.AuthenticationStatus;
import javax.security.enterprise.authentication.mechanism.http.HttpAuthenticationMechanism;
import javax.security.enterprise.authentication.mechanism.http.HttpMessageContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Priorities;
import javax.ws.rs.ext.Provider;
import java.util.List;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;





@Provider
@Priority(Priorities.AUTHENTICATION)
@Secured
public class AuthenticationFilter implements HttpAuthenticationMechanism {
    private static final Pattern CHALLENGE_PATTERN = Pattern.compile("^Bearer *([^ ]+) *$", Pattern.CASE_INSENSITIVE);
    private  static  final  List NOT_SECURED_PREFIX=List.of("oauth2","signup") ;

    @Inject
    private UserTokenRepository repository;

    @Override
    public AuthenticationStatus validateRequest(HttpServletRequest request, HttpServletResponse response,
                                                HttpMessageContext httpMessageContext) {

        System.out.println(request.getRequestURI());
        if(!(request.getRequestURI().contains("oauth2") || request.getRequestURI().contains("signup"))  ) {
            final String authorization = request.getHeader("Authorization");

            System.out.println("ta3ada  rahow");
            Matcher matcher = CHALLENGE_PATTERN.matcher(Optional.ofNullable(authorization).orElse(""));
            if (!matcher.matches()) {
               System.out.println(matcher);
                return httpMessageContext.responseUnauthorized();
            }
            final String token = matcher.group(1);
            System.out.println(token);
            final Optional<AccessToken> optional = repository.findByAccessToken(token)
                    .flatMap(u -> u.findAccessToken(token));
            System.out.println(repository.findByAccessToken(token).flatMap(u -> u.findAccessToken(token)));


            if (!optional.isPresent()) {
                System.out.println("-----------------------is not present-----------------");
                return httpMessageContext.responseUnauthorized();
            }
            System.out.println("-----------------------ispresent-----------------");

            final AccessToken accessToken = optional.get();
            System.out.println("---------------------------------------------------------------------");
            System.out.println(accessToken.getJwtSecret());
            final Optional<UserJWT> optionalUserJWT = UserJWT.parse(accessToken.getToken(), accessToken.getJwtSecret());

            if (optionalUserJWT.isPresent()) {
                final UserJWT userJWT = optionalUserJWT.get();
                System.out.println(userJWT.getRoles());
                System.out.println(userJWT.getUser());

                return httpMessageContext.notifyContainerAboutLogin(userJWT.getUser(), userJWT.getRoles());
            } else {
                return httpMessageContext.responseUnauthorized();
            }

        }else {
            return  httpMessageContext.doNothing() ;
        }
    }

}