package tn.supcom.boundaries;

import tn.supcom.exceptions.UserAlreadyExistsException;
import tn.supcom.exceptions.UserNotFoundException;
import tn.supcom.filters.Secured;
import tn.supcom.models.Parking;
import tn.supcom.models.ParkingSlot;
import tn.supcom.models.SlotState;
import tn.supcom.repository.ParkingRepository;
import tn.supcom.repository.ParkingSlotRepository;

import javax.annotation.security.PermitAll;
import javax.annotation.security.RolesAllowed;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.Response;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;
import java.util.Optional;

@ApplicationScoped
@Path("parking")
public class ParkingRessource {

    @Inject
    private ParkingRepository parkingRepository;

    @Inject
    private ParkingSlotRepository parkingSlotRepository;

    /**
     * adding a new parking by only an ADMIN user
     * @param parking
     * @return parking class
     */
    @POST
    @Path("/parking")
    @Secured
    @RolesAllowed("ADMIN")
    public Response addNewParking(Parking parking){
        System.out.println("newparking");
        try {
            return Response.ok(parkingRepository.save(parking)).build() ;
        } catch (UserAlreadyExistsException e){
            return  Response.status(400, e.getMessage()).build();
        }
    }

    /**
     * adding a parking slot to a specefic paring
     * @param parkingId
     * @param parkingSlot
     * @return aprking slot informations
     */
    @POST
    @Path("/slot/{parkingid}")
    @Secured
    @RolesAllowed("ADMIN")
    public Response addParkingSlot(@PathParam("parkingid") Integer parkingId, ParkingSlot parkingSlot){

        Optional<Parking> parking = parkingRepository.findById(parkingId);
        if (!parking.isPresent()){
            System.out.println("----------------------parking not found----------------------");
            return  Response.status(400).build();
        }
        parkingSlot.setParkingId(parking.get().getId());
        try {
            parkingSlotRepository.save(parkingSlot);
            return Response.ok(parkingSlot.toString()).build();
        }catch (UserAlreadyExistsException e){return Response.status(400, e.getMessage()).build();}
    }

    /**
     * @return a list of all parkings present in the database
     */
    @GET
    @Path("/allparkings/")
    @Secured
    @PermitAll
    public Response listAllParkings(){
        List<Parking> parkings = parkingRepository.findAll();
        if (parkings.isEmpty()){
            System.out.println("no slots in this parking");
            return Response.ok("no no slots in this parking").build();
        }
        return Response.ok(parkings).build();
    }

    /**
     *
     * @param parkingId
     * @return all slots of a specefic parking by parking id
     */
    @GET
    @Path("/allslots/{parkingid}")
    @Secured
    @PermitAll
    public Response listAllParkingslots(@PathParam("parkingid") Integer parkingId){
        Optional<Parking> parking = parkingRepository.findById(parkingId);
        if (!parking.isPresent()){
            System.out.println("----------------------parking not found----------------------");
            return  Response.status(400).build();
        }
        List<ParkingSlot> parkingSlots = parkingSlotRepository.findByParkingId(parkingId);

        if(parkingSlots.isEmpty()){
            System.out.println("no slots in this parking");
            return Response.ok("no no slots in this parking").build();
        }
        return Response.ok(parkingSlots).build();
    }

    /**
     * delete a parking
     * @param parkingId
     * @return
     */
    @DELETE
    @Path("/parking/{parkingid}")
    @Secured
    @RolesAllowed("ADMIN")
    public Response deleteParking(@PathParam("parkingid") Integer parkingId){
        try {
            if (!parkingRepository.findById(parkingId).isPresent()){
                throw new UserNotFoundException("there is  no parking with id :"+parkingId) ;
            }
            else {
                parkingRepository.deleteById(parkingId);
                return Response.ok().build();
            }
        } catch(UserNotFoundException e){
            return  Response.status(400 , e.getMessage()).build() ;
        }
    }

    /**
     * delete a slot by parking
     * @param parkingslotId
     * @return
     */
    @DELETE
    @Path("/slot/{slotid}")
    @Secured
    @RolesAllowed("ADMIN")
    public Response deleteParkingSlot(@PathParam("slotid") Integer parkingslotId){
        try {
            if (!parkingSlotRepository.findById(parkingslotId).isPresent()){
                throw new UserNotFoundException("there is  no parking slot with id :"+parkingslotId) ;
            }
            else {
                parkingSlotRepository.deleteById(parkingslotId);
                return Response.ok().build();
            }
        } catch(UserNotFoundException e){
            return  Response.status(400 , e.getMessage()).build() ;
        }
    }

    /**
     *
     * @param parkingId
     * @return all empty slots of a parking
     */
    @GET
    @Path("/allemptyslots/{parkingid}")
    public Response listEmptySlots(@PathParam("parkingid") Integer parkingId){
        Optional<Parking> parking = parkingRepository.findById(parkingId);
        if (!parking.isPresent()){
            System.out.println("----------------------parking not found----------------------");
            return  Response.status(400).build();
        }
        List<ParkingSlot> parkingSlots = parkingSlotRepository.findByParkingId(parkingId);
        Dictionary dictionary = new Hashtable();
        for(ParkingSlot slot: parkingSlots){
            if (slot.getState().equals(SlotState.EMPTY)){
            dictionary.put(slot.getId(), slot.getState());}
        }
        return Response.ok(dictionary).build();
    }

}
