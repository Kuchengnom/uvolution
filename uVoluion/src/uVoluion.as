package {
	
	import caurina.transitions.Tweener;
	
	import classes.*;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.utils.*;
	
	/**	  .-~~-.____		fuer Gerrit
		 / |  '     \
		(  )         O        _
		 \_/-, ,----'        //
		    ====        ___ //
		    /  \-~;    /---(O)     
		   /  __/'~;__/      | 
		==(______| (_________|   
	**/

	[SWF(width="1024", height = "768", backgroundColor = "0x000000", frameRate = "24")]

	
	public class uVoluion extends Sprite
	{	
		
		[Embed(source='classes/HelveticaNeueLTStd-Lt.otf', fontFamily = 'HelveticaLight')]
        private var LightHelvetica:Class;
		
		private var startscreen:Screen_Startpanel = new Screen_Startpanel;
		private var start_btn:Screen_Go_btn = new Screen_Go_btn;
		private var start_loader:Screen_Wait_mc = new Screen_Wait_mc;
		private var Panel:Screen_Panel = new Screen_Panel;
		private var Background:Screen_Background = new Screen_Background;
		private var Map:MovieClip = new MovieClip;
		private var oMap:Screen_Map = new Screen_Map;
		private var prehisMap:Screen_Map_PreHis = new Screen_Map_PreHis;
		private var colorableBG:Screen_Background = new Screen_Background;
		private var Search_btn:Screen_Search_btn = new Screen_Search_btn;
		private var lightbox:Screen_Background = new Screen_Background;
		
		private var SearchPanel:Screen_Search_Panel = new Screen_Search_Panel;
		private var SearchInput:Screen_Search_TextInput = new Screen_Search_TextInput;
		private var SearchButton:Screen_Go_btn = new Screen_Go_btn;
		private var SearchExit:Screen_Speechbaloon_Exit_btn = new Screen_Speechbaloon_Exit_btn;
		private var SearchInputText:TextField = new TextField;
		private var SearchField:Screen_Search_Display = new Screen_Search_Display;
		private var SearchResult:TextField = new TextField;
		
		private var Geschichte:Screen_Panel_Geschichte = new Screen_Panel_Geschichte;
		private var Klima:Screen_Panel_Klima = new Screen_Panel_Klima;
		private var Evolution:Screen_Panel_Evolution = new Screen_Panel_Evolution;
		private var Voelker:Screen_Panel_Voelker = new Screen_Panel_Voelker;
	
		private var slider:Slider;
		private var counter:int=0;
		private var complete:Boolean = false;
		private var countLoad:int=0;
		
		private var currentField:String;
		
		private var fieldArray:Array = new Array();
		private var fArray:Array = new Array();
		
		private var Haasi:Boolean = false;
		
		public function uVoluion():void
		{

			this.addChild(Background);
			Background.addChild(colorableBG);
			
			lightbox.transform.colorTransform = new ColorTransform(0,0,0,0.5,0,0,0,0);
			
			startscreen.x = 512 - (startscreen.width/2);
			startscreen.y = ((Background.height - Panel.height)/2) - (startscreen.height/2);
			
			
			start_btn.x = startscreen.width-start_btn.width-30;
			start_btn.y = 80;
			start_btn.visible = false;
			startscreen.addChild(start_btn);
			start_btn.addEventListener(MouseEvent.CLICK, startMap);
			
			start_loader.x = startscreen.width-start_loader.width-20;
			start_loader.y = 95;
			start_loader.width = 50;
			start_loader.height = 50;
			start_loader.alpha = 0.5;
			startscreen.addChild(start_loader);
			
			prehisMap.visible=false;
			prehisMap.y = 170;
			Background.addChild(prehisMap);
			Map.visible=false;
			Background.addChild(Map);
			Map.addChild(oMap);
			

			Panel.y = Background.height - Panel.height;
			Panel.mouseChildren = false;
			Panel.alpha=1;
			Background.addChild(Panel);
		
			slider = new Slider(this);
			Panel.addChild(slider);
			
			
			//++++++++++++++++++++++ SEARCH +++++++++++++++++++++++++++++++
			Search_btn.x = 930;
			Search_btn.y = 20;
			Panel.addChild(Search_btn);
			Search_btn.addEventListener(MouseEvent.CLICK, startSearch);
			
			SearchField.x = 512 - (SearchField.width/2);
			SearchField.height = SearchPanel.height;
			SearchField.y = ((Background.height - Panel.height)/2) - (SearchField.height/2)-100;
			
			var Result:TextFormat = new TextFormat;
			Result.font = 'HelveticaLight';
			Result.color = 0xFFFFFF;
			Result.size = 30;
			
			SearchResult.x = 20;
			SearchResult.y = 220;
			SearchResult.width = SearchField.width-50;
			SearchResult.visible=false;
			SearchResult.selectable=false;
			SearchResult.text = "Es wurden 5 Einträge gefunden!";
			SearchResult.setTextFormat(Result);
			SearchField.addChild(SearchResult);
			
			SearchPanel.x = 512 - (SearchPanel.width/2);
			SearchPanel.y = ((Background.height - Panel.height)/2) - (SearchPanel.height/2)-100;		
			
			SearchInput.x = 60;
			SearchInput.y = 135;
			SearchPanel.addChild(SearchInput);
			
			var Input:TextFormat = new TextFormat;
			Input.font = 'HelveticaLight';
			Input.color = 0x454545;
			Input.size = 24;
			
			SearchInputText.text="";
			SearchInputText.type = TextFieldType.INPUT;
			SearchInputText.defaultTextFormat = Input;
			SearchInputText.width = SearchInput.width;
			SearchInputText.height = SearchInput.height;
			SearchInputText.setTextFormat(Input);
			SearchInput.addChild(SearchInputText);
			
			SearchButton.x = 90 + SearchInput.width;
			SearchButton.y = 135;
			SearchPanel.addChild(SearchButton);
			SearchButton.addEventListener(MouseEvent.CLICK, Search);
			
			SearchExit.x = SearchPanel.width - 25;
			SearchExit.y = 5;
			SearchExit.width/=2;
			SearchExit.height/=2;
			SearchPanel.addChild(SearchExit);
			SearchExit.addEventListener(MouseEvent.CLICK, closeSearch);
			
			//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			
			Background.addChild(lightbox);
			Background.addChild(startscreen);
			
			//########################## M E N U ############################
			
			var format:TextFormat = new TextFormat();
            format.color = 0x333333;
            format.size = 24;
            format.font = 'HelveticaLight';
            

            
			Geschichte.x=20;
			Geschichte.y=20;
			Geschichte.stop();
			Geschichte.addEventListener(MouseEvent.CLICK, navigation);
			Geschichte.addEventListener(MouseEvent.MOUSE_OVER, hoverTxt);
			Geschichte.addEventListener(MouseEvent.MOUSE_OUT, UNhoverTxt);
			Panel.addChild(Geschichte);
			
			Klima.x = 60 + Geschichte.width;
			Klima.y = 20;
			Klima.stop();
			Klima.addEventListener(MouseEvent.CLICK, navigation);
			Klima.addEventListener(MouseEvent.MOUSE_OVER, hoverTxt);
			Klima.addEventListener(MouseEvent.MOUSE_OUT, UNhoverTxt);
			Panel.addChild(Klima);
			
			Evolution.x = 100 + Geschichte.width + Klima.width;
			Evolution.y = 20;
			Evolution.stop();
			Evolution.addEventListener(MouseEvent.CLICK, navigation);
			Evolution.addEventListener(MouseEvent.MOUSE_OVER, hoverTxt);
			Evolution.addEventListener(MouseEvent.MOUSE_OUT, UNhoverTxt);
			Panel.addChild(Evolution);
			
			Voelker.x = 140 + Geschichte.width + Klima.width + Evolution.width;
			Voelker.y = 20;
			Voelker.stop();
			Voelker.addEventListener(MouseEvent.CLICK, navigation);
			Voelker.addEventListener(MouseEvent.MOUSE_OVER, hoverTxt);
			Voelker.addEventListener(MouseEvent.MOUSE_OUT, UNhoverTxt);
			Panel.addChild(Voelker);
			
			//##############################################################


		

			var timer:Timer = new Timer(80, 30);
			timer.addEventListener(TimerEvent.TIMER, loading);
			timer.start();
			
			
			this.addEventListener("XML_LOADED", xmlLoaded);
			
			this.addEventListener("Slider_Moved", generator);

          	fieldArray["History"] = new theXML('History.xml', this);
           	fieldArray["Climate"] = new theXML('climateKopie.xml', this);
         	fieldArray["Evolution"] = new theXML('PreHistorics.xml',this);
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
			
			Tweener.addTween(lightbox,{alpha:0,visible:false,time:1,transition:"easeInOut"});
			
		
			if(complete) {
						
				Background.removeChild(startscreen);
				Map.visible=true;
				Panel.alpha=1;
				Panel.mouseChildren = true;

			}	
				
		}
		
		private function navigation(evt:MouseEvent):void{
			
							
				switch (evt.target.text)
	        	{
	        		case "Geschichte":
	            		oMap.alpha=1;
	            		prehisMap.visible = false;
	            		colorBG(0);
	            		Haasi = false;
	            		fArray["History"].getCoords();
	            		fArray["History"].generateDots();
	            		slider.contentLength = fArray["History"].lengthXML;
	            		currentField="History";
	            		Map.addChild(fArray["History"]);
	            		break;
	            	case "Klima":
	            		oMap.alpha=1;
	            		prehisMap.visible = false;
	            		colorBG(1);
	            		Haasi = false;
	            		fArray["Climate"].getCoords();
	            		fArray["Climate"].generateDots();
	            		slider.contentLength = fArray["Climate"].lengthXML;
	            		currentField="Climate";
	            		Map.addChild(fArray["Climate"]);
	            		break;
	            	case "Evolution":
	            		oMap.alpha=0;
	            		prehisMap.visible = true;
	            		colorBG(2);
	            		Haasi = true;
	            		fArray["Evolution"].getCoords();
	            		fArray["Evolution"].generateDots();
	            		slider.contentLength = fArray["Evolution"].lengthXML;
	            		currentField="Evolution";
	            		Map.addChild(fArray["Evolution"]);
	            		break;
	            	case "Völker":
	            		oMap.alpha=1;
	            		prehisMap.visible = false;
	            		colorBG(3);
	            		Haasi = false;
	            		fArray["People"].getCoords();
	            		fArray["People"].generateDots();
	            		slider.contentLength = fArray["People"].lengthXML;
	            		currentField="People";
	            		Map.addChild(fArray["People"]);
	            		break;
	            	default:
	            		
	            		break;
	        	}
		}
		
			
		public function generator(event:Event):void
		{	
			if(currentField != null) {
				
				fArray[currentField].position = slider._position;
				slider.year = fArray[currentField].year;
				fArray[currentField].showDot();
				if (Haasi == true)
				{
					prehisMap.x = (-1)*slider._position*450;
				}
			}
			else {
				
			}
			
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
			
			Map.addChild(SearchField);
			Map.addChild(SearchPanel);	
		}
		
		private function Search(evt:MouseEvent):void {
			
			var yyy:int = SearchPanel.y+SearchPanel.height-100;
			Tweener.addTween(SearchField,{y:yyy,time:2,transition:"easeInOut"});
			
			
			Tweener.addTween(SearchResult, {visible:true,time:3,transition:"easeInOut"});
			
		}
		
		
		
		private function closeSearch(evt:MouseEvent):void {
			
			SearchField.y = 101;
			Map.removeChild(SearchField);
			Map.removeChild(SearchPanel);
			SearchInputText.text="";
		}
		private function colorBG(i:int = 2):void //2 evolution schwarz
		{
			switch (i)
			{
				case 0: colorableBG.transform.colorTransform = new ColorTransform(0,0,0,1,159,173,147,0);
					break;
				case 1: colorableBG.transform.colorTransform = new ColorTransform(0,0,0,1,104,134,153,0);
					break;
				case 2: colorableBG.transform.colorTransform = new ColorTransform(0,0,0,1,0,0,0,0);
					break;
				case 3: colorableBG.transform.colorTransform = new ColorTransform(0,0,0,1,177,142,92,0);
					break;
				default: trace('need number in colorBG(i); function');
					break;
			}
		}
		private function hoverTxt(e:MouseEvent):void
		{
			e.target.gotoAndStop(2);
		}
		private function UNhoverTxt(e:MouseEvent):void
		{
			e.target.gotoAndStop(1);
		}
	}
}
