import uri
import json
import sugar
import strutils
import httpclient
import asyncdispatch

import types/translated_object


type
    Translator* = object
        sourcelang: string
        toLang: string
        client: string
        dt: string


proc getArgs(args: openarray[(string, string)]): string =
    var tmp = "?"
    for elem in args:
        let (key, value) = elem
        tmp.add(key)
        tmp.add("="&encodeUrl(value)&"&")
    tmp[0..^2]


func newTranslator*(
    sourcelang: string = "auto",
    toLang: string = "en",
    client: string = "dict-chrome-ex",
    dt: string = "t"
): Translator =                 
    result.sourcelang = sourcelang        
    result.toLang = toLang
    result.client = client
    result.dt = dt


proc translate*(
    self: Translator,
    text: string,
    sourcelang: string = "auto",
    toLang: string = "en",
    client: string = "dict-chrome-ex",
    dt: string = "t"
): Future[TranslatedObject] {.async.} =
    let client = newAsyncHttpClient()
    let params = {
        "client": self.client,
        "sl": if sourcelang != self.sourcelang: sourcelang else: self.sourcelang,
        "tl": if toLang != self.toLang: toLang else: self.toLang,
        "q": text,
        "ie": "utf-8",
        "oe": "utf-8",
    }

    const url = "https://clients5.google.com/translate_a/t"

    var response = await client.request(
        url&getArgs(params),
        httpMethod = HttpPost
    )

    let raw = parseJson(await response.body)

    return newTranslatedObject(
        raw = raw,
        text = (block: collect newSeq: (for t in raw["sentences"]: t["trans"].getStr())).join(),
        toLang = if toLang != self.toLang: toLang else: self.toLang,
        detectedLang = raw["src"].getStr()
    )


proc detect*(
    self: Translator,
    text: string,
    client: string = "dict-chrome-ex",
    dt: string = "t"
): Future[string] {.async.} =
    return (await self.translate(text)).detectedLang
