import Toybox.Attention;
import Toybox.System;
import Toybox.Lang;
class AlertsManager {
    
    // Function to trigger vibration with intensity and duration
    static function triggerVibration(intensity as Number, duration as Number) as Void {
        var vibeProfile = new Attention.VibeProfile(intensity, duration);
        Attention.vibrate([vibeProfile]);
       // System.println("AlertsManager.mc --- Vibration triggered: Intensity: " + intensity + ", Duration: " + duration);
    }

    // Function for alert with default vibration
    static function triggerDefaultAlert() as Void {
        triggerVibration(50, 2000);  // Default 100ms intensity, 500ms duration
    }
}
