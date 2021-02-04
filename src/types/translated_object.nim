import json


type
    TranslatedObject* = object
        raw*: JsonNode
        text*: string
        toLang*: string
        detectedLang*: string


proc newTranslatedObject*(
    raw: JsonNode,
    text: string,
    toLang: string,
    detectedLang: string
): TranslatedObject =
    result.raw = raw
    result.text = text
    result.toLang = toLang
    result.detectedLang = detectedLang


proc `$`*(t: TranslatedObject): string =
    let tmp = %*{
        "raw": if len($t.raw) < 200: t.raw else: %"...",
        "text": t.text,
        "toLang": t.toLang,
        "detectedLang": t.detectedLang
    }
    return pretty tmp
