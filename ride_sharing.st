"Ride class"
Object subclass: Ride [
    | rideID pickupLocation dropoffLocation distance |

    Ride class >> newWithID: id pickup: pickup dropoff: dropoff distance: dist [
        ^self new initializeWithID: id pickup: pickup dropoff: dropoff distance: dist
    ]

    initializeWithID: id pickup: pickup dropoff: dropoff distance: dist [
        rideID := id.
        pickupLocation := pickup.
        dropoffLocation := dropoff.
        distance := dist.
    ]

    rideDetails [
        Transcript show: 'Ride ID: ', rideID; cr.
        Transcript show: 'From: ', pickupLocation, ' To: ', dropoffLocation; cr.
        Transcript show: 'Distance: ', distance printString, ' miles'; cr.
        Transcript show: 'Fare: $', (self calculateFare) printString; cr.
    ]

    calculateFare [
        self subclassResponsibility
    ]
]

"StandardRide class"
Ride subclass: StandardRide [
    calculateFare [
        ^ distance * 1.5
    ]
]

"PremiumRide class"
Ride subclass: PremiumRide [
    calculateFare [
        ^ distance * 3.0
    ]
]

"Driver class"
Object subclass: Driver [
    | driverID name rating assignedRides |

    Driver class >> newWithID: id name: n rating: r [
        ^self new initializeWithID: id name: n rating: r
    ]

    initializeWithID: id name: n rating: r [
        driverID := id.
        name := n.
        rating := r.
        assignedRides := OrderedCollection new.
    ]

    addRide: ride [
        assignedRides add: ride.
    ]

    getDriverInfo [
        Transcript show: 'Driver ID: ', driverID, ', Name: ', name, ', Rating: ', rating asFloat printString; cr.
        Transcript show: 'Completed Rides: ', assignedRides size printString; cr.
    ]
]

"Rider class"
Object subclass: Rider [
    | riderID name requestedRides |

    Rider class >> newWithID: id name: n [
        ^self new initializeWithID: id name: n
    ]

    initializeWithID: id name: n [
        riderID := id.
        name := n.
        requestedRides := OrderedCollection new.
    ]

    requestRide: ride [
        requestedRides add: ride.
    ]

    viewRides [
        Transcript show: 'Rides for Rider: ', name; cr.
        requestedRides do: [:ride |
            ride rideDetails.
            Transcript show: '-------------------'; cr.
        ].
    ]
]

"Demo Execution"
| ride1 ride2 driver rider |
ride1 := StandardRide newWithID: 'R001' pickup: 'Downtown' dropoff: 'Uptown' distance: 5.0.
ride2 := PremiumRide newWithID: 'R002' pickup: 'Mall' dropoff: 'Airport' distance: 10.0.

driver := Driver newWithID: 'D001' name: 'Alice' rating: 4.8.
driver addRide: ride1.
driver addRide: ride2.
driver getDriverInfo.

rider := Rider newWithID: 'U001' name: 'Bob'.
rider requestRide: ride1.
rider requestRide: ride2.
rider viewRides.
