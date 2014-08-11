component persistent="true" table="blogcomment"  {
	property name="commentID" fieldtype="id" setter="false" generator="native";
	property name="context"ormtype="text";
	property name="username" ormtype="string" length="150";
	property name="email" ormtype="string" length="150";
	property name="created" ormtype="timestamp";

	property name="blogpostID" fieldtype="many-to-one" cfc="blogpost" fkcolumn="blogpostID";	
}