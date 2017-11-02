# Moya-Argo

[![CI Status](http://img.shields.io/travis/wattson12/Moya-Argo.svg?style=flat)](https://travis-ci.org/wattson12/Moya-Argo)
[![Version](https://img.shields.io/cocoapods/v/Moya-Argo.svg?style=flat)](http://cocoapods.org/pods/Moya-Argo)
[![License](https://img.shields.io/cocoapods/l/Moya-Argo.svg?style=flat)](http://cocoapods.org/pods/Moya-Argo)
[![Platform](https://img.shields.io/cocoapods/p/Moya-Argo.svg?style=flat)](http://cocoapods.org/pods/Moya-Argo)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Moya-Argo is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Moya-Argo"
```

### Subspec

There are subspecs available for RxSwift and Reactive cocoa if you are using Moya/RxSwift or Moya/ReactiveSwift. The pod names are `Moya-Argo/RxSwift` and `Moya-Argo/ReactiveSwift` respectively

## Usage

### Argo
The first step is having a class / struct which can be mapped by [Argo](https://github.com/thoughtbot/Argo)

```swift
struct ArgoUser: Argo.Decodable {
    
    let id: Int
    let name: String
    
    let birthdate: String?
    
    static func decode(json: JSON) -> Decoded<ArgoUser> {
        return curry(ArgoUser.init)
            <^> json <| "id"
            <*> json <| "name"
            <*> json <|? "birthdate"
    }
}
```

### Moya.Response mapping
If you have a request setup with Moya already, you can use the `mapObject` and `mapArray` methods on the response:

```swift
provider
    .request(.AllUsers) { result in
            
        if case let .Success(response) = result {
        
            do {
                let argoUsers:[ArgoUser] = try response.mapArrayWithRootKey("users")
                print("mapped to users: \(argoUsers)")
            } catch {
                print("Error mapping users: \(error)")
            }
        }
    }
```

### RxSwift
If you are using the Moya RxSwift extensions, there is an extension on Observable which will simplify the mapping:
```swift
provider
    .rx
    .request(.AllUsers)
    .mapArray(ArgoUser.self, rootKey: "users")
    .observeOn(MainScheduler.instance)
    .subscribeNext { users in
            
        self.users = users
        self.tableView.reloadData()
            
    }.addDisposableTo(disposeBag)
```

### ReactiveSwift
Or for ReactiveSwift, there are similar extensions on SignalProducer:
```swift
provider
    .reactive
    .request(.AllUsers)
    .mapArray(ArgoUser.self, rootKey: "users")
    .observeOn(UIScheduler())
    .start { event in

        switch event {
        case .Next(let users):
            self.users = users
            self.tableView.reloadData()
        case .Failed(let error):
            print("error: \(error)")
        default: break
        }
    }
```

### Helpers
The example project shows some example methods which can be used to improve the readability of your code

## Contributing 
Issues / Pull Requests / Feedback welcome 

## Thanks
I took a lot of guidance from the [Moya-ObjectMapper](https://github.com/ivanbruel/Moya-ObjectMapper) project. If you are using ObjectMapper for your serialisation you should definitely check them out. 


## Author

Sam Watts, samuel.watts@gmail.com

## License

Moya-Argo is available under the MIT license. See the LICENSE file for more info.
