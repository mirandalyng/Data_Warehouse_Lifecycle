# Snowflake Role Hierarchy

## Access Control in snowflake

![](images/access_control.png)

## Example of access control

![](images/access_control_2.png)

- privileges are inherited
- role 1 grants the role1 to user1
- you can grant role2 to role1
- and role3 to role2

![](images/inherited.png)

## System-defined roles

![](images/define_roles.png)

- you should use lowest ranking role that can do the task

## Hierarchy of roles and inherited privilages

![](images/image.png)

**Sysadmin**

- creating warehouse and databases
