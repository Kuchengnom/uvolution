package {
	import classes.*;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.*;
	
	

	[SWF(width="1024", height = "768", backgroundColor = "0xFFFFFF", frameRate = "24")]
	
	public class uVoluion extends Sprite
	{	
		
		private var startscreen:Screen_Startpanel = new Screen_Startpanel;
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
		
		private var oPreHistorics:PreHistorics = new PreHistorics();
		private var oHistory:History = new History();
	
		
		private var fieldArray:Array = new Array();
		private var sliderArray:Array = new Array();
		
		public function uVoluion():void
		{

			this.addChild(Background);
			
			startscreen.x = 512 - (startscreen.width/2);
			startscreen.y = ((Background.height - Panel.height)/2) - (startscreen.height/2);
			Background.addChild(startscreen);
			
			Map.visible=false;
			Background.addChild(Map);
			

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

			
			//this.addEventListener(MouseEvent.CLICK, startMap);
		
			this.addEventListener("XML_LOADED", xmlLoaded);
			
			this.addEventListener("Slider_Moved", dotsdots);

           fieldArray["History"] = new theXML('people_population.xml', this);
           //fieldArray["PreHistorics"] = new theXML('PreHistorics.xml', this);
           
          // sliderArray["History"] = new Slider(this);
           
		}
		
		private function xmlLoaded(event:Event):void
		{
			trace("::::::::");
			counter++;
			/*
			if (Map.contains(DisplayObject(event.target)))
			{
				slider.contentLength = Field(event.target)._lengthXML;

			}
			*/

			if(counter>=fieldArray.length)
			{
					init();	
					complete = true;
			}

		}
		
		
		private function init():void {
			
			oHistory._myXML = fieldArray["History"];
			//oHistory._Slider = sliderArray["History"];
			oHistory.getCoords();
			trace("Slider position: "+slider._position);
			slider.contentLength = oHistory.lengthXML;
			trace("Slider Length: "+slider._contentLength);
         
			
			generator(null);
		}
		
		private function startMap(evt:MouseEvent):void {
			
			if(complete) {
			
				startscreen.visible=false;
				Map.visible=true;
				
				
				switch (evt.target.text)
	        	{
	        		case "Geschichte":
	            		trace("new History");
	            		break;
	            	case "Klima":
	            		trace("new Climate");
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
	
		public function dotsdots(event:Event):void
		{	
			
			oHistory.position = slider._position;
			oHistory.generateDots();
			Map.addChild(oHistory);
			trace("dots dots");
			trace("Slider position: "+slider._position);
		}			

		//### TEST DOTS GENERIEREN! ##
		public function generator(evt:MouseEvent):void
		{	
			
			oHistory.position = slider._position;
			oHistory.generateDots();
			Map.addChild(oHistory);
			trace("generate function"); 
		}
	}
}
