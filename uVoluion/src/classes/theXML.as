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
				
		}
		
		private function onLoadComplete(evt:Event):void {

				_myXML = new XML(evt.target.data);
				_myXML.ignoreComments = true;
				_myXML.ignoreWhitespace = true;
				
			_dispatcher.dispatchEvent(new Event("XML_LOADED", true));
		}
		
		public function get myXML():XML
		{
			return _myXML;
		}
		/**
		 * The final screen shot. - a rare breed, usually spotted near to the finishing
		 * of an amazing project. Humans often disrespect the final screen shot for it's 
		 * beauty and perfection. Together with the final draft the screen shot marks the 
		 * end of a chapter, which was thought long time to be sealed for all eternity. 
		 * Only four fearless warriors took on the quest to defeat all sceptists and people 
		 * who dared to doubt. On their fellowship into the holy halls of applicational fame 
		 * they rose beyond human strength and intellect. This chapter has been closed... 
		 * but not for all warriors. Two of them digging deep down in the source code to reach 
		 * a level of completeness which would bring satisfaction to the Lord Gerrit. 
		 * As he is known not to judge every application by it's cover. Others might be tricked, 
		 * but not him.
		 * This story of the dangerous quest to be told to your kinds and grandkids, and their 
		 * kids and grand kids, as it shall live forever.
		 * 
		 * ~The Storyteller~
		 **/
	}
}