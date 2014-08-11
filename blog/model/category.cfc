component persistent="true" table="category"  {
	property name="categoryID" fieldtype="id" setter="false" generator="native";
	property name="categoryname" ormtype="string";
	property name="description" ormtype="text";
	property name="blogposts" fieldtype="many-to-many" type="array" fkcolumn="categoryID" cfc="blogpost" linktable="blogpost_category";
}