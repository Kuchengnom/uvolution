package classes
{	
	import caurina.transitions.Tweener;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Field extends Sprite
	{
		
		public var _myXML:theXML;
		public var _lengthXML:int;
		public var _Slider:Slider;
		public var _Position:int=0;
		
		public var speechBubble:MovieClip;
		public var _n:int=0;
		public var itemID:int;
		
		public var dotArray:Array = new Array();
		public var coArray:Array = new Array();
		
	
		
		
		public function Field()
		{	
			

			speechBubble = new Screen_Speechbaloon;
			speechBubble.mouseChildren = true;
			
			
	
			speechBubble.addEventListener(MouseEvent.CLICK, closeSpeechBubble);
	
		
		}
		
		
		public function getCoords():void {
			

			for(var j:int=0;j<_myXML.myXML.Events.item.length();j++) { 
			
				coArray[j]=_myXML.myXML..coordinates[j].text().split(", ");
				trace("coarray["+j+"][0]: "+coArray[j][0]);
				trace("coarray["+j+"][1]: "+coArray[j][1]);
				
			}
			
			//_Slider._contentLength = _myXML.myXML.Events.item.length();
			
		}
		
		
		public function generateDots():void {
			
			//_Position = _Slider._position
		
	
				trace("coArray:"+coArray);
				

			for(var i:int=0;i<_myXML.myXML.Events.item.length();i++)
			{
				var clip:MovieClip=new MovieClip();
				clip.graphics.beginFill(0x996600,1);
				clip.graphics.drawCircle(2,2,8);
				clip.graphics.endFill();
				clip.name = i.toString();
				//trace(clip.name);
				this.addChild(clip);
				dotArray.push(clip);
				clip.x=coArray[i][0];
				clip.y=coArray[i][1];
				clip.addEventListener(MouseEvent.MOUSE_OVER, showSpeechBubble);
			}
			
			
		}
		
		public function showSpeechBubble(evt:MouseEvent):void {
			
				//trace(evt.target.name);
					
			this.addChild(speechBubble);
			speechBubble.x=evt.target.x - (speechBubble.width/2);
			speechBubble.y=evt.target.y - speechBubble.height;
			Tweener.addTween(speechBubble,{alpha:1,time:2,transition:"easeInOut"});
			_n = parseInt(evt.target.name);
			setContent();
			//trace(this.lengthXML);
		}
		
		public function closeSpeechBubble(evt:MouseEvent):void {
			
			this.removeChild(speechBubble)
		}
		
		public function setContent():void {
			trace(_myXML);
			trace("ausgewaehlt: "+_n);
			trace("item anzahl: "+_myXML.myXML.Events.item.length());
			
			speechBubble.Headline.text = _myXML.myXML..title[_n].text();
			speechBubble.Subline.text = _myXML.myXML..description[_n].text();
			speechBubble.Text.text = _myXML.myXML..text[_n].text();
			speechBubble.Date.text = _myXML.myXML..date[_n].text();
			
		}
		
		
		public function get lengthXML():int
		{
			trace("length", _myXML);	
			_lengthXML = _myXML.myXML.Events.item.length();
		
			return _lengthXML;
		}
		
	}
}