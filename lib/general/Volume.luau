local Meta = require('@develfish-repo.core/Meta')
local Wrapper = require('@develfish-repo.core/Wrapper')

export type Volume = {
  __type: 'Volume',
  name: string?,
  path: string?,
} & Wrapper.Unwrappable<Unwrapped>

export type Unwrapped = {
  name: string?,
  path: string?,
}

local Volume = {
  __type = 'Volume',
  name = nil,
  path = nil,
}

function Volume:new(o): Volume
  return Meta:type(o, self)
end

function Volume:from(name: string, path: string): Volume
  return Volume:new({
    name = name,
    path = path,
  })
end

function Volume.unwrap(self: Volume): Unwrapped
  return {
    name = self.name,
    path = self.path,
  }
end

return Volume
