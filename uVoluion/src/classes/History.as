package classes
{
	
	

	public class History extends Field
	{
		
		
		
		public function History()
		{
			
			super();
			
			_myXML = new theXML('PreHistorics.xml', this);
		
		}
		
		/*
		public function get lengthXML():int
		{
			_lengthXML = _myXML.myXML.Events.item.length();
			return _lengthXML;
		}
		*/
	}
}