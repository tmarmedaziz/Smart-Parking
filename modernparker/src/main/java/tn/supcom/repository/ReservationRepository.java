package tn.supcom.repository;

import jakarta.nosql.mapping.Repository;
import tn.supcom.models.Reservation;

import java.util.List;
import java.util.Optional;

public interface ReservationRepository extends Repository<Reservation, Integer> {
    Optional<Reservation> findById(Integer id);
    List<Reservation> findAll();
    List<Reservation> findByUserId(String userId);
    List<Reservation> findByParkingId(Integer parkingId);
    List<Reservation> findByVehicleId(String vehicleId);

}
