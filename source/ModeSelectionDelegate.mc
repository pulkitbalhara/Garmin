import Toybox.WatchUi;
import Toybox.System;
import Toybox.Lang;

class ModeSelectionDelegate extends WatchUi.MenuInputDelegate {
    hidden var _view;  // Store the view reference
    var selectedMode = 1;

    // Constructor that takes the view as an argument
    function initialize(view) {
        MenuInputDelegate.initialize();
        _view = view;  // Store the view reference
        //System.println("ModeSelectionDelegate.mc --- Delegate initialized");
    }

    // Handle mode selection menu item and print the selected mode
    function onMenuItem(item as Symbol) as Void {
        //System.println("ModeSelectionDelegate.mc --- onMenuItem triggered with: " + item);

        
        if (item == :mode_1) {
            selectedMode = 1;  // Set Work Mode
            //System.println("ModeSelectionDelegate.mc --- Mode set to Work");
        } else if (item == :mode_2) {
            selectedMode = 2;  // Set Outdoor Mode
            //System.println("ModeSelectionDelegate.mc --- Mode set to Outdoor");
        } else if (item == :mode_3) {
            selectedMode = 3;  // Set Learning Mode
            //System.println("ModeSelectionDelegate.mc --- Mode set to Learning");
        } else if (item == :mode_4) {
            selectedMode = 4;  // Set Miscellaneous Mode
            //System.println("ModeSelectionDelegate.mc --- Mode set to Miscellaneous");
        }

        // Save the selected mode to DataManager
        DataManager.setMode(selectedMode);

        // Update the UI with the new mode
        _view.setModeType(selectedMode);
        //System.println("ModeSelectionDelegate.mc --- UI updated with new mode");

        // Pop the view to return to the main menu
        WatchUi.popView(WatchUi.SLIDE_DOWN);  
    }
}
