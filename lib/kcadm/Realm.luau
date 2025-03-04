local Meta = require('@develfish-repo.core/Meta')
local Wrapper = require('@develfish-repo.core/Wrapper')

export type Realm = {
  __type: 'Realm',
  name: string?
} & Wrapper.Unwrappable<Unwrapped>

export type Unwrapped = {
  name: string?
}

local Realm = {
  __type = 'Realm',
  name = nil,
}

Realm.__index = Realm

function Realm:new(o)
  return Meta:type(o, self)
end

function Realm:from(name: string)
  return Realm:new({
    name = name,
  })
end

function Realm:unwrap()
  return {
    name = self.name,
  }
end

return Realm
