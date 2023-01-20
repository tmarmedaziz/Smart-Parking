package tn.supcom.boundaries;

import tn.supcom.exceptions.UserAlreadyExistsException;
import tn.supcom.exceptions.UserNotFoundException;
import tn.supcom.filters.Secured;
import tn.supcom.models.Parking;
import tn.supcom.models.Reservation;
import tn.supcom.models.User;
import tn.supcom.models.Vehicle;
import tn.supcom.repository.ParkingRepository;
import tn.supcom.repository.ReservationRepository;
import tn.supcom.repository.UserRepository;
import tn.supcom.repository.VehicleRepository;

import javax.annotation.security.RolesAllowed;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.Response;
import java.util.List;
import java.util.Optional;

@ApplicationScoped
@Path("/reservation")
public class ReservationResources {
    @Inject
    private ReservationRepository reservationRepository;

    @Inject
    private VehicleRepository vehicleRepository;

    @Inject
    private UserRepository userRepository;

    @Inject
    private ParkingRepository parkingRepository;

    /**
     * adding a new reservation to the Reservation table
     * @param userId
     * @param parkingId
     * @param slotId
     * @param reservation
     * @return reservation informations
     */
    @POST
    @Path("add/{user_id}/{parking_id}/{slot_id}")
    @Secured
    @RolesAllowed({"CLIENT", "ADMIN"})

    public Response addNewReservation(@PathParam("user_id") String userId, @PathParam("parking_id") Integer parkingId, @PathParam("slot_id") Integer slotId, Reservation reservation){
        try {
            List<Vehicle> vehicle = vehicleRepository.findByUserId(userId);
            if (vehicle.isEmpty()){return Response.status(400).build();}
            Optional<User> user = userRepository.findByEmail(userId);
            if (!user.isPresent()){return Response.status(400).build();}
            reservation.setParkingId(parkingId);
            reservation.setUserId(user.get().getEmail());
            reservation.setVehicleId(vehicle.get(0).getVehicleNumber());
            reservation.setSlotId(slotId);
            try {
                reservationRepository.save(reservation);
                return Response.ok(reservation.toString()).build();
            } catch (UserAlreadyExistsException e) {
                return Response.status(400, e.getMessage()).build();
            }
        }catch (UserNotFoundException e) {
            return Response.status(400, e.getMessage()).build();
        }
    }

    /**
     * search the reservations by parking id
     * @param parking_id
     * @return reservations
     */
    @GET
    @Path("parking/{parking_id}")
    @Secured
    public Response parkingReservation(@PathParam("parking_id") Integer parking_id){
        try {
            Optional<Parking> parking = parkingRepository.findById(parking_id);
            if (parking.isPresent()){
                List<Reservation> reservations = reservationRepository.findByParkingId(parking.get().getId());
                return Response.ok(reservations).build();
            }else {System.out.println("parking id invalid");
                    return Response.status(400).build();}
        } catch (UserNotFoundException e){return Response.status(400, e.getMessage()).build();}
    }

    /**
     * @return all the reservations present in the database
     */

    @GET
    @Path("/")
    @Secured
    @RolesAllowed("ADMIN")
    public Response allReservations(){
        return Response.ok(reservationRepository.findAll()).build();
    }

    /**
     *
     * @param userId
     * @return all the reservations of a user
     */
    @GET
    @Path("user/{user_id}")
    @Secured
    public Response userReservations(@PathParam("user_id") String userId){
        try {
            Optional<User> user = userRepository.findByEmail(userId);
            if (!user.isPresent()){return Response.status(400).build();}
            List<Reservation> userReservations = reservationRepository.findByUserId(user.get().getEmail());
            return Response.ok(userReservations).build();
        }catch (UserAlreadyExistsException e){
            return  Response.status(400, e.getMessage()).build();
        }

    }


}
