package tn.supcom.models;

import jakarta.nosql.mapping.Column;
import jakarta.nosql.mapping.Entity;
import jakarta.nosql.mapping.Id;

import java.io.Serializable;
import java.util.Date;
import java.util.Objects;

@Entity
public class Reservation implements Serializable {
    @Id
    private Integer id;

    @Column
    private Date reservation;

    @Column
    private String userId;

    @Column
    private String vehicleId;
    @Column
    private Integer parkingId;

    @Column
    private Integer slotId;

    public Reservation(Integer id, Date reservation, String userId, String vehicleId, Integer parkingId, Integer slotId) {
        this.id = id;
        this.reservation = reservation;
        this.userId = userId;
        this.vehicleId = vehicleId;
        this.parkingId = parkingId;
        this.slotId = slotId;
    }
    public Reservation(){}

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getReservation() {
        return reservation;
    }

    public void setReservation(Date reservation) {
        this.reservation = reservation;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(String vehicleId) {
        this.vehicleId = vehicleId;
    }

    public Integer getParkingId() {
        return parkingId;
    }

    public void setParkingId(Integer parkingId) {
        this.parkingId = parkingId;
    }

    public Integer getSlotId() {
        return slotId;
    }

    public void setSlotId(Integer slotId) {
        this.slotId = slotId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Reservation)) return false;
        Reservation that = (Reservation) o;
        return id.equals(that.id) && reservation.equals(that.reservation) && userId.equals(that.userId) && vehicleId.equals(that.vehicleId) && parkingId.equals(that.parkingId) && slotId.equals(that.slotId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, reservation, userId, vehicleId, parkingId, slotId);
    }

    @Override
    public String toString() {
        return "Reservation{" +
                "id=" + id +
                ", reservation=" + reservation +
                ", userId='" + userId + '\'' +
                ", vehicleId='" + vehicleId + '\'' +
                ", parkingId=" + parkingId +
                ", slotId=" + slotId +
                '}';
    }
}
