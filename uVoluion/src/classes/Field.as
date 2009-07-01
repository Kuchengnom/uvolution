package classes
{	
	import caurina.transitions.Tweener;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Field extends Sprite
	{
		
		public var _myXML:theXML;
		public var _lengthXML:int;
		public var _Slider:Slider;
		
		public var speechBubble:MovieClip;
		public var _n:int=0;
		
		public var dotArray:Array = new Array();
		public var coArray:Array = new Array([50, 50], [89, 90], [100,200], [300,200]);
		
	
		
		
		public function Field()
		{	
			
			speechBubble = new Main_app_speechbaloon;
			speechBubble.mouseChildren = true;
			speechBubble.close_mc.addEventListener(MouseEvent.CLICK, closeSpeechBubble);
			
			
			//this.getCoords();
		}
		
		/*
		public function getCoords():void {
			

			for(var j:int=0;j<_lengthXML;j++){     //_myXML.myXML.length()
			
				coArray[j]=[_myXML.myXML..coordinates[j].text()];
				trace("coarray["+j+"]: "+coArray[j]);
			}
			
			
		}
		*/
		
		public function generateDots():void {
			
			
				trace("coArray:"+coArray);
			
			for(var i:int=0;i<4;i++)
			{
				var clip:MovieClip=new MovieClip();
				clip.graphics.beginFill(0x996600,1);
				clip.graphics.drawCircle(2,2,8);
				clip.graphics.endFill();
				clip.name = i.toString();
				trace(clip.name);
				this.addChild(clip);
				dotArray.push(clip);
				clip.x=coArray[i][0];
				clip.y=coArray[i][1];
				clip.addEventListener(MouseEvent.MOUSE_OVER, showSpeechBubble);
			}
			
		}
		
		public function showSpeechBubble(evt:MouseEvent):void {
			
				trace(evt.target.name);
					
			this.addChild(speechBubble);
			speechBubble.x=evt.target.x;
			speechBubble.y=evt.target.y;
			Tweener.addTween(speechBubble,{alpha:1,time:2,transition:"easeInOut"});
			_n = parseInt(evt.target.name);
			setContent();
			trace(this.lengthXML);
		}
		
		public function closeSpeechBubble(evt:MouseEvent):void {
			
			this.removeChild(speechBubble)
		}
		
		public function setContent():void {
			trace(_myXML);
			trace("ausgewaehlt: "+_n);
			trace("item anzahl: "+_myXML.myXML.Events.item.length());
			//_Slider._contentLength = _myXML.myXML.Evens.item.length();
			speechBubble.headline.text = _myXML.myXML..title[_n].text();
			//speechBubble.subline.text = "Cycle: " + _myXML.myXML..cycle[_n].text();
			speechBubble.txt.text = _myXML.myXML..text[_n].text();
			//speechBubble.era.text = "Era: " + _myXML.myXML..era[_n].text();
			
		}
		
		
		public function get lengthXML():int
		{
			trace("length", _myXML);	
			_lengthXML = _myXML.myXML.Events.item.length();
		
			return _lengthXML;
		}
		
	}
}