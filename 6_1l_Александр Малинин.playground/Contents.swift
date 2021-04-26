import UIKit



//1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
//
//Стек (представьте стопку тарелок):
//- объекты заходят с конца
//- объекты выходят с конца (то есть последний, вошедший в стек, выйдет первым)
//Очередь (как обычная очередь на кассе):
//- объекты заходят с конца
//- объекты выходят из начала (то есть последний, вошедший в очередь, выйдет последним)
//2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
//
//Вам нужно придумать метод, который будет описан внутри "очереди". Этот метод в качестве одного из аргументов должен принимать замыкание (либо это будет единственный аргумент). Замыкание будет описано в основном коде и будешь лишь передаваться в метод очереди при вызове.
//3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.
//
//Не забудьте проверить индекс, переданный в subscript. Можно для начала попробовать не усложнять логику и просто вернуть элемент из очереди по переданному индексу, а потом уже сделать реализацию сложнее, если есть желание.


enum CarVariations {
    
    case sportcar(SportCar)
    case truckcar(TruckCar)

    
    var brand: String {
        switch self {
        case .sportcar(let sport_car):
            return sport_car.brand
        case .truckcar(let truck_car):
            return truck_car.brand
        }
    }
    
    var origin: String {
        switch self {
        case .sportcar(let sport_car):
            return sport_car.origin
        case .truckcar(let truck_car):
            return truck_car.origin
        }
    }
    
    var number_of_wheels: Int {
        switch self {
        case .sportcar(let sport_car):
            return sport_car.number_of_wheels
        case .truckcar(let truck_car):
            return truck_car.number_of_wheels
        }
    }
    
    var type: CarType {
        switch self {
        case .sportcar(let sport_car):
            return sport_car.type
        case .truckcar(let truck_car):
            return truck_car.type
        }
    }
    
}


enum QueueCondition {
    case in_
    case out_
}

enum CarType: String {
    case sedan = "Седан"
    case coupe = "Купэ"
    case universal = "Универсал"
    case offroad = "Внедорожник"
    case hatchback = "Хетчбэк"
    case lorry = "Грузовой"
}

protocol Car {
    var brand: String {get set}
    var origin: String {get set}
    var number_of_wheels: Int {get set}
    var type: CarType {get set}
}


class SportCar: Car {
    
    var brand: String
    var origin: String
    var number_of_wheels: Int
    var type: CarType
    
    init(brand: String, place_of_production: String, number_of_wheels: Int, car_type: CarType) {
        self.brand = brand
        self.origin = place_of_production
        self.number_of_wheels = number_of_wheels
        self.type = car_type
    }
}

class TruckCar: Car {
    
    var brand: String
    var origin: String
    var number_of_wheels: Int
    var type: CarType
    
    init(brand: String, place_of_production: String, number_of_wheels: Int, car_type: CarType) {
        self.brand = brand
        self.origin = place_of_production
        self.number_of_wheels = number_of_wheels
        self.type = car_type
    }
}




struct Queu<T: Car> {
    
    var car_tunnel: [T] = []

    
    mutating func moving (_ car: T, command: QueueCondition) -> [T] {
        
        var result: [T]
                
        switch command {
        case .in_:
            result = addingToArray(car)
        case .out_:
            result = removingFromArray() ?? []
        default: break
        }
        return result
    }
    private mutating func addingToArray (_ car: T) -> [T] {
        self.car_tunnel.append(car)
        return self.car_tunnel
    }
    
    mutating func removingFromArray () -> [T]? {
        guard car_tunnel.count > 0 else {return nil}
        self.car_tunnel = Array(self.car_tunnel[1...])
        return self.car_tunnel
    }
    
}


extension SportCar: CustomStringConvertible {
    var description: String {
        """
        \(self.brand)\n
        \(self.origin)\n
        \(self.type)
        """
    }
}

extension TruckCar: CustomStringConvertible {
    var description: String {
        """
        \(self.brand)\n
        \(self.origin)\n
        \(self.type)
        """
    }
    
    
}


var mercedes = SportCar (brand: "Mercedes", place_of_production: "Germany", number_of_wheels: 4, car_type: .sedan)
var porsche = SportCar (brand: "Porsche", place_of_production: "Germany", number_of_wheels: 4, car_type: .coupe)
var honda = SportCar (brand: "Honda", place_of_production: "Japan", number_of_wheels: 4, car_type: .sedan)
var peugeot = SportCar (brand: "Peugeot", place_of_production: "France", number_of_wheels: 4, car_type: .coupe)
var scania = TruckCar (brand: "Scania", place_of_production: "Sweden", number_of_wheels: 4, car_type: .lorry)


//var queu = Queu<CarVariations>()

//queu.moving(.sportcar(mercedes), command: .in_)
//queu.moving(.sportcar(porsche), command: .in_)
//queu.moving(.truckcar(scania), command: .in_)
//
//queu.moving(.sportcar(mercedes), command: .out_)
//queu.moving(.sportcar(porsche), command: .out_)
//queu.moving(.sportcar(peugeot), command: .in_)
//queu.moving(.sportcar(honda), command: .in_)
//queu.moving(.sportcar(peugeot), command: .out_)
//queu.moving(.sportcar(peugeot), command: .out_)
//queu.moving(.sportcar(peugeot), command: .in_)
//queu.moving(.sportcar(mercedes), command: .in_)
//queu.moving(.sportcar(porsche), command: .in_)




var queu = Queu<SportCar>()
queu.moving(mercedes, command: .in_)
queu.moving(porsche, command: .in_)
queu.moving(honda, command: .in_)



extension Queu {
    subscript(index: Int) -> (String?, String?, String?, Int?) {
        guard index < car_tunnel.count else {return (nil, nil, nil,nil)}
        for element in car_tunnel {
            print(element.brand)
        }
        return (car_tunnel[index].brand, car_tunnel[index].origin, car_tunnel[index].type.rawValue, car_tunnel[index].number_of_wheels)
    }
}


extension Queu {
    func tellThestory(story: (Queu) -> String) -> String {
        for element in car_tunnel {
            story(element as! Queu<T>)
        }
        return"Вот и вся история"
    }
}


var story_elements: (Queu) -> String = {"Я еду на \($0.brand), произведенном в \($0.origin)"}




print(queu[1])
print(queu.tellThestory(story: story_elements))




