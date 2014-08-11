component persistent="true" table="user"{
	property name="userID" fieldtype="id" setter="false" generator="native";
	property name="image" ormtype="string";
	property name="password" ormtype="string" length="65";
	property name="fullname" ormtype="string" length="50";
	property name="email" ormtype="string" length="150";	
	property name="address" ormtype="string" length="150";
	property name="phone" ormtype="string" length="50";
	property name="created" ormtype="timestamp";
	property name="updated" ormtype="timestamp";

	property name="blogposts" fieldtype="one-to-many" cfc="blogpost" fkcolumn="userID" type="array" singularname="blogpost";
}