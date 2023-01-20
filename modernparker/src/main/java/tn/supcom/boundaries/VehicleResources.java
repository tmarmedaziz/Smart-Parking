package tn.supcom.boundaries;


import tn.supcom.exceptions.UserAlreadyExistsException;
import tn.supcom.filters.Secured;
import tn.supcom.models.User;
import tn.supcom.models.Vehicle;
import tn.supcom.repository.UserRepository;
import tn.supcom.repository.VehicleRepository;
import tn.supcom.services.VehicleService;

import javax.annotation.security.RolesAllowed;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;
import java.util.Optional;

@ApplicationScoped
@Path("/vehicle")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class VehicleResources {
    @Inject
    private VehicleRepository vehicleRepository;
    @Inject
    private VehicleService service;

    @Inject
    private UserRepository userRepository;

    /**
     * @return all the vehicles present in the database
     */
    @GET
    @Secured
    @RolesAllowed("ADMIN")
    public List<Vehicle> listAll(){
        return vehicleRepository.findAll();
    }

    /**
     * @param userId
     * @param vehicle
     * @return add a new vehicle by checking if the user is present
     */
    @POST
    @Secured
    @Path("/{userid}")
    public Response addVehicle(@PathParam("userid") String userId, Vehicle vehicle){

//        try {
        User user = userRepository.findByEmail(userId).get();
        System.out.println(user.toString());
        vehicle.setUserId(user.getEmail());
        vehicleRepository.save(vehicle);
        return Response.ok(vehicle.toString()).build();
//        } catch (UserAlreadyExistsException e){return Response.status(400, e.getMessage()).build();}
    }

    /**
     * @param userId
     * @return the vehicles attached to a user
     */
    @GET
    @Secured
    @Path("/getbyuser/{userId}")
    public Response getByUserId(@PathParam("userId") String userId){
        try {
        List<Vehicle> vehicle = vehicleRepository.findByUserId(userId);
        return Response.ok(vehicle).build();
        }catch (UserAlreadyExistsException e) {
            return Response.status(400, "nooo no").build();
        }
    }
}
