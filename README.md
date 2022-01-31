# RichAppz PureSwiftExtensionKit

SwiftExtensionKit is to contain generic extension helpers for UIKit and Foundation.

## Introduction

This framework has been developed to help make development faster and more efficient. After using CoreData/Realm for storing offline data for simple data applications, it was identified that there was a requirement to reducing the need for complicated datastores and helping to reduce app bundle sizes.

## Requirements

- iOS 11.0+
- Xcode 10.1+
- Swift 4.2+

## Installation

### CustomPod 

```ruby
def pods
  pod 'PureSwiftExtensionKit'
end

target '<Project Name>' do
  use_frameworks!
  pods
  
end
```

### Implementation

To use the Core, you will need to import, best to do this in a `bridging-header.h`

```swift
import PureSwiftExtensionKit
```


## Licence (Mit)

Copyright (c) 2017-2020 RichAppz Limited (https://richappz.com)

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.


------------

Rich Mucha, RichAppz Limited
rich@richappz.com

