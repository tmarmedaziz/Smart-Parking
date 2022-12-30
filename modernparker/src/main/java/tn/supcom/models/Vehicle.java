package tn.supcom.models;


import jakarta.nosql.mapping.Column;
import jakarta.nosql.mapping.Entity;
import jakarta.nosql.mapping.Id;
import tn.supcom.util.FieldPropertyVisibilityStrategy;

import javax.json.bind.annotation.JsonbVisibility;
import java.io.Serializable;
import java.util.Objects;

@Entity
@JsonbVisibility(FieldPropertyVisibilityStrategy.class)
public class Vehicle implements Serializable {
    @Id
    @Column("vehicleNumber")
    private String vehicleNumber;
    @Column("vehicleCategory")
    private VehiclesCategories vehicleCategory;
    @Column("vehicleDescription")
    private String vehicleDescription;
    @Column("userId")
    private String userId;



    public String getVehicleNumber() {
        return vehicleNumber;
    }

    public void setVehicleNumber(String vehicleNumber) {
        this.vehicleNumber = vehicleNumber;
    }

    public VehiclesCategories getVehicleCategory() {
        return vehicleCategory;
    }

    public void setVehicleCategory(VehiclesCategories vehicleCategory) {
        this.vehicleCategory = vehicleCategory;
    }

    public String getVehicleDescription() {
        return vehicleDescription;
    }

    public void setVehicleDescription(String vehicleDescription) {
        this.vehicleDescription = vehicleDescription;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Vehicle)) return false;
        Vehicle vehicle = (Vehicle) o;
        return vehicleNumber.equals(vehicle.vehicleNumber) && vehicleCategory == vehicle.vehicleCategory && vehicleDescription.equals(vehicle.vehicleDescription) && userId.equals(vehicle.userId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(vehicleNumber, vehicleCategory, vehicleDescription, userId);
    }

    @Override
    public String toString() {
        return "Vehicle{" +
                "vehicleNumber='" + vehicleNumber + '\'' +
                ", vehicleCategory=" + vehicleCategory +
                ", vehicleDescription='" + vehicleDescription + '\'' +
                ", userId=" + userId +
                '}';
    }
}