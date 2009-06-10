package classes
{
	import caurina.transitions.Tweener;
	
	import fl.controls.Button;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class DotGeneration extends Sprite
	{
		private var dotArray:Array=new Array();
		private var coArray:Array= new Array([241, 431], [444, 488], [800,600], [700,320]);
		
		private var speechBaloon:MovieClip;
		private var generate_btn:Button;
		
		public function DotGeneration()
		{
			super();
			
			generate_btn.addEventListener(MouseEvent.CLICK, generate);
			generate_btn.x = 1000;
			generate_btn.y = 750;
			this.addChild(generate_btn);
			
			speechBaloon = new Main_app_speechbaloon;
			speechBaloon.alpha = 0;
			speechBaloon.mouseChildren = true;
			speechBaloon.close_mc.addEventListener(MouseEvent.CLICK, alf);
			this.addChild(speechBaloon);
		public function generate(event:MouseEvent):void
		{
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
				clip.addEventListener(MouseEvent.MOUSE_OVER, buttonHover);
			}
		}

		public function alf (evt:MouseEvent):void{
			trace("alpha = 0");
			Tweener.addTween(speechBaloon,{alpha:0,time:0.3,transition:"linear"});
		}
		public function buttonHover(evt:MouseEvent):void{
			trace(evt.target.name);
			speechBaloon.x=evt.target.x;
			speechBaloon.y=evt.target.y;
			Tweener.addTween(speechBaloon,{alpha:1,time:2,transition:"easeInOut"});
			n = parseInt(evt.target.name);
			cycleDis();
		}