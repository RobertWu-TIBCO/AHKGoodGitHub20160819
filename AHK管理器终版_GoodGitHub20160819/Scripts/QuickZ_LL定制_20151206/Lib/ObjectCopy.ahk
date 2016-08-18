/*!
  - Function: ObjectCopy
  - Parameters: 
        - aObj 被复制的对象
  - Returns: 
        - Object 复制对象的副本
 */
ObjectCopy(aObj)
{
    if not IsObject(aObj)
        return aObj
    objReturn := Object()
    for key , value in aObj
    {
        if IsObject(value)
            objReturn[key] := ObjectCopy(value)
        else
            objReturn[key] := value
    }
    return objReturn
}

