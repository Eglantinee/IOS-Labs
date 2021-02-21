
import Foundation

// Частина 1

// Дано рядок у форматі "Student1 - Group1; Student2 - Group2; ..."

let studentsStr = "Дмитренко Олександр - ІП-84; Матвійчук Андрій - ІВ-83; Лесик Сергій - ІО-82; Ткаченко Ярослав - ІВ-83; Аверкова Анастасія - ІО-83; Соловйов Даніїл - ІО-83; Рахуба Вероніка - ІО-81; Кочерук Давид - ІВ-83; Лихацька Юлія- ІВ-82; Головенець Руслан - ІВ-83; Ющенко Андрій - ІО-82; Мінченко Володимир - ІП-83; Мартинюк Назар - ІО-82; Базова Лідія - ІВ-81; Снігурець Олег - ІВ-81; Роман Олександр - ІО-82; Дудка Максим - ІО-81; Кулініч Віталій - ІВ-81; Жуков Михайло - ІП-83; Грабко Михайло - ІВ-81; Іванов Володимир - ІО-81; Востриков Нікіта - ІО-82; Бондаренко Максим - ІВ-83; Скрипченко Володимир - ІВ-82; Кобук Назар - ІО-81; Дровнін Павло - ІВ-83; Тарасенко Юлія - ІО-82; Дрозд Світлана - ІВ-81; Фещенко Кирил - ІО-82; Крамар Віктор - ІО-83; Іванов Дмитро - ІВ-82"

// Завдання 1
// Заповніть словник, де:
// - ключ – назва групи
// - значення – відсортований масив студентів, які відносяться до відповідної групи

var studentsGroups: [String: [String]] = [:]

// Ваш код починається тут
var allInfo = studentsStr.components(separatedBy: "; ")
for user in allInfo{
    let tmp = user.components(separatedBy: "- ")
    if var arr = studentsGroups[tmp[1]]{
        arr.append(tmp[0])
        studentsGroups[tmp[1]] = arr
    } else {
        studentsGroups[tmp[1]] = [tmp[0]]
    }
}
for (key, value) in studentsGroups{
    studentsGroups[key] = value.sorted()
}
// Ваш код закінчується тут

print("Завдання 1")
print(studentsGroups)
print()

// Дано масив з максимально можливими оцінками

let points: [Int] = [12, 12, 12, 12, 12, 12, 12, 16]

// Завдання 2
// Заповніть словник, де:
// - ключ – назва групи
// - значення – словник, де:
//   - ключ – студент, який відносяться до відповідної групи
//   - значення – масив з оцінками студента (заповніть масив випадковими значеннями, використовуючи функцію `randomValue(maxValue: Int) -> Int`)

func randomValue(maxValue: Int) -> Int {
    // switch(arc4random_uniform(6)) {
    switch(random() % 6) {
    case 1:
        return Int(ceil(Float(maxValue) * 0.7))
    case 2:
        return Int(ceil(Float(maxValue) * 0.9))
    case 3, 4, 5:
        return maxValue
    default:
        return 0
    }
}

var studentPoints: [String: [String: [Int]]] = [:]

// Ваш код починається тут
//var infoForPoints = studentsStr.components(separatedBy: "; ")
//for user in infoForPoints{
    //let tmp = user.components(separatedBy: "- ")
    //var arrOfPoints: [Int] = []
    //for i in 1...10{
        //arrOfPoints.append(randomValue(maxValue: 15))
    //}
    //if var arr = studentPoints[tmp[1]]{
        //arr[tmp[0]] = arrOfPoints
        //studentPoints[tmp[1]] = arr
    //} else {
        //studentPoints[tmp[1]] = [tmp[0]: arrOfPoints]
    //}
//}
func pointsArray() -> [Int] {
    var arrayPoints: [Int] = []
    for i in 1...points.count{
        arrayPoints.append(randomValue(maxValue: points[i-1]))
    }
    return arrayPoints
}
for (key, value) in studentsGroups{
    var tmp: [String: [Int]] = [:]
    for student in value{
        tmp[student] = pointsArray()
    }
    studentPoints[key] = tmp
}


// Ваш код закінчується тут

print("Завдання 2")
print(studentPoints)
print()

