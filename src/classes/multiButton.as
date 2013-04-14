/*
   multiButton class
   Author: Michael Nelson
   Version: 1.0
   Modified: 6/30/09
   Copyright: Michael Nelson
   
   This class describes a button that changes which picture is on it,
   as well as funciton.
   
*/

class multiButton extends MovieClip{
   
   private var _disabled:Boolean;
   
   public function multiButton(){
      _disabled = false;
      
      this.gotoAndStop(1);
      
      this.onPress = function(){
         if(!_disabled){
            advanceState();
         }
      }
   }
   
   private function advanceState(){
      if((_currentframe + 1) > this._totalframes){
         gotoAndStop(1);
      } else {
         gotoAndStop(_currentframe + 1);
      }
   }
   
   public function enableItem(){
      _disabled = false;
      this["disabler"]._alpha = 0;
   }
   
   public function disableItem(){
      _disabled = true;
      this["disabler"]._alpha = 100;
   }
}