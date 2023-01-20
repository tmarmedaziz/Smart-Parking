package tn.supcom.repository;

import jakarta.nosql.mapping.Repository;
import tn.supcom.models.Parking;

import java.util.List;
import java.util.Optional;

public interface ParkingRepository extends Repository<Parking, Integer> {

    Optional <Parking> findById(Integer id);


    List<Parking> findAll();
}
