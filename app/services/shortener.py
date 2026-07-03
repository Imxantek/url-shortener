secret_mask = 347843284322
base62="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
def create_hash(uid: int) -> str:
    uid=uid ^ secret_mask
    print("new uid: ", uid)
    if uid:
        suffix=""
        while uid>0:
            rest=uid%62
            suffix+=base62[rest]
            uid=uid//62
        return suffix[::-1]
    else:
        raise ValueError("invalid uid")


