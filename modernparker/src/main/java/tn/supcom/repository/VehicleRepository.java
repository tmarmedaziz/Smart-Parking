package tn.supcom.repository;

import jakarta.nosql.mapping.Repository;
import tn.supcom.models.Vehicle;

import java.util.List;
import java.util.Optional;

public interface VehicleRepository extends Repository<Vehicle, Integer> {
    Optional<Vehicle> findByVehicleNumber(String vehicleNumber);
    List<Vehicle> findByUserId(String userId);
    List<Vehicle> findAll();
}
