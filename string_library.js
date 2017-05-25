
/* Add a class to a string */
String.prototype.addClass = function(theClass)
{
	if (this != "")
	{
		if (!this.classExists(theClass))
		{
			return this + " " + theClass;
		}
	}
	else
	{
		return theClass;
	}
	
	return this;
}




/* Check if a class exists in a string */
String.prototype.classExists = function(theClass)
{
	var regString = "(^| )" + theClass + "\W*";
	var regExpression = new RegExp(regString);
	
	if (regExpression.test(this))
	{
		return true;
	}
	
	return false;
}




/* Remove a class from a string */
String.prototype.removeClass = function(theClass)
{
	var regString = "(^| )" + theClass + "\W*";
	var regExpression = new RegExp(regString);
	
	return this.replace(regExpression, "");
}




String.prototype.validEmail = function()
{
	if (this.match(/^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]+$/))
	{
		return true;
	}
	
	return false;
}