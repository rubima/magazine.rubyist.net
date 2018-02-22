/*
 * DTO class for Java
 *   generated at Sun Oct 02 02:49:29 JST 2005
 */
package my;

/**
 * グループマスターテーブル
 */
public class Group implements java.io.Serializable {

    private  int          id;           /* グループID */
    private  String       name;         /* 名前 */
    private  String       desc;         /* 摘要 */
    private  java.util.Date created_on;   /* 作成時刻 */
    private  java.util.Date updated_on;   /* 更新時刻 */

    public int getId() { return id }
    public void setId(int id) { this.id = id; }
    public String getName() { return name }
    public void setName(String name) { this.name = name; }
    public String getDesc() { return desc }
    public void setDesc(String desc) { this.desc = desc; }
    public java.util.Date getCreatedOn() { return created_on }
    public void setCreatedOn(java.util.Date created_on) { this.created_on = created_on; }
    public java.util.Date getUpdatedOn() { return updated_on }
    public void setUpdatedOn(java.util.Date updated_on) { this.updated_on = updated_on; }

}
