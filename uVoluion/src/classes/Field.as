package classes
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Field extends Sprite
	{
		
		private var speechBubble:MovieClip;
		private var _n:int=0;
		
		public function Field()
		{
			
			speechBubble = new Main_app_speechbaloon;
			speechBubble.mouseChildren = true;
			speechBubble.close_mc.addEventListener(MouseEvent.CLICK, closeSpeechBubble);
			
		}
		
		
		private function generateDots():void {
			
			
				trace(coArray);
			
			for(var i:int=0;i<4;i++)
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
		
		private function showSpeechBubble(evt:MouseEvent):void {
			
				trace(evt.target.name);
					
			this.addChild(speechBubble);
			speechBubble.x=evt.target.x;
			speechBubble.y=evt.target.y;
			Tweener.addTween(speechBubble,{alpha:1,time:2,transition:"easeInOut"});
			_n = parseInt(evt.target.name);
			setContent();
		}
		
		private function closeSpeechBubble(evt:MouseEvent):void {
			
			this.removeChild(speechBubble)
		}
		
		private function setContent():void {
			
			speechBubble.headline.text = _myXML.myXML..title[_n].text();
			speechBubble.subline.text = "Cycle: " + _myXML.myXML..cycle[_n].text();
			speechBubble.txt.text = _myXML.myXML..text[_n].text();
			speechBubble.era.text = "Era: " + _myXML.myXML..era[_n].text();
			trace(_n);
		}

	}
}