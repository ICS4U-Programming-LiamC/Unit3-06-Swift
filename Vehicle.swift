//
//  Vehicle.swift
//
//  Created by Liam Csiffary
//  Created on 2022-05-18
//  Version 1.0
//  Copyright (c) 2022 IMH. All rights reserved.
//
//  This program creates a vehicle class with properties: licence plate, acclerate, brake
//  setSpeed, getSpeed, getmaxSpeed, getPlate, getInfo


public class Vehicle {
  // define properties
  internal var licencePlate = ""
  internal var colour = ""
  internal var numDoors = 4
  internal var maxSpeed: Float = 200
  internal var speed: Float = 0.0

  // initialize properies
  init(_ licencePlate: String, _ colour: String, _ numDoors: Int, _ speed: Float, _ maxSpeed: Float) {
    self.licencePlate = licencePlate
    self.colour = colour
    self.numDoors = numDoors
    self.speed = speed
    self.maxSpeed = maxSpeed
  }

  // adds increment to the speed
  internal func accelerate(_ inc: Float) {
    self.speed += inc
  }

  // removes increment from the speed
  internal func brake(_ inc: Float) {
    self.speed -= inc
  }

  // sets the speed
  internal func setSpeed(_ speed: Float) {
    self.speed = speed
  }

  // returns the speed
  internal func getSpeed() -> Float {
    return speed
  }

  // returns the maxSpeed
  internal func getMaxSpeed() -> Float {
    return maxSpeed
  }

  // returns the plate
  internal func getPlate() -> String {
    return licencePlate
  }

  // prints all info about the vehicle
  internal func getInfo() {
    print("Licence plate:", licencePlate)
    print("Colour:", colour)
    print("Number of doors:", numDoors)
    print("Speed:", speed)
    print("Max speed:", maxSpeed)
  }
}


//
//  VehicleEditor.swift
//
//  Created by Liam Csiffary
//  Created on 2022-05-18
//  Version 1.0
//  Copyright (c) 2022 IMH. All rights reserved.
//
//  This program allows for the mutation of vehicles

// gets the index of the vehicle to edit or delete
// depending on where the code was run from
public func getVehicle(_ veList: [Vehicle]) -> Int {

  // prints the possible vehicles to edit
  while (true) {
    print("Which vehicle would you like to edit/delete?")
    for (i, _) in veList.enumerated() {
      if (veList.count < i) {
        print(veList[i].getPlate() + ", ")
      } else {
        print("or", veList[i].getPlate())
      }
    }

    // gets the plate of the vehicle to edit
    var userInput = readLine()!
    userInput = userInput.lowercased()

    // if one of the vehicles matches the users input return the index
    // of that vehicle
    for (i, _) in veList.enumerated() {
      if (userInput == veList[i].getPlate().lowercased()) {
        return i
      }
    }
    // if the users input did not match any plate
    print("No vehicle goes by that plate")
  }
}

