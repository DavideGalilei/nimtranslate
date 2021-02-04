import nimtranslate
import asyncdispatch


if isMainModule:
    let t = newTranslator()
    echo t.translate("Hello world! 🌎", toLang="de").waitFor
    echo t.detect("Hallo").waitFor
