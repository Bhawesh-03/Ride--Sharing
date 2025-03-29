#include <iostream>
#include <string>
#include <vector>
#include <memory>

using namespace std;

// Base Ride class
class Ride {
protected:
    string rideID;
    string pickupLocation;
    string dropoffLocation;
    double distance;

public:
    Ride(string id, string pickup, string dropoff, double dist)
        : rideID(id), pickupLocation(pickup), dropoffLocation(dropoff), distance(dist) {}

    virtual double calculateFare() const = 0;

    virtual void rideDetails() const {
        cout << "Ride ID: " << rideID << endl;
        cout << "From: " << pickupLocation << " To: " << dropoffLocation << endl;
        cout << "Distance: " << distance << " miles" << endl;
        cout << "Fare: $" << calculateFare() << endl;
    }

    virtual ~Ride() {}
};

// StandardRide subclass
class StandardRide : public Ride {
public:
    StandardRide(string id, string pickup, string dropoff, double dist)
        : Ride(id, pickup, dropoff, dist) {}

    double calculateFare() const override {
        return distance * 1.5; // Standard rate per mile
    }
};

// PremiumRide subclass
class PremiumRide : public Ride {
public:
    PremiumRide(string id, string pickup, string dropoff, double dist)
        : Ride(id, pickup, dropoff, dist) {}

    double calculateFare() const override {
        return distance * 3.0; // Premium rate per mile
    }
};

// Driver class
class Driver {
private:
    string driverID;
    string name;
    double rating;
    vector<shared_ptr<Ride>> assignedRides;

public:
    Driver(string id, string n, double r) : driverID(id), name(n), rating(r) {}

    void addRide(shared_ptr<Ride> ride) {
        assignedRides.push_back(ride);
    }

    void getDriverInfo() const {
        cout << "Driver ID: " << driverID << ", Name: " << name << ", Rating: " << rating << endl;
        cout << "Completed Rides: " << assignedRides.size() << endl;
    }
};

// Rider class
class Rider {
private:
    string riderID;
    string name;
    vector<shared_ptr<Ride>> requestedRides;

public:
    Rider(string id, string n) : riderID(id), name(n) {}

    void requestRide(shared_ptr<Ride> ride) {
        requestedRides.push_back(ride);
    }

    void viewRides() const {
        cout << "Rides for Rider: " << name << endl;
        for (const auto& ride : requestedRides) {
            ride->rideDetails();
            cout << "-------------------" << endl;
        }
    }
};

// Main demo
int main() {
    shared_ptr<Ride> ride1 = make_shared<StandardRide>("R001", "Downtown", "Uptown", 5.0);
    shared_ptr<Ride> ride2 = make_shared<PremiumRide>("R002", "Mall", "Airport", 10.0);

    Driver driver("D001", "Alice", 4.8);
    driver.addRide(ride1);
    driver.addRide(ride2);
    driver.getDriverInfo();

    Rider rider("U001", "Bob");
    rider.requestRide(ride1);
    rider.requestRide(ride2);
    rider.viewRides();

    return 0;
}