// main
public func main() {
  // defines the default vehicles
  var vehicles: [Vehicle] = []
  vehicles.append(Vehicle("CTHH 112", "Gray", 4, 0, 180));
  vehicles.append(Vehicle("CCHM 983", "Pink", 4, 0, 175));

  // initial print of vehicles
  for car in vehicles {
    car.getInfo()
    print()
  }

  // asks the user whether to move, view, add, or delete a vehicle
  var userInput = ""
  while (true) {
    print("Would you like to move these cars? (y/n) or view cars? (view)")
    print("Input 'new' to create a car and 'delete' to remove one")
    userInput = readLine()!.lowercased()

    // if the user wants to move a vehicle
    if (userInput == "y") {
      var whichV = 0

      // gets the vehicle to move, moved to a funtion as it got pretty complicated
      // copied from old code
      whichV = getVehicle(vehicles) //////////////////////////////////////////////////
      print("You are moving " + vehicles[whichV].getPlate())

      // asks the user whether they want to accelerate or decelerate the vehicle
      while (true) {
        print("\nWould you like to accelerate or brake?")
        print("Input done/exit to stop moving the vehicle.")

        userInput = readLine()!.lowercased()

        // if accelerate
        if (userInput == "accelerate" || userInput == "a") {
          // makes sure the car isn't already going at maximum speed
          if (vehicles[whichV].getSpeed() == vehicles[whichV].getMaxSpeed()) {
            print("The vehicle is already going as fast as it can")

            // otherwise
          } else {
            // gets how much to accelerate the vehicle by
            var userInputFloat: Float = 0
            while (true) {
              print("How much would you like to accelerate the vehicle by?");
              userInput = readLine()!
              userInputFloat = Float(userInput) ?? -1
              if (userInputFloat < 0) {
                print("You must input a positive number")
              } else {
                break
              }
            }
            // if the number they inputed would push the car over its max speed
            if (vehicles[whichV].getSpeed() + userInputFloat > vehicles[whichV].getMaxSpeed()) {

              print("You put the petal to the metal, you are now going"
                  , vehicles[whichV].getMaxSpeed())
              vehicles[whichV].setSpeed(vehicles[whichV].getMaxSpeed())

              // otherwise accelerate the vehicle by that ammount
            } else {
              vehicles[whichV].accelerate(userInputFloat)
              print("\nAccelerated the vehicle by", userInputFloat)
            }
          }

          // if the user wants to brake
        } else if (userInput == "brake" || userInput == "b") {
          // make sure the vehicle isn't already stopped
          if (vehicles[whichV].getSpeed() == 0) {
            print("You press harder on the brake pedal, however the vehicle is already stopped")
          } else {
            // gets how much to decelerate by
            var userInputFloat: Float = 0
            while (true) {
              print("How much would you like to decelerate the vehicle by?")
              userInput = readLine()!
              userInputFloat = Float(userInput) ?? -1
              if (userInputFloat < 0) {
                print("You must input a positive number")
              } else {
                break
              }
            }
            // if the inputed number would not stop the vehicle
            if (vehicles[whichV].getSpeed() - userInputFloat > 0) {
              vehicles[whichV].brake(userInputFloat)
              print("\ndecelerated the vehicle by", userInputFloat)

              // if it would
            } else {
              vehicles[whichV].setSpeed(0)
              print("The car comes to a halt")
            }
          }

          // if the user is done moving the vehicle
        } else if (userInput == "done" || userInput == "exit"
            || userInput == "e" || userInput == "d") {
          break

        } else {
          print("Not a valid input")
        }
      }

      // if the user does not want to make changes
    } else if (userInput == "n") {
      print("You are not moving any cars");
      break

      // displays all vehicles and their information
    } else if (userInput == "view") {
      for (i, each) in vehicles.enumerated() {
        print("\nVehicle #" + String(i + 1));
        each.getInfo();
      }

      // vehicle creator
    } else if (userInput == "new" || userInput == "create") {

      // gets all necessary inputs from the user, then creates a vehicle object
      // it then adds this vehicle to the list of other vehicles
      print("\nLicence plate: ", terminator: "");
      let plate = readLine()!

      print("Colour: ", terminator: "")
      let colour = readLine()!

      // initialize the variables that are in the while loops
      var doors: Int = 0
      var speed: Float = 0
      var maxSpeed: Float = 0

      // gets number of doors
      while (true) {
        print("Number of doors: ", terminator: "");
        let stringDoors = readLine()!
        doors = Int(stringDoors) ?? -1
        if (doors > 0) {
          break
        } else {
          print("Please input a natural number for number of doors")
        }
      }

      // gets the speed of the car
      while (true) {
        print("Current speed of car: ", terminator: "")
        let speedString = readLine()!
        speed = Float(speedString) ?? -1
        if (speed >= 0) {
          break
        } else {
          print("Please input a positive number for speed");
        }
      }

      // gets the vehicle max speed. If the user inputs a max speed less than the
      // current speed
      // twice then the max speed with overwrite the current speed.
      var counter = 0;
      while (true) {
        print("Max speed of car: ", terminator: "");
        let maxSpeedString = readLine()!
        maxSpeed = Float(maxSpeedString) ?? -1
        if (maxSpeed >= 0) {
          if (maxSpeed < speed) {
            if (counter == 0) {
              print("Your max speed can not be more than the current speed \n"
                  + "If you input a lesser max speed again the current speed of the \n"
                  + "Vehicle will be set to that speed along with the max speed")
            } else {
              speed = maxSpeed
              print("Current speed set to max speed")
              break
            }
            counter += 1

          } else {
            break
          }
        } else {
          print("Please input a positive number for max speed")
        }
      }
      print()

      // creates the vehicle and adds it to the list of vehicles
      let tempVehicle = Vehicle(plate, colour, doors, speed, maxSpeed)
      vehicles.append(tempVehicle)

      // deletes the requested student from the list of students
    } else if (userInput == "delete" || userInput == "remove") {
      let carDelete = getVehicle(vehicles)
      vehicles.remove(at: carDelete)

    } else {
      print("Please enter either 'y' or 'n'")
    }
  }
}

main()