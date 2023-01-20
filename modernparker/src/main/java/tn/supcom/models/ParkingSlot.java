package tn.supcom.models;

import jakarta.nosql.mapping.Column;
import jakarta.nosql.mapping.Entity;
import jakarta.nosql.mapping.Id;

import java.io.Serializable;
import java.util.Objects;

@Entity
public class ParkingSlot implements Serializable {
    @Id
    private Integer id;

    @Column
    private String slotDescription;

    @Column
    private SensorState sensorState;

    @Column
    private SlotState state;

    @Column
    private Integer parkingId;

    public ParkingSlot(){}

    public ParkingSlot(Integer id, String slotDescription, SensorState sensorState, SlotState state, Integer parkingId) {
        this.id = id;
        this.slotDescription = slotDescription;
        this.sensorState = sensorState;
        this.state = state;
        this.parkingId = parkingId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSlotDescription() {
        return slotDescription;
    }

    public void setSlotDescription(String slotDescription) {
        this.slotDescription = slotDescription;
    }

    public SensorState getSensorState() {
        return sensorState;
    }

    public void setSensorState(SensorState sensorState) {
        this.sensorState = sensorState;
    }

    public SlotState getState() {
        return state;
    }

    public void setState(SlotState state) {
        this.state = state;
    }

    public Integer getParkingId() {
        return parkingId;
    }

    public void setParkingId(Integer parkingId) {
        this.parkingId = parkingId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof ParkingSlot)) return false;
        ParkingSlot that = (ParkingSlot) o;
        return id.equals(that.id) && slotDescription.equals(that.slotDescription) && sensorState == that.sensorState && state == that.state && parkingId.equals(that.parkingId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, slotDescription, sensorState, state, parkingId);
    }

    @Override
    public String toString() {
        return "ParkingSlot{" +
                "id=" + id +
                ", slotDescription='" + slotDescription + '\'' +
                ", sensorState=" + sensorState +
                ", state=" + state +
                ", parkingId=" + parkingId +
                '}';
    }
}
