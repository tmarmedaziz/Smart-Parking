package tn.supcom.security;


import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.Claim;
import org.eclipse.microprofile.config.Config;
import org.eclipse.microprofile.config.ConfigProvider;
import tn.supcom.models.User;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

public class UserJWT {

    private static final Logger LOGGER = Logger.getLogger(UserJWT.class.getName());

    private static final Config config = ConfigProvider.getConfig();
    private static final String ISSUER = config.getValue("jwt.issuer",String.class);

    private static final String ROLES = config.getValue("jwt.claim.roles",String.class);

    private final String user;

    private final Set<String> roles;

    UserJWT(String user, Set<String> roles) {
        this.user = user;
        this.roles = roles;
    }

    public String getUser() {
        return user;
    }

    public Set<String> getRoles() {
        if (roles == null) {
            return Collections.emptySet();
        }
        return roles;
    }

    static String createToken(User user, Token token, Duration duration) {
        final LocalDateTime expire = LocalDateTime.now(ZoneOffset.UTC).plusMinutes(duration.toMinutes());
        Algorithm algorithm = Algorithm.HMAC256(token.get());
         List roles =new ArrayList<>() ;
         user.getRoles().forEach(role -> {
             roles.add(role.toString());
         });

        return JWT.create()
                .withJWTId(user.getEmail())
                .withIssuer(ISSUER)
                .withExpiresAt(Date.from(expire.atZone(ZoneOffset.UTC).toInstant()))
                .withClaim(ROLES, roles)
                .sign(algorithm);

    }

    public static Optional<UserJWT> parse(String jwtText, String token) {
        Algorithm algorithm = Algorithm.HMAC256(token);

        try {

            JWTVerifier verifier = JWT.require(algorithm).withIssuer(ISSUER).build();
            var jwt =JWT.decode(token);
            final Claim roles = jwt.getClaim(ROLES);
            return Optional.of(new UserJWT(jwt.getId(),
                    roles.asList(String.class).stream().collect(Collectors.toUnmodifiableSet())));
        } catch (JWTVerificationException exp) {
            LOGGER.log(Level.WARNING, "There is an error to load the JWT token", exp);
            return Optional.empty();
        }
    }


}