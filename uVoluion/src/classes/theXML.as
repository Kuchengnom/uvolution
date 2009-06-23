package classes
{
	import flash.events.*;
	import flash.net.*;
	import flash.xml.*;

	public class theXML extends XMLDocument
	{
		private var _myLoader:URLLoader = new URLLoader();
		
		private var _myURL:URLRequest;
		
		private var _myXML:XML;
		
		public function theXML(source:String=null)
		{
			super(source);
			
			_myLoader.addEventListener(Event.COMPLETE, onLoadComplete);
			_myLoader.load(new URLRequest("classes/xml/"+source));
			
		}
		private function onLoadComplete(evt:Event):void {
				trace("oncomplete");
				_myXML = new XML(evt.target.data);
				_myXML.ignoreComments = true;
				_myXML.ignoreWhitespace = true;
		}
		
		public function get myXML():XML
		{
			return _myXML;
		}
	}
}