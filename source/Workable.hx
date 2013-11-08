package ;

interface Workable
{

	function needsWork():Bool;
	
	function work(citizen:Citizen = null):Void;
	
}