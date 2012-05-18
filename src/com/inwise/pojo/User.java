package com.inwise.pojo;

import javax.persistence.*;
import java.util.List;
import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA.
 * User: Milind
 * Date: Feb 9, 2012
 * Time: 10:54:52 AM
 * To change this template use File | Settings | File Templates.
 */
@Entity
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @Column(name = "deleted",length = 2)
    private Integer deleted;
    
    @Column(name = "username",length = 50)
    private String username;

    @Column(name = "password",length = 50)
    private String password;

    @ManyToOne()
    @JoinColumn(name="role_id")
    private Role role;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "user")
    private List<UserPermissions> userPermissions=new ArrayList<UserPermissions>();

    public List<UserPermissions> getUserPermissions() {
        return userPermissions;
    }

    public void setUserPermissions(List<UserPermissions> userPermissions) {
        this.userPermissions = userPermissions;
    }

    public int getDeleted() {
        return deleted;
    }

    public void setDeleted(int deleted) {
        this.deleted = deleted;
    }


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", deleted=" + deleted +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", role=" + role +
                ", userPermissions=" + userPermissions +
                '}';
    }
}
