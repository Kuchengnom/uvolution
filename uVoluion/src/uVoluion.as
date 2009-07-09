package {
	import classes.*;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.*;
	
	

	[SWF(width="1024", height = "768", backgroundColor = "0xFFFFFF", frameRate = "24")]
	
	public class uVoluion extends Sprite
	{	
		
		private var startscreen:Screen_Startpanel = new Screen_Startpanel;
		private var start_btn:Screen_Go_btn = new Screen_Go_btn;
		private var start_loader:Screen_Wait_mc = new Screen_Wait_mc;
		private var Panel:Screen_Panel = new Screen_Panel;
		private var Background:Screen_Background = new Screen_Background;
		private var Map:Screen_Map = new Screen_Map;
		private var Search_btn:Screen_Search_btn = new Screen_Search_btn;
		
		private var Geschichte:TextField = new TextField;
		private var Klima:TextField = new TextField;
		private var Evolution:TextField = new TextField;
		private var Voelker:TextField = new TextField;
	
		private var slider:Slider;
		private var counter:int=0;
		private var complete:Boolean = false;
		private var coun:int=0;
		
		private var aktuell:String;
		
		private var oClimate:Climate;
		private var oHistory:History;
	
		
		private var fieldArray:Array = new Array();
		private var fArray:Array = new Array();
		
		public function uVoluion():void
		{

			this.addChild(Background);
			
			startscreen.x = 512 - (startscreen.width/2);
			startscreen.y = ((Background.height - Panel.height)/2) - (startscreen.height/2);
			Background.addChild(startscreen);
			
			start_btn.x = 20;
			start_btn.y = 20;
			start_btn.visible = false;
			startscreen.addChild(start_btn);
			start_btn.addEventListener(MouseEvent.CLICK, startMap);
			
			start_loader.x = 50;
			start_loader.y = 60;
			start_loader.width = 60;
			start_loader.height = 60;
			startscreen.addChild(start_loader);
			
			
			Map.visible=false;
			Background.addChild(Map);
			

			//Map.addChild(Pop_Ticker);
			
			Panel.y = Background.height - Panel.height;
			Background.addChild(Panel);
			
			Search_btn.x = 930;
			Search_btn.y = 20;
			Panel.addChild(Search_btn);
			
			Map.addEventListener(MouseEvent.CLICK, generator);
		
			slider = new Slider(this);
			Panel.addChild(slider);
			

			
			//########################## M E N U ############################
			
			Geschichte.x=20;
			Geschichte.y=20;
			Geschichte.text = "Geschichte";
			Geschichte.height=20;
			Geschichte.selectable=false;
			Geschichte.addEventListener(MouseEvent.CLICK, startMap);
			Panel.addChild(Geschichte);
			
			Klima.x = 20 + Geschichte.width;
			Klima.y = 20;
			Klima.text = "Klima";
			Klima.height=20;
			Klima.selectable=false;
			Klima.addEventListener(MouseEvent.CLICK, startMap);
			Panel.addChild(Klima);
			
			Evolution.x = 20 + Geschichte.width + Klima.width;
			Evolution.y = 20;
			Evolution.selectable=false;
			Evolution.text = "Evolution";
			Evolution.height=20;
			Evolution.addEventListener(MouseEvent.CLICK, startMap);
			Panel.addChild(Evolution);
			
			Voelker.x = 20 + Geschichte.width + Klima.width + Evolution.width;
			Voelker.y = 20;
			Voelker.selectable=false;
			Voelker.text = "Völker";
			Voelker.height=20;
			Voelker.addEventListener(MouseEvent.CLICK, startMap);
			Panel.addChild(Voelker);
			
			//##############################################################


			var timer:Timer = new Timer(100, 50);
			timer.addEventListener(TimerEvent.TIMER, loading);
			timer.start();
			
			
			this.addEventListener("XML_LOADED", xmlLoaded);
			
			this.addEventListener("Slider_Moved", generator);

          	fieldArray["History"] = new theXML('people_population.xml', this);
           	fieldArray["Climate"] = new theXML('testtest.xml', this);
           
           fArray["History"] = new History();
           fArray["Climate"] = new Climate();
           
		}
		
		private function xmlLoaded(event:Event):void
		{
			trace("::::::::");
			counter++;

			if(counter>=fieldArray.length)
			{
					init();	
					complete = true;
			}

		}
		
		
		private function init():void {
			
			fArray["History"]._myXML = fieldArray["History"];
			fArray["Climate"]._myXML = fieldArray["Climate"];
			
			//oHistory.getCoords();
			//oClimate.getCoords();
			
			//oHistory.generateDots();
			//oClimate.generateDots();
			//trace("Slider position: "+slider._position);
			
			//trace("Slider Length: "+slider._contentLength);
         	
			
			//Map.addChild(oHistory);
			
			//generator(null);
		}
		

		
		private function startMap(evt:MouseEvent):void {
			
			if(complete) {
			
				startscreen.visible=false;
				Map.visible=true;
				
				
				switch (evt.target.text)
	        	{
	        		case "Geschichte":
	            		trace("new History");
	            		fArray["History"].getCoords();
	            		fArray["History"].generateDots();
	            		slider.contentLength = fArray["History"].lengthXML;
	            		aktuell="History";
	            		Map.addChild(fArray["History"]);
	            		break;
	            	case "Klima":
	            		trace("new Climate");
	            		fArray["Climate"].getCoords();
	            		fArray["Climate"].generateDots();
	            		slider.contentLength = fArray["Climate"].lengthXML;
	            		aktuell="Climate";
	            		Map.addChild(fArray["Climate"]);
	            		break;
	            	case "Evolution":
	            		trace("new Evolution");
	            		break;
	            	case "Völker":
	            		trace("new People");
	            		break;
	            	default:
	            		trace("NOTHING!");
	            		break;
	        	}
	        	
			}	
				
		}
		
			//### TEST DOTS GENERIEREN! ##
		public function generator(event:Event):void
		{	
			fArray[aktuell].position = slider._position;
			fArray[aktuell].showDot();
			
			trace("Slider position: "+slider._position);
			trace("numChildren: "+Map.numChildren);
			
			
			if(Map.numChildren>2){
				
				Map.removeChildAt(1);
			}
			
		}			

		
		private function loading(evt:TimerEvent):void {
			
			start_loader.rotation+=10;
			
			coun++;
			if(coun>=50 && complete){
				start_loader.visible=false;
				start_btn.visible=true;
			}	
		}

	}
}
