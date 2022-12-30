package tn.supcom.boundaries;


import tn.supcom.exceptions.UserAlreadyExistsException;
import tn.supcom.filters.Secured;
import tn.supcom.models.Vehicle;
import tn.supcom.repository.VehicleRepository;
import tn.supcom.services.VehicleService;

import javax.annotation.security.RolesAllowed;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

@ApplicationScoped
@Path("/vehicle")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class VehicleResources {
    @Inject
    private VehicleRepository vehicleRepository;
    @Inject
    private VehicleService service;

    @GET
    @Secured
    @RolesAllowed("ADMIN")
    public List<Vehicle> listAll(){
        return vehicleRepository.findAll();
    }

    @POST
    @Secured
    @RolesAllowed("ADMIN")
    @Path("/{userid}")
    public Response addVehicle(@PathParam("userid") String userId, Vehicle vehicle){
        System.out.println("------------------------------");

        vehicle.setUserId(userId);

        System.out.println(vehicle.toString());
        System.out.println("******************");

        try {
            service.addVehicle(vehicle);
            return Response.ok(vehicle.toString()).build();
        } catch (UserAlreadyExistsException e){return Response.status(400, e.getMessage()).build();}
    }
}