// Завдання 3
// Заповніть словник, де:
// - ключ – назва групи
// - значення – словник, де:
//   - ключ – студент, який відносяться до відповідної групи
//   - значення – сума оцінок студента

var sumPoints: [String: [String: Int]] = [:]

// Ваш код починається тут
for (key, value) in studentPoints{
    var tmp: [String: Int] = [:]
    for (key2, value2) in value{
        tmp[key2] = value2.reduce(0, +)
    }
    sumPoints[key] = tmp
}
// Ваш код закінчується тут

print("Завдання 3")
print(sumPoints)
print()

// Завдання 4
// Заповніть словник, де:
// - ключ – назва групи
// - значення – середня оцінка всіх студентів групи

var groupAvg: [String: Float] = [:]

// Ваш код починається тут
for (key, value) in sumPoints{
    let numberOfStudents = value.count
    var total = 0
    for value2 in value.values {
        total += value2
    }
    groupAvg[key] = Float(total) / Float(numberOfStudents)
}
// Ваш код закінчується тут

print("Завдання 4")
print(groupAvg)
print()

// Завдання 5
// Заповніть словник, де:
// - ключ – назва групи
// - значення – масив студентів, які мають >= 60 балів

var passedPerGroup: [String: [String]] = [:]

// Ваш код починається тут
for (key, value) in sumPoints{
    var arr: [String] = []
    for (key2, value2) in value{
        if value2 >= 73{
            arr.append(key2)
        }
    }
    passedPerGroup[key] = arr
}
// Ваш код закінчується тут

print("Завдання 5")
print(passedPerGroup)

// Приклад виведення. Ваш результат буде відрізнятися від прикладу через використання функції random для заповнення масиву оцінок та через інші вхідні дані.
//
//Завдання 1
//["ІВ-73": ["Гончар Юрій", "Давиденко Костянтин", "Капінус Артем", "Науменко Павло", "Чередніченко Владислав"], "ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-71": ["Андрющенко Данило", "Гуменюк Олександр", "Корнійчук Ольга", "Музика Олександр", "Трудов Антон", "Феофанов Іван"]]
//
//Завдання 2
//["ІВ-73": ["Давиденко Костянтин": [5, 8, 9, 12, 11, 12, 0, 0, 14], "Капінус Артем": [5, 8, 12, 12, 0, 12, 12, 12, 11], "Науменко Павло": [4, 8, 0, 12, 12, 11, 12, 12, 15], "Чередніченко Владислав": [5, 8, 12, 12, 11, 12, 12, 12, 15], "Гончар Юрій": [5, 6, 0, 12, 0, 11, 12, 11, 14]], "ІВ-71": ["Корнійчук Ольга": [0, 0, 12, 9, 11, 11, 9, 12, 15], "Музика Олександр": [5, 8, 12, 0, 11, 12, 0, 9, 15], "Гуменюк Олександр": [5, 8, 12, 9, 12, 12, 11, 12, 15], "Трудов Антон": [5, 0, 0, 11, 11, 0, 12, 12, 15], "Андрющенко Данило": [5, 6, 0, 12, 12, 12, 0, 9, 15], "Феофанов Іван": [5, 8, 12, 9, 12, 9, 11, 12, 14]], "ІВ-72": ["Киба Олег": [5, 8, 12, 12, 11, 12, 0, 0, 11], "Овчарова Юстіна": [5, 8, 12, 0, 11, 12, 12, 12, 15], "Бортнік Василь": [4, 8, 12, 12, 0, 12, 9, 12, 15], "Тимко Андрій": [0, 8, 11, 0, 12, 12, 9, 12, 15]]]
//
//Завдання 3
//["ІВ-72": ["Бортнік Василь": 84, "Тимко Андрій": 79, "Овчарова Юстіна": 87, "Киба Олег": 71], "ІВ-73": ["Капінус Артем": 84, "Науменко Павло": 86, "Чередніченко Владислав": 99, "Гончар Юрій": 71, "Давиденко Костянтин": 71], "ІВ-71": ["Корнійчук Ольга": 79, "Трудов Антон": 66, "Андрющенко Данило": 71, "Гуменюк Олександр": 96, "Феофанов Іван": 92, "Музика Олександр": 72]]
//
//Завдання 4
//["ІВ-71": 79.333336, "ІВ-72": 80.25, "ІВ-73": 82.2]
//
//Завдання 5
//["ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-73": ["Давиденко Костянтин", "Капінус Артем", "Чередніченко Владислав", "Гончар Юрій", "Науменко Павло"], "ІВ-71": ["Музика Олександр", "Трудов Антон", "Гуменюк Олександр", "Феофанов Іван", "Андрющенко Данило", "Корнійчук Ольга"]]

