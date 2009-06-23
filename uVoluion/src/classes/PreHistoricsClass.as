package classes
{
	import caurina.transitions.Tweener;
	
	import fl.controls.Button;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.xml.*;
	

	public class PreHistoricsClass extends Sprite
	{
		private var dotArray:Array=new Array();
		private var coArray:Array= new Array([50, 50], [89, 90], [100,200], [300,200]);
		
		private var speechBaloon:MovieClip;
		private var generate_btn:Button;
		
		private var n:int = 0;
		
		private var _myXML:theXML = new theXML('PreHistorics.xml');
		
		private var _lengthXML:int;
		
		public function PreHistoricsClass():void
		{
			super();
			
			//generate_btn.addEventListener(MouseEvent.CLICK, generate);
			//generate_btn = new Button();
			//generate_btn.x = 1000;
			//generate_btn.y = 500;
			//this.addChild(generate_btn);
			
			speechBaloon = new Main_app_speechbaloon;
			speechBaloon.alpha = 0;
			speechBaloon.mouseChildren = true;
			speechBaloon.close_mc.addEventListener(MouseEvent.CLICK, removeBaloon);
			this.addChild(speechBaloon);
			
		}
		public function generate():void
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

		public function removeBaloon (evt:MouseEvent):void{
			this.removeChild(speechBaloon);
		}
		public function buttonHover(evt:MouseEvent):void{
			trace(evt.target.name);
			this.addChild(speechBaloon);
			speechBaloon.x=evt.target.x;
			speechBaloon.y=evt.target.y;
			Tweener.addTween(speechBaloon,{alpha:1,time:2,transition:"easeInOut"});
			n = parseInt(evt.target.name);
			Content();
		}
		// --------------------------------------
		// ---------------XML--------------------
		// --------------------------------------
		
		
				
		public function Content():void
		{
			speechBaloon.headline.text = _myXML.myXML..title[n].text();
			speechBaloon.subline.text = "Cycle: " + _myXML.myXML..cycle[n].text();
			speechBaloon.txt.text = _myXML.myXML..text[n].text();
			speechBaloon.era.text = "Era: " + _myXML.myXML..era[n].text();
			trace(n);
		}
		public function get lengthXML():int
		{
			_lengthXML = _myXML.myXML.Events.item.length();
			return _lengthXML;
		}
	}
}