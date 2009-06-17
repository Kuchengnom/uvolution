package classes
{
	import caurina.transitions.Tweener;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Slider extends Sprite
	{	
		
		private var xOffset:Number;
		private var xMin:Number;
		private var xMax:Number;
		private var xTarget:Number;
		private var oTrack:track = new track();
		private var oThumb:thumb = new thumb();
		private var contentLength:int;
		
		private var oDots:DotGeneration = new DotGeneration;
		
		public function Slider()
		{
			
			xMin = 0;
			xMax = oTrack.width;
			
			oTrack.x = 3*16;
			oTrack.y = 45*16;
			this.addChild(oTrack);
			
			oThumb.x = 0;
			oThumb.y = 0;
			oTrack.addChild(oThumb);
			
			oThumb.addEventListener(MouseEvent.MOUSE_DOWN, thumbDown);
			
			oTrack.addEventListener(MouseEvent.CLICK, moveThumb);
			
			this.addEventListener(MouseEvent.MOUSE_UP, thumbUp);
			
			contentLength = oDots.lengthXML;
			
		}
		

		
		private function thumbDown(evt:MouseEvent):void 
		{
			
			this.addEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
			xOffset = this.mouseX - oThumb.x;
			
		}
		
		private function thumbUp(evt:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
		}
		
		private function thumbMove(evt:MouseEvent):void
		{
			oThumb.x = this.mouseX - xOffset;
			
			if(oThumb.x <= xMin)
				oThumb.x = xMin;
				
			if(oThumb.x >= xMax)
				oThumb.x = xMax;
	
	
			evt.updateAfterEvent();	
		}
		
		private function moveThumb(evt:MouseEvent):void
		{	
			xTarget = this.mouseX-xOffset;
			
			Tweener.addTween(oThumb, {x:xTarget, time:0.8, transition:"easeOutCubic"});
			
			trace(contentLength);
		}

	}
}