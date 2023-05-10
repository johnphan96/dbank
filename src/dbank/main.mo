import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Int "mo:base/Int";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  stable var startTime = Time.now();
  startTime := Time.now();

  stable var currentValue : Float = 300;
  currentValue := 300;
  Debug.print(debug_show (startTime));
  Debug.print(debug_show (currentValue));

  public func topUp(amount : Float) {
    currentValue += amount;
    Debug.print(debug_show (currentValue));
  };

  // Allows users to withdraw() an amount from the currentValue. Decrease the currentValue by amount
  public func withdraw(amount : Float) {
    let temp : Float = currentValue - amount;
    if (temp >= 0) {
      currentValue -= amount;
      Debug.print(debug_show (currentValue));
    } else {
      Debug.print("Amount too large, currentValue less than zero.");
    };
  };

  // Query function to check balance. Query functions are normally faster than fuctions that update
  public query func checkBalance() : async Float {
    return currentValue;
  };

  public func compound() {
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime;
    let timeElapsedS = timeElapsedNS / 1000000000;

    // Compound interest. Interest = 1% / second.
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS));
    startTime := currentTime;
  };
};
