package tn.supcom.models;

import jakarta.nosql.mapping.Column;
import jakarta.nosql.mapping.Entity;
import jakarta.nosql.mapping.Id;

import java.io.Serializable;
import java.util.Objects;
import java.util.Set;

@Entity
public class Parking implements Serializable {
    @Id
    private Integer id;

    @Column
    private String parkingFees;

    @Column
    private String parkingDescription;

    @Column
    private String parkingType;

    @Column
    private Float longitude;

    @Column
    private Float lattitude;

    public Parking(Integer id, String parkingFees, String parkingDescription, String parkingType, Float longitude, Float lattitude) {
        this.id = id;
        this.parkingFees = parkingFees;
        this.parkingDescription = parkingDescription;
        this.parkingType = parkingType;
        this.longitude = longitude;
        this.lattitude = lattitude;
    }
    public Parking(){

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getParkingFees() {
        return parkingFees;
    }

    public void setParkingFees(String parkingFees) {
        this.parkingFees = parkingFees;
    }

    public String getParkingDescription() {
        return parkingDescription;
    }

    public void setParkingDescription(String parkingDescription) {
        this.parkingDescription = parkingDescription;
    }

    public String getParkingType() {
        return parkingType;
    }

    public void setParkingType(String parkingType) {
        this.parkingType = parkingType;
    }

    public Float getLongitude() {
        return longitude;
    }

    public void setLongitude(Float longitude) {
        this.longitude = longitude;
    }

    public Float getLattitude() {
        return lattitude;
    }

    public void setLattitude(Float lattitude) {
        this.lattitude = lattitude;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Parking)) return false;
        Parking parking = (Parking) o;
        return id.equals(parking.id) && parkingFees.equals(parking.parkingFees) && parkingDescription.equals(parking.parkingDescription) && parkingType.equals(parking.parkingType) && longitude.equals(parking.longitude) && lattitude.equals(parking.lattitude);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, parkingFees, parkingDescription, parkingType, longitude, lattitude);
    }

    @Override
    public String toString() {
        return "Parking{" +
                "id=" + id +
                ", parkingFees='" + parkingFees + '\'' +
                ", parkingDescription='" + parkingDescription + '\'' +
                ", parkingType='" + parkingType + '\'' +
                ", longitude=" + longitude +
                ", lattitude=" + lattitude +
                '}';
    }
}