enum Direction {
    case north
    case south
    case east
    case west
}


class CoordinateIS {
    var pos : Direction
    var degree : Int
    var minute : UInt
    var second : UInt
    let direction: [Direction : String] = [.north : "N", .south : "S", .east : "E", .west: "W"]

    init() {
        degree = 0
        minute = 0
        second = 0
        pos = .north
    }

    init?(degree: Int, minute: UInt, second: UInt, pos: Direction) {
        self.degree = degree
        self.minute = minute
        self.second = second
        self.pos = pos
        if (self.pos == Direction.north) || (self.pos == Direction.south) {
            if (-180 > self.degree) || (self.degree > 180) {
                return nil
            }
         } else {
            if (-90 > self.degree) || (self.degree > 90) {
                return nil
            }
        }
        if self.minute > 59 {
            return nil
        }
        if self.second > 59 {
            return nil
        }
    }

    func repr() {
        let z = self.direction[self.pos]
        print("\(self.degree)°\(self.minute)′\(self.second)″ \(z!)")
    }
    func decimal() {
        let z = self.direction[self.pos]
        let coordinate = NSString(format: "%.6f", Double(self.degree) + Double(self.minute)/60 + Double(self.second)/3600)
        let replaced = coordinate.replacingOccurrences(of: ".", with: ",")
        print("\(replaced)° \(z!)")
    }

    func middleofOne(other: CoordinateIS)-> CoordinateIS? {
        if self.pos != other.pos {
            return nil
        } else {
            var sec1: Int = 3600 * abs(self.degree) + 60 * Int(self.minute) + Int(self.second)
            sec1 *= ((self.degree) > 0 ? 1: -1)
            var sec2: Int = 3600 * abs(other.degree) + 60 * Int(other.minute) + Int(other.second)
            sec2 *= ((other.degree) > 0 ? 1: -1)
            let result: Int = Int(sec1 + sec2 )/2
            var new_degree: Int
            var new_minute, new_second: UInt
            new_degree = Int(result / 3600)
            new_minute = UInt(result % 3600 / 60)
            new_second = UInt(result % 3600 % 60)
            return CoordinateIS(degree: new_degree, minute: new_minute, second: new_second, pos: self.pos)
        }
    }

    func middleofTwo(cord1: CoordinateIS, cord2: CoordinateIS) -> CoordinateIS? {
        if cord1.pos != cord2.pos {
            return nil
        } else {
            var sec1: Int = 3600 * abs(cord1.degree) + 60 * Int(cord1.minute) + Int(cord1.second)
            sec1 *= ((cord1.degree) > 0 ? 1: -1)
            var sec2: Int = 3600 * abs(cord2.degree) + 60 * Int(cord2.minute) + Int(cord2.second)
            sec2 *= ((cord2.degree) > 0 ? 1: -1)
            let result: Int = Int(sec1 + sec2 )/2
            var new_degree: Int
            var new_minute, new_second: UInt
            new_degree = Int(result / 3600)
            new_minute = UInt(result % 3600 / 60)
            new_second = UInt(result % 3600 % 60)
            return CoordinateIS(degree: new_degree, minute: new_minute, second: new_second, pos: cord1.pos)
        }
    }
}
var simpleInit = CoordinateIS()
var complicatedInit = CoordinateIS(degree: 10, minute: 20, second: 30, pos: Direction.north)!
complicatedInit.repr()
simpleInit.repr()
complicatedInit.decimal()
var middle1 = simpleInit.middleofOne(other: complicatedInit)
middle1?.repr()
var middle2 = simpleInit.middleofTwo(cord1: simpleInit, cord2: complicatedInit)
middle2?.repr()
