export ccread


function pyccread(file)
    data = cclib[].io.ccread(file)
    keys = pyconvert(Array, data.__dict__.keys())
    values = pyconvert(Array, data.__dict__.values())
    return Dict(zip(keys, values))
end

function ccread(pydict)
    datadict = pyccread(pydict)
    for (key, value) in datadict
        type = cclibtypes[key]
        datadict[key] = pyconvert(type, value)
    end
    return datadict
end