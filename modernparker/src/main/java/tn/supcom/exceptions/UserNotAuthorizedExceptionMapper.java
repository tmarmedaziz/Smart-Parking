package tn.supcom.exceptions;


import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

@Provider
public class UserNotAuthorizedExceptionMapper implements ExceptionMapper<UserNotAuthorizedException> {



    @Override
    public Response toResponse(UserNotAuthorizedException e) {
        return Response.status(Response.Status.UNAUTHORIZED).build();
    }
}