package classes
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Slider extends Sprite
	{	
		
		private var xOffset:Number;
		private var xMin:Number;
		private var xMax:Number;
		private var oTrack:track = new track();
		private var oThumb:thumb = new thumb();
		
		public function Slider()
		{
			
			xMin = 0;
			xMax = oTrack.width;
			
			oTrack.x = 50;
			oTrack.y = 50;
			this.addChild(oTrack);
			
			oThumb.x = 0;
			oThumb.y = 0;
			oTrack.addChild(oThumb);
			
			oThumb.addEventListener(MouseEvent.MOUSE_DOWN, thumbDown);
			
			
			this.addEventListener(MouseEvent.MOUSE_UP, thumbUp);
			
		}
		
		public function thumbDown(evt:MouseEvent):void 
		{
			
			this.addEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
			xOffset = this.mouseX - oThumb.x;
			
		}
		
		public function thumbUp(evt:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
		}
		
		public function thumbMove(evt:MouseEvent):void
		{
			oThumb.x = this.mouseX - xOffset;
			
			if(oThumb.x <= xMin)
				oThumb.x = xMin;
				
			if(oThumb.x >= xMax)
				oThumb.x = xMax;
	
	
			
			evt.updateAfterEvent();	
		}
		

	}
}