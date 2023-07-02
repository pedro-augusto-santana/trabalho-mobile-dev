import base64


def blob_to_64(obj: dict, key: str):
    # NOTE this is ABSOFUCKINGLUTELY not respecting SOLID
    # but it works. will refactor it later (lol)
    _picture_blob = dict(obj).pop(key)
    picture_base64 = base64.b64encode(_picture_blob)
    return {
        **obj,
        # encoding is not needed,
        # but let's be pedantic shall we?
        key: picture_base64.decode("utf-8")
    }
