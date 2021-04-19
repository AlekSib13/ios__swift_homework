import UIKit

//1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
//
//2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
//
//3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
//
//4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
//
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//
//6. Вывести значения свойств экземпляров в консоль.


enum TrunkStatus: String {
    case trunk_opened = "Багажник открыт"
    case trunk_closed = "Багажник закрыт"
}

enum BodyTrunkStatus: String {
    case body_trunk_opened = "Кузов открыт"
    case body_trunk_closed = "Кузов закрыт"
}


enum WindowsStatus: String {
    case windows_opened = "Окна открыты"
    case windows_closed = "Окна закрыты"
}

enum EngineStatus: String {
    case engine_launched = "Двигатель запущен"
    case engine_stopped = "Двигатель выключен"
}

enum CarGears: String {
    case auto = "АКПП"
    case manual = "МКПП"
}

enum CarGearsNum: Int {
    case one = 1
    case two
    case three
    case four
    case five
}


class Car {
    let brand: String
    let origin: String
    let price: Int
    static var wheels = 4
    let type: String
    var windows_status: WindowsStatus
    var engine_status: EngineStatus
    static var number_of_cars = 0
    var gear: CarGears
    
    
    init(brand: String,
         place_of_production: String,
         car_price: Int,
         car_type: String,
         windows_status: WindowsStatus,
         engine_status: EngineStatus,
         gear_number: CarGears) {
        
        self.brand = brand
        self.origin = place_of_production
        self.price = car_price
        self.type = car_type
        self.windows_status = windows_status
        self.engine_status = engine_status
        self.gear = gear_number
        
        
        Car.number_of_cars+=1
    }
    
    
    func change_gears(gear value: CarGearsNum) {
    }
    
    func open_close_windows(action: WindowsStatus) {
        self.windows_status = action
    }
    
    func start_stop_engine(action: EngineStatus) {
        self.engine_status = action
    }
    
    
    func describe_car() {
        print("""
              Количество произведенных автомобилей: \(Car.number_of_cars)
              _____________________
              Марка: \(brand),
              Страна производства: \(origin),
              Цена: \(price),
              Количество колес: \(Car.wheels),
              Тип автомобиля: \(type),
              Окна: \(windows_status.rawValue),
              Двигатель: \(engine_status.rawValue),
              Коробка передач: \(gear.rawValue)
              """)
    }
    
}



class SportCar: Car {
    let bottom_light: String
    let turbo: Bool
    let additional_bodywork: String
    var trunk_status: TrunkStatus
    
    init (brand: String,
          poprod: String,
          car_price: Int,
          car_type: String,
          trunk_status: TrunkStatus,
          windows_status: WindowsStatus,
          engine_status: EngineStatus,
          bottom_light: String,
          turbo: Bool,
          bodywork: String,
          gear_number: CarGears) {
        
        self.bottom_light = bottom_light
        self.turbo = turbo
        self.additional_bodywork = bodywork
        self.trunk_status = trunk_status
        
        super.init (brand: brand, place_of_production: poprod, car_price: car_price, car_type: car_type, windows_status: windows_status, engine_status: engine_status,
                    gear_number: gear_number)}
    
    override func describe_car() {
        super.describe_car()
        print("""
            Багажник: \(trunk_status.rawValue),
            Подсветка днища: \(bottom_light),
            Турбонадув: \(turbo),
            Обвес: \(additional_bodywork)\n
            """)
    }
    
    func open_close_trunk(action: TrunkStatus) {
        self.trunk_status = action
    }
    
    override func change_gears(gear value: CarGearsNum) {
        if  self.type != "lorry" {
            switch value {
            case .one:
                print ("\(self.brand) включена \(CarGearsNum.one.rawValue)-ая передача")
            case .two:
                print ("\(self.brand) включена \(CarGearsNum.two.rawValue)-ая передача")
            case .three:
                print ("\(self.brand) включена \(CarGearsNum.three.rawValue)-ая передача")
            case .four:
                print ("\(self.brand) включена \(CarGearsNum.four.rawValue)-ая передача")
            default:
                print ("\(self.brand) включена \(CarGearsNum.five.rawValue)-ая передача")
            }
        }
    }
    
}



class TrunkCar: Car {
    let cargo_type: String
    let payload: String
    var trunk_status: BodyTrunkStatus
    
    init(brand: String,
         place_of_production: String,
         car_price: Int,
         car_type: String,
         trunk_status: BodyTrunkStatus,
         windows_status: WindowsStatus,
         engine_status: EngineStatus,
         cargo_type: String,
         payload: String,
         gear_number: CarGears) {
        
        self.cargo_type = cargo_type
        self.payload = payload
        self.trunk_status = trunk_status
        
        super.init(brand: brand,place_of_production: place_of_production, car_price: car_price, car_type: car_type, windows_status: windows_status, engine_status: engine_status,gear_number: gear_number)
    }
    
    override func describe_car() {
        super.describe_car()
        print ("""
               Кузов: \(trunk_status.rawValue),
               Тип перевозимого груза: \(cargo_type),
               Грузоподъемность: \(payload)\n
               """)
    }
    
    func open_close_trunk(action: BodyTrunkStatus) {
        self.trunk_status = action
    }
    
    override func change_gears(gear value: CarGearsNum) {
        if  self.type == "lorry" {
            switch value {
            case .one:
                print ("\(self.brand) включена \(CarGearsNum.one.rawValue)-ая пониженная передача")
            case .two:
                print ("\(self.brand) включена \(CarGearsNum.one.rawValue)-ая передача")
            case .three:
                print ("\(self.brand) включена \(CarGearsNum.two.rawValue)-ая пониженная передача")
            case .four:
                print ("\(self.brand) включена \(CarGearsNum.two.rawValue)-ая передача")
            default:
                print ("\(self.brand) включена \(CarGearsNum.three.rawValue)-ая передача")
                
                
            }
        }
    }
    
}

var honda_car = SportCar (brand:"Honda", poprod: "Japan", car_price: 25_000, car_type: "sedan", trunk_status: .trunk_closed, windows_status: .windows_opened, engine_status: .engine_stopped, bottom_light: "white_neon", turbo: true, bodywork: "Спортивный обвес", gear_number: .auto)


var honda_civic_car = SportCar (brand: "Honda", poprod: "Japan", car_price: 18_000, car_type: "sedan", trunk_status: .trunk_closed, windows_status: .windows_opened, engine_status: .engine_stopped, bottom_light: "red_neon",turbo: false, bodywork: "Спойлер",gear_number: .manual)


var scania_truck = TrunkCar(brand: "Scania", place_of_production: "Sweden", car_price: 50_000, car_type: "lorry", trunk_status: .body_trunk_opened, windows_status: .windows_closed, engine_status: .engine_launched, cargo_type: "bulk", payload: "30 тонн",gear_number: .auto)


honda_car.describe_car()
honda_civic_car.describe_car()
scania_truck.describe_car()

scania_truck.open_close_windows(action: .windows_opened)
scania_truck.describe_car()
honda_car.start_stop_engine(action: .engine_launched)
honda_car.describe_car()
honda_car.open_close_trunk(action: .trunk_opened)
honda_car.describe_car()

scania_truck.change_gears(gear: .three)
honda_car.change_gears(gear: .five)


