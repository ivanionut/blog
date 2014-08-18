component persistent="true" table="blogpost" {
	property name="blogpostID" fieldtype="id" setter="false" generator="native";
	property name="title" ormtype="string";
	property name="subtitle" ormtype="string";
	property name="context" ormtype="text";
	property name="description" ormtype="text" length="200";
	property name="status" ormtype="integer";
	property name="created" ormtype="timestamp";
	property name="updated" ormtype="timestamp";
	property name="updatedby" ormtype="string" length="150";

	property name="userID" fieldtype="many-to-one" cfc="user" fkcolumn="userID";
	property name="comments" fieldtype="one-to-many" fkcolumn="blogpostID" cfc="blogcomment" type="array" singularname="blogcomment" cascades="all-delete-orphan" ;
	property name="categories" fieldtype="many-to-many" type="array" cfc="category" fkcolumn="blogpostID" linktable="blogpost_category" singularname="category";
}