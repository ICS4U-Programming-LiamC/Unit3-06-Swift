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

public class Truck: Vehicle {
  
}

public class Bike: Vehicle {
  internal var name = ""
  init(_ name: String, _ colour: String, _ speed: Float, _ maxSpeed: Float) {
    self.name = name
    super.init(name, colour, 0, speed, maxSpeed)
  }

  internal func getName() -> String {
    return name
  }

  override internal func getInfo() {
    print("Name:", name)
    print("Colour:", colour)
    print("Speed:", speed)
    print("Max speed:", maxSpeed)
  }
}

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
    for (i, each) in veList.enumerated() {
      if (veList.count < i) {
        print(each.getPlate() + ", ")
      } else {
        print("or", each.getPlate())
      }
    }

    // gets the plate of the vehicle to edit
    var userInput = readLine()!
    userInput = userInput.lowercased()

    // if one of the vehicles matches the users input return the index
    // of that vehicle
    for (i, each) in veList.enumerated() {
      if (userInput == each.getPlate().lowercased()) {
        return i
      }
    }
    // if the users input did not match any plate
    print("No vehicle goes by that plate")
  }
}

public func getTruck(_ veList: [Truck]) -> Int {

  // prints the possible vehicles to edit
  while (true) {
    if (veList.count == 0) {
      print("There are no trucks to edit, create a new one")
      return -1
    } else {
      print("Which truck would you like to edit/delete?")
      if (veList.count == 1) {
        print(veList[0].getPlate())
      } else {
        for (i, each) in veList.enumerated() {
          if (veList.count < i) {
            print(each.getPlate() + ", ")
          } else {
            print("or", each.getPlate())
          }
        }
      }
    }

    // gets the plate of the vehicle to edit
    var userInput = readLine()!
    userInput = userInput.lowercased()

    // if one of the vehicles matches the users input return the index
    // of that vehicle
    for (i, each) in veList.enumerated() {
      if (userInput == each.getPlate().lowercased()) {
        return i
      }
    }
    // if the users input did not match any plate
    print("No vehicle goes by that plate")
  }
}

public func getBike(_ veList: [Bike]) -> Int {

  // prints the possible vehicles to edit
  while (true) {
    if (veList.count == 0) {
      return -1
    } else {
      print("Which bike would you like to edit/delete?")
      if (veList.count == 1) {
        print(veList[0].getName())
      } else {
        for (i, each) in veList.enumerated() {
          if (veList.count < i) {
            print(each.getName() + ", ")
          } else {
            print("or", each.getName())
          }
        }
      }
    }

    // gets the plate of the vehicle to edit
    var userInput = readLine()!
    userInput = userInput.lowercased()

    // if one of the vehicles matches the users input return the index
    // of that vehicle
    for (i, each) in veList.enumerated() {
      if (userInput == each.getName().lowercased()) {
        return i
      }
    }
    // if the users input did not match any plate
    print("No vehicle goes by that plate")
  }
}

