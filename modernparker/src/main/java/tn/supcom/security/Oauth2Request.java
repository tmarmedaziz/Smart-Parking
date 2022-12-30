package tn.supcom.security;





import tn.supcom.util.FieldPropertyVisibilityStrategy;

import javax.json.bind.annotation.JsonbVisibility;
import javax.validation.constraints.NotBlank;
import javax.ws.rs.FormParam;

@JsonbVisibility(FieldPropertyVisibilityStrategy.class)
public class Oauth2Request {

    @FormParam("grand_type")
    @NotBlank
    private String grandType;

    @FormParam("email")
    @NotBlank(groups = {GenerateToken.class})
    private String email;

    @FormParam("password")
    @NotBlank(groups = {GenerateToken.class})
    private String password;

    @FormParam("refresh_token")
    @NotBlank(groups = {RefreshToken.class})
    private String refreshToken;

    public void setGrandType(GrantType grandType) {
        if(grandType != null) {
            this.grandType = grandType.get();
        }
    }


    public void setPassword(String password) {
        this.password = password;
    }

    public void setRefreshToken(String refreshToken) {
        this.refreshToken = refreshToken;
    }

    public GrantType getGrandType() {
        if(grandType != null) {
            return GrantType.parse(grandType);
        }
        return null;
    }


    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public String toString() {
        return "Oauth2Request{" +
                "grandType='" + grandType + '\'' +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", refreshToken='" + refreshToken + '\'' +
                '}';
    }

    public String getPassword() {
        return password;
    }

    public String getRefreshToken() {
        return refreshToken;
    }

    public @interface GenerateToken{}

    public @interface RefreshToken{}
}