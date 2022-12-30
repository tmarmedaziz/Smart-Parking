package tn.supcom.services;

import tn.supcom.exceptions.UserAlreadyExistsException;
import tn.supcom.models.Vehicle;
import tn.supcom.repository.VehicleRepository;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;

@ApplicationScoped
public class VehicleService {

    @Inject
    private VehicleRepository vehicleRepository;

    public Vehicle addVehicle(Vehicle vehicle){
        if (vehicleRepository.findByVehicleNumber(vehicle.getVehicleNumber()).isPresent()){
            throw  new UserAlreadyExistsException(vehicle.getVehicleNumber()+" already exists") ;
        }
        return vehicleRepository.save(vehicle);
    }
}
