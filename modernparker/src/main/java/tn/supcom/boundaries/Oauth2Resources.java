package tn.supcom.boundaries;


import tn.supcom.security.Oauth2Request;
import tn.supcom.security.Oauth2Response;
import tn.supcom.security.Oauth2Service;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.validation.Valid;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;


@ApplicationScoped
@Path("oauth2")
public class Oauth2Resources {

    @Inject
    private Oauth2Service service;

    /**
     *
     * @param request
     * @return token and refresh token for the authorization
     */
    @POST
    @Path("token")
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    @Produces(MediaType.APPLICATION_JSON)

    public Oauth2Response token(@BeanParam @Valid Oauth2Request request) {
        switch (request.getGrandType()) {

            case PASSWORD:
                return service.token(request);
            case REFRESH_TOKEN:
                return service.refreshToken(request);
            default:
                throw new UnsupportedOperationException("There is not support to another type");
        }
    }
}