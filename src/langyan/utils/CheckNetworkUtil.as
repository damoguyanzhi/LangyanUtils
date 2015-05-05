package langyan.utils
{
	import flash.events.StatusEvent;
	import flash.net.URLRequest;
	
	import air.net.URLMonitor;

	/**检测网络*/
	public class CheckNetworkUtil
	{
		private static var _urlRequest:URLRequest;
		private static var _monitor:URLMonitor;
		private static var _callFunc:Function;
		private static var _url:String;
		public static function CheckNetwork(url:String,callFunc:Function):void
		{
			_url=url;
			_callFunc=callFunc;
			_urlRequest=new URLRequest(_url);
			_monitor=new URLMonitor(_urlRequest);
			_monitor.addEventListener(StatusEvent.STATUS, checkHTTPHandler);
			_monitor.start();
		}
		
		private static function checkHTTPHandler(e:StatusEvent):void
		{
			var code:String = e.code;
			trace(code);
			if(_monitor.available)
			{
				trace("可以访问该网络:",_url);
			}
			else
			{
				trace("无法可以访问该网络:",_url);
			}
			_callFunc(_monitor.available);
		}
		
		public static function dispose():void
		{
			if(_monitor)
			{
				_monitor.stop();
				_monitor.removeEventListener(StatusEvent.STATUS, checkHTTPHandler);
				_monitor=null;
			}
		}
	}
}