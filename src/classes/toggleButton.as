/*
   toggleButton class
   author: Michael Nelson
   version: 1.0n
   modified: 6/30/2009
   copyright: Michael Nelson
   
   A class to define a button that turns on and off.

*/

class toggleButton extends MovieClip {
   
   //variables
   private var _wasClicked:Boolean = false;
   
   //constructor
   public function toggleButton() {
      this.gotoAndStop(1);
      
      this.onPress = function() {
         this.toggleNext();
      }
   }
   
   //methods
   public function toggleNext(){
      if(!this._wasClicked) {
         this._wasClicked = true;
         this.gotoAndStop(2);
         this.toggleOn();
      } else {
         this._wasClicked = false;
         this.gotoAndStop(1);
         this.toggleOff();
      }
   }
   
   public function toggleOn() {
   }
   
   public function toggleOff() {
   }
   //getter/setters
   
}