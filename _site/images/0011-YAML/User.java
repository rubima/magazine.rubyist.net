/*
 * DTO class for Java
 *   generated at Sun Oct 02 02:49:29 JST 2005
 */
package my;

/**
 * ユーザマスターテーブル
 */
public class User implements java.io.Serializable {

    private  int          id;           /* ユーザID */
    private  String       name;         /* 名前 */
    private  String       desc;         /* 摘要 */
    private  String       email;        /* メールアドレス */
    private  int          group_id;     /* 所属するグループのID */
    private  int          age;          /* 年齢 */
    private  char         gender;       /* 性別 */
    private  java.util.Date created_on;   /* 作成時刻 */
    private  java.util.Date updated_on;   /* 更新時刻 */
    private  Group        group;        /* グループマスターテーブル */

    public int getId() { return id }
    public void setId(int id) { this.id = id; }
    public String getName() { return name }
    public void setName(String name) { this.name = name; }
    public String getDesc() { return desc }
    public void setDesc(String desc) { this.desc = desc; }
    public String getEmail() { return email }
    public void setEmail(String email) { this.email = email; }
    public int getGroupId() { return group_id }
    public void setGroupId(int group_id) { this.group_id = group_id; }
    public int getAge() { return age }
    public void setAge(int age) { this.age = age; }
    public char getGender() { return gender }
    public void setGender(char gender) { this.gender = gender; }
    public java.util.Date getCreatedOn() { return created_on }
    public void setCreatedOn(java.util.Date created_on) { this.created_on = created_on; }
    public java.util.Date getUpdatedOn() { return updated_on }
    public void setUpdatedOn(java.util.Date updated_on) { this.updated_on = updated_on; }
    public Group getGroup() { return group }
    public void setGroup(Group group) { this.group = group; }

}
