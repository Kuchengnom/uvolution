package classes
{
	import caurina.transitions.Tweener;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.*;
	
	public class Slider extends Sprite
	{	
		
		private var xOffset:Number;
		private var xMin:Number;
		private var xMax:Number;
		private var xTarget:Number;
		private var oTrack:track = new track;
		private var oThumb:thumb = new thumb;
		//private var oTrack:Screen_Slider_Timeline = new Screen_Slider_Timeline;
		//private var oThumb:Screen_Slider_Slider = new Screen_Slider_Slider;
		
		public var _position:int;
		public var _contentLength:int;
		private var percental:int;
		private var event:int;
		
		private var _Dispatcher:DisplayObject;
		
		
		
		public function Slider(dispatcher:DisplayObject)
		{
			
			_Dispatcher = dispatcher;
			
			xMin = 0;
			xMax = oTrack.width;
			
			oTrack.x = 20;
			oTrack.y = 80;
			this.addChild(oTrack);
			
			oThumb.x = 0;
			oThumb.y = 0;
			oTrack.addChild(oThumb);
			
			oThumb.addEventListener(MouseEvent.MOUSE_DOWN, thumbDown);
			
			oTrack.addEventListener(MouseEvent.CLICK, moveThumb);
			
			this.addEventListener(MouseEvent.MOUSE_UP, thumbUp);
			
	
			
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
	
			//trace(oThumb.x);
		
			trace(Math.floor(oThumb.x/percental));
			_position = Math.floor(oThumb.x/percental);
			
			this.dispatchEvent(new Event("Slider_Moved", true));
			
			
			evt.updateAfterEvent();	
		}
		
		private function moveThumb(evt:MouseEvent):void
		{	
			xTarget = this.mouseX-xOffset;
			
			if(xTarget <= xMin)
				oThumb.x = xMin;
				
			if(xTarget >= xMax)
				oThumb.x = xMax;
			
			Tweener.addTween(oThumb, {x:xTarget, time:0.8, transition:"easeOutCubic"});
			
			//trace(contentLength);
			trace(Math.floor(xTarget/percental));
			_position = Math.floor(xTarget/percental);
			this.dispatchEvent(new Event("Slider_Moved", true));
			//trace(xTarget);
		}
		
		public function set contentLength(length:int):void {
			
			_contentLength = length;
			
			percental = oTrack.width / _contentLength;
			event = oThumb.x / percental;
		}
		
		
		public function get position():int {
			
			return _position;
		}
		
		

	}
}