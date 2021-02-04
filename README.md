# nimtranslate
A Nim library for translating text using Google Translate API.

----
## Features

  - **Supports emoji**
  - **Asynchronous**
  - **Easy and Free to use**

----
## Quick Start

### Installation
Requirements:
- Nim 1.2.0 or higher.


```
$ git clone https://github.com/DavideGalilei/nimtranslate
$ cd nimtranslate
$ nimble install
```
----
### Usage

[Example:](https://github.com/DavideGalilei/nimtranslate/blob/main/examples/example.nim)
```
import nimtranslate
import asyncdispatch


if isMainModule:
    let t = newTranslator()
    echo t.translate("Hello world! 🌎", toLang="de").waitFor
    echo t.detect("Hallo").waitFor
```

How to run the example:
```
$ cd examples
$ nim compile -d:ssl --run example.nim
```

Output:
```
(raw: ..., text: "Hallo Welt! 🌎", toLang: "de", detectedLang: "en")
de
```
----
## Development

Want to contribute? Pull requests are accepted! :D

----
## License
GNU GPLv3
