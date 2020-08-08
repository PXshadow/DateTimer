import haxe.Timer;
import datetime.DateTimeInterval;
import datetime.DateTime;
class Main {
	static function main() {
		trace("Hello, world!");
		execution(22);
	}
	private static function execution(hour:Int,day:Int=0)
	{
		var now = DateTime.now();
		//sets back to the start of the day and than adds the hour to execute
		var time = now.snap(Day(Down));
		time = time.add(Hour(hour));
		if (day > 0) time = time.add(Day(day));
		var interval:DateTimeInterval = time - now;
		var left = interval.getTotalMinutes();
		if (interval.negative)
		{
			//already passed the execution therefore fire once
			run();
			//re loop execution, aka this is recurssive
			execution(hour,++day);
		}else{
			Timer.delay(function()
			{
				run();
				if (day > 0) day--;
				//re loop execution, aka this is recurssive
				execution(hour);
			},Std.int(interval.getTotalSeconds() * 1000));
		}
	}
	private static function run()
	{
		trace("fire");
	}
}
