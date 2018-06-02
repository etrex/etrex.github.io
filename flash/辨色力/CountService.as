package 
{
	import com.adobe.serialization.json.JSON;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	/**
	 * ...
	 * @author ETREX
	 */
	public class CountService
	{
		public static function AddCount(name:String,callback:Function):void
		{
			var urlRequest :URLRequest = new URLRequest("http://webetrex.appspot.com/color/count");
			var urlVar : URLVariables = new URLVariables();
			urlVar.name = name;
			urlRequest.data = urlVar;
			
			var urlLoader : URLLoader = new URLLoader();
			
			if (callback != null)
			{
				urlLoader.addEventListener(Event.COMPLETE, function(event:Event):void {
					var obj:Object = JSON.decode((String)(urlLoader.data));
					callback(obj.count);
				});
			}
			urlLoader.load(urlRequest);
		}
		public static function AddHistogram(name:String,score:int,callback:Function):void
		{
			var urlRequest :URLRequest = new URLRequest("http://webetrex.appspot.com/color/histogram");
			var urlVar : URLVariables = new URLVariables();
			urlVar.name = name;
			urlVar.score = score;
			urlRequest.data = urlVar;
			
			var urlLoader : URLLoader = new URLLoader();
			
			if (callback != null)
			{
				urlLoader.addEventListener(Event.COMPLETE, function(event:Event):void {
					var obj:Object = JSON.decode((String)(urlLoader.data));
					callback(obj.count);
				});
			}
			urlLoader.load(urlRequest);
		}
	}
}