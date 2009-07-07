package {
	import classes.*;
	
	import flash.display.DisplayObject;
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
		//private var oPeople:Main_Disp_TabsPeoples = new Main_Disp_TabsPeoples;
		
		private var fieldArray:Array = new Array();
		
		public function uVoluion():void
		{
			
			/*#######G R I D########
			this.graphics.lineStyle(1, 0x000000, 1);
			
            for (var i:int = 1; i < 60; i++)
            {
                this.graphics.moveTo(i * 16 - 0.5, 0);
                this.graphics.lineTo(i * 16 - 0.5, 768);
            }
            for (i = 1; i < 64; i++)
            {
                this.graphics.moveTo(0, i * 16 - 0.5);
                this.graphics.lineTo(1024, i * 16 - 0.5);
            }
			*/
			
		
			
			startscreen.x = 512 - (startscreen.width/2);
			startscreen.y = Panel.height;
			startscreen.visible=true;
			Background.addChild(startscreen);
		
	

			this.addChild(Background);
			
			Map.visible=false;
			Background.addChild(Map);
			
		
			
			Panel.y = Background.height - Panel.height;
			Background.addChild(Panel);
			
			Search_btn.x = 930;
			Search_btn.y = 20;
			Panel.addChild(Search_btn);
			
			Map.addEventListener(MouseEvent.CLICK, generator);
		
			slider = new Slider();
			slider.x = 20;
         	slider.y = 100;
            Panel.addChild(slider);
			
			
			//########################## M E N U ############################
			
			Geschichte.x=20;
			Geschichte.y=20;
			Geschichte.text = "Geschichte";
			Geschichte.height=20;
			Panel.addChild(Geschichte);
			
			Klima.x = 20 + Geschichte.width;
			Klima.y = 20;
			Klima.text = "Klima";
			Klima.height=20;
			Panel.addChild(Klima);
			
			Evolution.x = 20 + Geschichte.width + Klima.width;
			Evolution.y = 20;
			Evolution.text = "Evolution";
			Evolution.height=20;
			Panel.addChild(Evolution);
			
			Voelker.x = 20 + Geschichte.width + Klima.width + Evolution.width;
			Voelker.y = 20;
			Voelker.text = "Völker";
			Voelker.height=20;
			Panel.addChild(Voelker);
			
			//##############################################################
			
			this.addEventListener(MouseEvent.CLICK, startMap);
		
			
			this.addEventListener("XML_LOADED", xmlLoaded);
         	/*
         	slider = new Slider();
         	slider.x = 20;
         	slider.y = 100;
            Panel.addChild(slider);
   			*/
   			
         //   this.addChild(new History);
           // this.addChild(new Climate);
            
           // this.addChild(new PreHistoricsClass);
           
           fieldArray["History"] = new theXML('template.xml', this);
           //fieldArray["PreHistorics"] = new theXML('PreHistorics.xml', this);
           
           
		}
		
		private function xmlLoaded(event:Event):void
		{
			trace("::::::::");
			counter++;
			
			if (Map.contains(DisplayObject(event.target)))
			{
				slider.contentLength = Field(event.target)._lengthXML;

			}
			

			if(counter>=fieldArray.length)
			{
					init();	
					complete = true;
			}
			else
			{
				showStartscreen();	
			}
		}
		
		private function showStartscreen():void {
			
			startscreen.visible=true;
			startscreen.alpha=1;
			
			
		}
		
		private function init():void {
			

			oHistory._myXML = fieldArray["History"];
			oHistory.getCoords();
			
			slider.contentLength = oHistory.lengthXML;
			trace("Slider Length: "+slider._contentLength);
         
			
			generator(null);
		}
		
		private function startMap(evt:MouseEvent):void {
			
			if(complete) {
			
				startscreen.visible=false;
				Map.visible=true;
				
				/*
				switch (evt.target.name)
	        	{
	        		case "People":
	            		this.addChild(new History);
	            		break;
	            	default:
	            		trace("Default!");
	            		break;
	        	}
	        	*/
			}	

				
		}
		
		//### TEST DOTS GENERIEREN! ##
		public function generator(evt:MouseEvent):void
		{
			oHistory.generateDots();
			Map.addChild(oHistory);
			trace("generate function");
		}
	}
}
