package tn.supcom.models;

import jakarta.nosql.mapping.Column;
import jakarta.nosql.mapping.Entity;
import jakarta.nosql.mapping.Id;

import java.util.Objects;

@Entity
class ParkingSlot{
    @Id
    private Integer id;

    @Column
    private String slotDescription;

    @Column
    private String state;

    public ParkingSlot(Integer id, String slotDescription, String state) {
        this.id = id;
        this.slotDescription = slotDescription;
        this.state = state;
    }

    public ParkingSlot(){}

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

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof ParkingSlot)) return false;
        ParkingSlot that = (ParkingSlot) o;
        return id.equals(that.id) && slotDescription.equals(that.slotDescription) && state.equals(that.state);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, slotDescription, state);
    }

    @Override
    public String toString() {
        return "ParkingSlot{" +
                "id=" + id +
                ", slotDescription='" + slotDescription + '\'' +
                ", state='" + state + '\'' +
                '}';
    }
}
