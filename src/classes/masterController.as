/*
   masterController class
   Author: Michael Nelson
   Version: 1.0
   Modified: Today
   Copyright: Michael Nelson
   
   This class serves as the master controller behind Solaceon.
   It drives all other classes, and holds all system variables.
   
*/

class masterController extends Object{
   
   public var _gameTime:Array = new Array();
   private var _season:String;
   private var _sunFactor:Number;
   private var _yearDay:Number;
   
   public function masterController(){
      // reset all time variables to default values
      _gameTime.push(0); // current tick
      _gameTime.push(1); // current date
      _gameTime.push(1); // current month
      _gameTime.push(1); // current year
      _season = "Spring";
      _yearDay = 1;

      updateDisplay();
   }
   
   public function advanceTick(){
      // Advance time by one tick, and tell worldController to make
      // all tiles recalulate all their values
      _gameTime[0]++;
      advanceAllStates();
      
      // Check ticks, and convert to days, monthes, and years
      if(_gameTime[0] >= 32) {
         _gameTime[0] = 0;
         _gameTime[1]++;
         _yearDay++;
         advanceAllDays();
         if(_gameTime[1] >= 32) {
            _gameTime[1] = 1;
            _gameTime[2]++;
            switch(_gameTime[2]) {
               case 4 :
                  _season = "Summer";
                  break;
               case 7 :
                  _season = "Fall";
                  break;
               case 10 :
                  _season = "Winter";
                  break;
               case 1 :
                  _season = "Spring";
                  break;
               default :
                  break;
            }
            if(_gameTime[2] >= 13) {
               _gameTime[2] = 1;
               _gameTime[3]++;
               _yearDay = 1;
            }
         }
      }
      updateDisplay();
   }
   /** Define method to send time variables to the display window */
   private function updateDisplay(){
      _root.bar.date.tickBox.text = _gameTime[0];
      _root.bar.date.dayBox.text = _gameTime[1];
      _root.bar.date.monthBox.text = _gameTime[2];
      _root.bar.date.yearBox.text = _gameTime[3];
      _root.bar.date.seasonBox.text = _season;
   }
   
   private function advanceAllStates(){
      _root.world.advanceState();
   }
   
   private function advanceAllDays(){
      _root.world.advanceDay();
   }
   
   public function get season():String{
      return this._season;
   }
   public function set season(value:String):Void{
      this._season = value;
   }
}