/*
   pullBar class
   author: Michael Nelson
   version: 1.0
   modified: 6/16/2009
   copyright: Michael Nelson
   
   A simple class to define the title bar of windows. Currently,
   it's only used to make the window draggable.

*/

// class declaration
class pullBar extends MovieClip {
   
   // no variables
   
   // constructor statement; defines the event handles: starts dragging
   // parent movie clip when it is clicked, and stops dragging when it
   // is released
     
   public function pullBar() {
      
      this.onRollOver = function() {
         _root.mouse_mc.switchCursor("hand");
      }
      
      this.onRollOut = function() {
         _root.mouse_mc.switchCursor("arrow");
      }
      
      this.onPress = function() {
         _parent.startDrag(false);
      }
      this.onRelease = function() {
         _parent.stopDrag();
      }
   }
}