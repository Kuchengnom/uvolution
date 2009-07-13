package {
	
	import classes.*;
	
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.utils.*;
	


	[SWF(width="1024", height = "768", backgroundColor = "0x000000", frameRate = "24")]

	
	public class uVoluion extends Sprite
	{	
		
		private var startscreen:Screen_Startpanel = new Screen_Startpanel;
		private var start_btn:Screen_Go_btn = new Screen_Go_btn;
		private var start_loader:Screen_Wait_mc = new Screen_Wait_mc;
		private var Panel:Screen_Panel = new Screen_Panel;
		private var Background:Screen_Background = new Screen_Background;
		private var Map:Screen_Map = new Screen_Map;
		private var Search_btn:Screen_Search_btn = new Screen_Search_btn;
		
		private var SearchPanel:Screen_Search_Panel = new Screen_Search_Panel;
		private var SearchInput:Screen_Search_TextInput = new Screen_Search_TextInput;
		private var SearchButton:Screen_Go_btn = new Screen_Go_btn;
		private var SearchExit:Screen_Speechbaloon_Exit_btn = new Screen_Speechbaloon_Exit_btn;
		private var SearchInputText:TextField = new TextField;
		private var clip:MovieClip = new MovieClip();
		
		private var Geschichte:TextField = new TextField;
		private var Klima:TextField = new TextField;
		private var Evolution:TextField = new TextField;
		private var Voelker:TextField = new TextField;
	
		private var slider:Slider;
		private var counter:int=0;
		private var complete:Boolean = false;
		private var countLoad:int=0;
		
		private var currentField:String;
		
		private var fieldArray:Array = new Array();
		private var fArray:Array = new Array();
		
		public function uVoluion():void
		{

			this.addChild(Background);
			
			startscreen.x = 512 - (startscreen.width/2);
			startscreen.y = ((Background.height - Panel.height)/2) - (startscreen.height/2);
			Background.addChild(startscreen);
			
			start_btn.x = 30;
			start_btn.y = 45;
			start_btn.visible = false;
			startscreen.addChild(start_btn);
			start_btn.addEventListener(MouseEvent.CLICK, startMap);
			
			start_loader.x = 50;
			start_loader.y = 65;
			start_loader.width = 50;
			start_loader.height = 50;
			start_loader.alpha = 0.5;
			startscreen.addChild(start_loader);
			
			
			Map.visible=false;
			Background.addChild(Map);
			

			Panel.y = Background.height - Panel.height;
			Panel.mouseChildren = false;
			Panel.alpha=0.3;
			Background.addChild(Panel);

			
			Search_btn.x = 930;
			Search_btn.y = 20;
			Panel.addChild(Search_btn);
			Search_btn.addEventListener(MouseEvent.CLICK, startSearch);
			
	
		
			slider = new Slider(this);
			Panel.addChild(slider);
			

			SearchPanel.x = 512 - (SearchPanel.width/2);
			SearchPanel.y = ((Background.height - Panel.height)/2) - (SearchPanel.height/2);
			Map.addChild(SearchPanel);
			
			clip.graphics.beginFill(0xb4b4b4,1);
			clip.graphics.drawRect(SearchPanel.x,(SearchPanel.y+SearchPanel.height),SearchPanel.width,25);
			clip.graphics.endFill();
			Map.addChild(clip);
			
			SearchInput.x = 60;
			SearchInput.y = 135;
			SearchPanel.addChild(SearchInput);
			
			SearchInputText.text="";
			SearchInputText.type = TextFieldType.INPUT;
			SearchInputText.width = SearchInput.width;
			SearchInput.addChild(SearchInputText);
			
			SearchButton.x = 90 + SearchInput.width;
			SearchButton.y = 135;
			SearchPanel.addChild(SearchButton);
			SearchButton.addEventListener(MouseEvent.CLICK, Search);
			
			SearchExit.x = SearchPanel.width - 50;
			SearchExit.y = 10;
			SearchPanel.addChild(SearchExit);
			SearchExit.addEventListener(MouseEvent.CLICK, closeSearch);
			

			
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


			var timer:Timer = new Timer(80, 30);
			timer.addEventListener(TimerEvent.TIMER, loading);
			timer.start();
			
			
			this.addEventListener("XML_LOADED", xmlLoaded);
			
			this.addEventListener("Slider_Moved", generator);

          	fieldArray["History"] = new theXML('History.xml', this);
           	fieldArray["Climate"] = new theXML('Climate.xml', this);
         	fieldArray["Evolution"] = new theXML('testtest.xml',this);
         	fieldArray["People"] = new theXML('people_population.xml', this);
           
          	fArray["History"] = new History();
           	fArray["Climate"] = new Climate();
           	fArray["Evolution"] = new PreHistorics();
           	fArray["People"] = new People();
           
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
			fArray["Evolution"]._myXML = fieldArray["Evolution"];
			fArray["People"]._myXML = fieldArray["People"];
			
		}
		

		
		private function startMap(evt:MouseEvent):void {
			
			if(complete) {
			
				startscreen.visible=false;
				Map.visible=true;
				Panel.alpha=1;
				Panel.mouseChildren = true;
				
				
				switch (evt.target.text)
	        	{
	        		case "Geschichte":
	            		trace("new History");
	            		fArray["History"].getCoords();
	            		fArray["History"].generateDots();
	            		slider.contentLength = fArray["History"].lengthXML;
	            		currentField="History";
	            		Map.addChild(fArray["History"]);
	            		break;
	            	case "Klima":
	            		trace("new Climate");
	            		fArray["Climate"].getCoords();
	            		fArray["Climate"].generateDots();
	            		slider.contentLength = fArray["Climate"].lengthXML;
	            		currentField="Climate";
	            		Map.addChild(fArray["Climate"]);
	            		break;
	            	case "Evolution":
	            		trace("new Evolution");
	            		fArray["Evolution"].getCoords();
	            		fArray["Evolution"].generateDots();
	            		slider.contentLength = fArray["Evolution"].lengthXML;
	            		currentField="Evolution";
	            		Map.addChild(fArray["Evolution"]);
	            		break;
	            	case "Völker":
	            		trace("new People");
	            		fArray["People"].getCoords();
	            		fArray["People"].generateDots();
	            		slider.contentLength = fArray["People"].lengthXML;
	            		currentField="People";
	            		Map.addChild(fArray["People"]);
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
			if(currentField != null) {
				
				fArray[currentField].position = slider._position;
				slider.year = fArray[currentField].year;
				fArray[currentField].showDot();
			
			}
			else {
				
				trace("kein Field ausgewählt!");
			}
			
			trace("Slider position: "+slider._position);
			trace("numChildren: "+Map.numChildren);
			
			
			if(Map.numChildren>2){
				
				Map.removeChildAt(1);
			}
			
		}			

		
		private function loading(evt:TimerEvent):void {
			
			start_loader.rotation+=10;
			
			countLoad++;
			
			if(countLoad>=30 && complete){
				start_loader.visible=false;
				start_btn.visible=true;
			}	
		}
		
		private function startSearch(evt:MouseEvent):void {
			
			Map.addChild(SearchPanel);	
		}
		
		private function Search(evt:MouseEvent):void {
			
			clip.height = 50;
	
		}
		
		private function closeSearch(evt:MouseEvent):void {
			Map.removeChild(SearchPanel);
			SearchInputText.text="";
		}

	}
}
