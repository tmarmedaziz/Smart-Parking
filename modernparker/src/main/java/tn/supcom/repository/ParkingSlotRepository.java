package tn.supcom.repository;

import jakarta.nosql.mapping.Repository;
import tn.supcom.models.ParkingSlot;

import java.util.List;
import java.util.Optional;

public interface ParkingSlotRepository extends Repository<ParkingSlot, Integer> {

    Optional<ParkingSlot> findById(Integer id);

    List<ParkingSlot> findByParkingId(Integer parkingId);

    List<ParkingSlot> findAll();
}
