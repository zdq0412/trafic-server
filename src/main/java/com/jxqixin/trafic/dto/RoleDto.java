package com.jxqixin.trafic.dto;
public class RoleDto {
    private String id;

    private String name;

    private String note;

    private String orgCategoryId;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getOrgCategoryId() {
        return orgCategoryId;
    }

    public void setOrgCategoryId(String orgCategoryId) {
        this.orgCategoryId = orgCategoryId;
    }
}
