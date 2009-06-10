package classes
{
	import caurina.transitions.Tweener;
	import fl.controls.Button;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.xml.*;
	

	public class DotGeneration extends Sprite
	{
		private var dotArray:Array=new Array();
		private var coArray:Array= new Array([241, 431], [444, 488], [800,600], [700,320]);
		
		private var speechBaloon:MovieClip;
		private var generate_btn:Button;
		
		private var clip:MovieClip=new MovieClip();
		
		private var n:int = 0;
		
		private var myLoader:URLLoader = new URLLoader();
		
		private var myURL:URLRequest = new URLRequest("xml/PreHistorics.xml");
		
		private var preHisXML:XML;
		
		
		public function DotGeneration()
		{
			super();
			
			generate_btn.addEventListener(MouseEvent.CLICK, generate);
			generate_btn.x = 1000;
			generate_btn.y = 500;
			this.addChild(generate_btn);
			
			speechBaloon = new Main_app_speechbaloon;
			speechBaloon.alpha = 0;
			speechBaloon.mouseChildren = true;
			speechBaloon.close_mc.addEventListener(MouseEvent.CLICK, alf);
			this.addChild(speechBaloon);
			
			myLoader.addEventListener(Event.COMPLETE, onLoadComplete);
			
			myLoader.load(myURL);
			
			XML.ignoreComments = true;
			XML.ignoreWhitespace = true;
		}
		public function generate(event:MouseEvent):void
		{
			trace(coArray);
	
			for(var i:int=0;i<4;i++)
			{
				clip.graphics.beginFill(0x996600,1);
				clip.graphics.drawCircle(2,2,8);
				clip.graphics.endFill();
				clip.name = i.toString();
				//trace(clip.name);
				this.addChild(clip);
				dotArray.push(clip);
				clip.x=coArray[i][0];
				clip.y=coArray[i][1];
				clip.addEventListener(MouseEvent.MOUSE_OVER, buttonHover);
			}
		}

		public function alf (evt:MouseEvent):void{
			trace("alpha = 0");
			Tweener.addTween(speechBaloon,{alpha:0,time:0.3,transition:"linear"});
		}
		public function buttonHover(evt:MouseEvent):void{
			trace(evt.target.name);
			speechBaloon.x=evt.target.x;
			speechBaloon.y=evt.target.y;
			Tweener.addTween(speechBaloon,{alpha:1,time:2,transition:"easeInOut"});
			n = parseInt(evt.target.name);
			cycleDis();
		}
		// --------------------------------------
		// ---------------XML--------------------
		// --------------------------------------
		
		
		public function onLoadComplete(evt:Event):void {
				trace("oncomplete");
				preHisXML = new XML(evt.target.data);
				trace ("TimelineEvents: " + preHisXML.TimelineEventsTyp.text() +"  Type: " + preHisXML.TimelineEventsTyp.@type);
				trace ("Die Timeline enthält " + preHisXML.Events.item.length()) + " Events";  // 2 items
				/*
				var i:Number;
				for (i = 0; i <preHisXML.Events.item.length(); i++) {
					trace ("	 Name des Events :" + preHisXML.Events.item[i].title.text()) + "\n";
				}
				
				trace ("Event 5 ist vom " + preHisXML..era[0].text() + preHisXML..@year[4]);
				
				trace ("Von 440 Million years BC sind: " + preHisXML.Events.item.(era.@year == "440 Million years BC")..title.text());
				
				var searchResult:XMLList = new XMLList (preHisXML.Events.item.(era.@year == "440 Million years BC"));
				for (i = 0; i <searchResult.length(); i++) {
					trace ("(searchResult) Von 440 Million years BC ist: " + searchResult.title[i]);
				}*/
		}		
		public function cycleDis():void
		{
			speechBaloon.headline.text = preHisXML..title[n].text();
			speechBaloon.subline.text = "Cycle: " + preHisXML..cycle[n].text();
			speechBaloon.txt.text = preHisXML..text[n].text()
			speechBaloon.era.text = "Era: " + preHisXML..era[n].text();
			trace(n);
		}
		
	}
}