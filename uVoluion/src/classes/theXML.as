package classes
{
	import flash.display.DisplayObject;
	import flash.events.*;
	import flash.net.*;
	import flash.xml.*;

	public class theXML
	{
		private var _myLoader:URLLoader = new URLLoader();
		
		private var _myURL:URLRequest;
		
		private var _myXML:XML;
		private var _dispatcher:DisplayObject;
	
		
		public function theXML(source:String, dispatcher:DisplayObject)
		{
			_dispatcher = dispatcher;
			_myLoader.addEventListener(Event.COMPLETE, onLoadComplete);
			_myLoader.load(new URLRequest("classes/xml/"+source));
			
			trace("ZIELPFAD: "+source);
			
		}
		private function onLoadComplete(evt:Event):void {
				trace("oncomplete");
				//trace("MYXML LENGTH: "+_myXML.Events.item.length());
				_myXML = new XML(evt.target.data);
				_myXML.ignoreComments = true;
				_myXML.ignoreWhitespace = true;
				
			_dispatcher.dispatchEvent(new Event("XML_LOADED", true));
		}
		
		public function get myXML():XML
		{
			return _myXML;
		}
		
	}
}