public func truckEditor(_ passedArray: [Truck]) -> [Truck] {
  var vehicles: [Truck] = passedArray
  // asks the user whether to move, view, add, or delete a vehicle
  var userInput = ""
  while (true) {
    print("Would you like to move these trucks? (y/n) or view the trucks? (view)")
    print("Input 'new' to create a truck and 'delete' to remove one")
    userInput = readLine()!.lowercased()

    // if the user wants to move a vehicle
    if (userInput == "y") {
      var whichV = 0

      // gets the vehicle to move, moved to a funtion as it got pretty complicated
      // copied from old code
      whichV = getTruck(vehicles) //////////////////////////////////////////////////
      if (whichV == -1) {
        break
      }
      print("You are moving " + vehicles[whichV].getPlate())

      // asks the user whether they want to accelerate or decelerate the vehicle
      while (true) {
        print("\nWould you like to accelerate or brake?")
        print("Input done/exit to stop moving the truck.")

        userInput = readLine()!.lowercased()

        // if accelerate
        if (userInput == "accelerate" || userInput == "a") {
          // makes sure the car isn't already going at maximum speed
          if (vehicles[whichV].getSpeed() == vehicles[whichV].getMaxSpeed()) {
            print("The truck is already going as fast as it can")

            // otherwise
          } else {
            // gets how much to accelerate the vehicle by
            var userInputFloat: Float = 0
            while (true) {
              print("How much would you like to accelerate the truck by?");
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
              print("\nAccelerated the truck by", userInputFloat)
            }
          }

          // if the user wants to brake
        } else if (userInput == "brake" || userInput == "b") {
          // make sure the vehicle isn't already stopped
          if (vehicles[whichV].getSpeed() == 0) {
            print("You press harder on the brake pedal, however the truck is already stopped")
          } else {
            // gets how much to decelerate by
            var userInputFloat: Float = 0
            while (true) {
              print("How much would you like to decelerate the truck by?")
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
              print("\ndecelerated the truck by", userInputFloat)

              // if it would
            } else {
              vehicles[whichV].setSpeed(0)
              print("The truck comes to a halt")
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
      print("You are not moving any trucks");
      return vehicles

      // displays all vehicles and their information
    } else if (userInput == "view") {
      for (i, each) in vehicles.enumerated() {
        print("\nTruck #" + String(i + 1));
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
        print("Current speed of truck: ", terminator: "")
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
        print("Max speed of truck: ", terminator: "");
        let maxSpeedString = readLine()!
        maxSpeed = Float(maxSpeedString) ?? -1
        if (maxSpeed >= 0) {
          if (maxSpeed < speed) {
            if (counter == 0) {
              print("Your max speed can not be more than the current speed \n"
                  + "If you input a lesser max speed again the current speed of the \n"
                  + "truck will be set to that speed along with the max speed")
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
      vehicles.append(Truck(plate, colour, doors, speed, maxSpeed))

      // deletes the requested student from the list of students
    } else if (userInput == "delete" || userInput == "remove") {
      let carDelete = getVehicle(vehicles)
      vehicles.remove(at: carDelete)

    } else {
      print("Please enter either 'y' or 'n'")
    }
  }
}

public func bikeEditor(_ passedArray: [Bike]) -> [Bike] {
  var vehicles: [Bike] = passedArray
  // asks the user whether to move, view, add, or delete a vehicle
  var userInput = ""
  while (true) {
    print("Would you like to move these bikes? (y/n) or view the bikes? (view)")
    print("Input 'new' to create a bike and 'delete' to remove one")
    userInput = readLine()!.lowercased()

    // if the user wants to move a vehicle
    if (userInput == "y") {
      var whichV = 0

      // gets the vehicle to move, moved to a funtion as it got pretty complicated
      // copied from old code
      whichV = getBike(vehicles)
      if (whichV == -1) {
        break
      }
      print("You are moving " + vehicles[whichV].getPlate())

      // asks the user whether they want to accelerate or decelerate the vehicle
      while (true) {
        print("\nWould you like to accelerate or brake?")
        print("Input done/exit to stop moving the bike.")

        userInput = readLine()!.lowercased()

        // if accelerate
        if (userInput == "accelerate" || userInput == "a") {
          // makes sure the car isn't already going at maximum speed
          if (vehicles[whichV].getSpeed() == vehicles[whichV].getMaxSpeed()) {
            print("The bike is already going as fast as it can")

            // otherwise
          } else {
            // gets how much to accelerate the vehicle by
            var userInputFloat: Float = 0
            while (true) {
              print("How much would you like to accelerate the bike by?");
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

              print("Your legs catch fire due to your sheer exertion, you are now going"
                  , vehicles[whichV].getMaxSpeed())
              vehicles[whichV].setSpeed(vehicles[whichV].getMaxSpeed())

              // otherwise accelerate the vehicle by that ammount
            } else {
              vehicles[whichV].accelerate(userInputFloat)
              print("\nAccelerated the bike by", userInputFloat)
            }
          }

          // if the user wants to brake
        } else if (userInput == "brake" || userInput == "b") {
          // make sure the vehicle isn't already stopped
          if (vehicles[whichV].getSpeed() == 0) {
            print("You squeeze the brake harder, however the bike is already stopped")
          } else {
            // gets how much to decelerate by
            var userInputFloat: Float = 0
            while (true) {
              print("How much would you like to decelerate the bike by?")
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
              print("\ndecelerated the bike by", userInputFloat)

              // if it would
            } else {
              vehicles[whichV].setSpeed(0)
              print("The bike comes to a halt")
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
      print("You are not moving any bikes");
      return vehicles

      // displays all vehicles and their information
    } else if (userInput == "view") {
      for (i, each) in vehicles.enumerated() {
        print("\nBike #" + String(i + 1));
        each.getInfo();
      }

      // vehicle creator
    } else if (userInput == "new" || userInput == "create") {

      // gets all necessary inputs from the user, then creates a vehicle object
      // it then adds this vehicle to the list of other vehicles
      print("\nName: ", terminator: "");
      let name = readLine()!

      print("Colour: ", terminator: "")
      let colour = readLine()!

      // initialize the variables that are in the while loops
      var speed: Float = 0
      var maxSpeed: Float = 0

      // gets the speed of the car
      while (true) {
        print("Current speed of bike: ", terminator: "")
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
        print("Max speed of bike: ", terminator: "");
        let maxSpeedString = readLine()!
        maxSpeed = Float(maxSpeedString) ?? -1
        if (maxSpeed >= 0) {
          if (maxSpeed < speed) {
            if (counter == 0) {
              print("Your max speed can not be more than the current speed \n"
                  + "If you input a lesser max speed again the current speed of the \n"
                  + "bike will be set to that speed along with the max speed")
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
      vehicles.append(Bike(name, colour, speed, maxSpeed))

      // deletes the requested student from the list of students
    } else if (userInput == "delete" || userInput == "remove") {
      let carDelete = getVehicle(vehicles)
      vehicles.remove(at: carDelete)

    } else {
      print("Please enter either 'y' or 'n'")
    }
  }
}

// main
public func main() {
  // defines the default vehicles
  var vehicles: [Vehicle] = []
  vehicles.append(Vehicle("CTHH 112", "Gray", 4, 0, 180))
  vehicles.append(Vehicle("CCHM 983", "Pink", 4, 0, 175))

  var trucks: [Truck] = [Truck("Truck 112", "Gray", 4, 0, 180)]
  var bikes: [Bike] = [Bike("Fred", "Pink", 0, 40)]

  // initial print of vehicles
  // for car in vehicles {
  //   car.getInfo()
  //   print()
  // }

  var userInput = ""
  while (true) {
    print("Please input what type of vehicle you would like to edit")
    print("Truck or bike: ", terminator: "")
    userInput = readLine()!.lowercased()
    
    if (userInput == "truck" || userInput == "t" || userInput == "truck") {
      trucks = truckEditor(trucks)
    } else if (userInput == "bike" || userInput == "b" || userInput == "bikes") {
      bikes = bikeEditor(bikes)
    } else if (userInput == "exit" || userInput == "e" || userInput == "break") {
      break
    } else {
      print("Not a valid input\n")
    }
  }

}

main()