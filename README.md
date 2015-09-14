[![Build Status](https://travis-ci.org/bnolens/TSActionSheet.svg?branch=master)](https://travis-ci.org/bnolens/TSActionSheet)

# TSActionSheet

A really easy and beautiful custom UIActionSheet.

![Demo](https://cloud.githubusercontent.com/assets/221925/9854292/6074e9c4-5b08-11e5-9e49-11576e246505.gif "Demo")

## Features

* Block callback
* Customizable colors
* Customizable fonts
* Customizable background
  * Dimmed black
  * Dimmed white
  * Blurred dark
  * Blurred light
  * Blurred extra light

> [More info in .h file](/Pod/Classes/TSActionSheet.h)

## How to get started

Download TSActionSheet and try out the included iPhone example apps

### 1. Install with CocoaPods

Add the following line to your Podfile:

```ruby
pod 'TSActionSheet', :git => 'https://github.com/bnolens/TSActionSheet.git'
```

### 2. Import

Import TSActionSheet in your project

```objc
#import "TSActionSheet.h"
```

### 3. Use

Instantiate the actionsheet using:

```objc
TSActionSheet *actionSheet = [TSActionSheet new];
```

Configure it using the parameters:
> Look at the .h file to [see all the parameters](/Pod/Classes/TSActionSheet.h)

```objc
actionSheet.otherButtonTitles = @[@"Option A", @"Option B", @"Option C"];
actionSheet.destructiveButtonTitle = @"Cancel";

// UI Customization
actionSheet.otherButtonBackgroundColor = [UIColor colorWithWhite:0.94 alpha:1.f];
actionSheet.buttonTitleFont = [UIFont systemFontOfSize:19];
actionSheet.backgroundType = TSActionSheetBackgroundTypeBlurredLight;
actionSheet.destructiveButtonBackgroundColor = [UIColor blackColor];
actionSheet.destructiveButtonTextColor = [UIColor whiteColor];
```

Set the callback block

```objc
actionSheet.tapBlock =  ^(TSActionSheet * as, NSInteger buttonIndex) {

};
```

Show the actionsheet

```objc
[actionSheet showFrom:self];
```

---

**OR** use the class method and do it all in one call

```objc
[TSActionSheet showFrom:self
                  withTitle:nil
          cancelButtonTitle:nil
     destructiveButtonTitle:NSLocalizedString(@"Cancel", nil)
          otherButtonTitles:@[NSLocalizedString(@"Option 1", nil), NSLocalizedString(@"Option 2", nil)]
                   tapBlock:^(__unused TSActionSheet * actionSheet, __unused NSInteger buttonIndex) {

    }];
```

<br />


## License

License: TSActionSheet

Copyright 2015 Benoit Nolens - http://truestory.io

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
