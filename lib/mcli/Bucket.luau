local Meta = require('@develfish-repo.core/Meta')
local Wrapper = require('@develfish-repo.core/Wrapper')

export type Bucket = {
  __type: 'Bucket',
  name: string?,
  anonymous_access: {string},

  with_anonymous_access: (self: Bucket, command: string) -> Bucket
} & Wrapper.Unwrappable<Unwrapped>

export type Unwrapped = {
  name: string?,
  anonymous_access: {string},
}

local Bucket = {
  __type = 'Bucket',
  name = nil,
  anonymous_access = nil,
}

Bucket.__index = Bucket

function Bucket:new(o): Bucket
  return Meta:type(o, self)
end

function Bucket:from(name: string): Bucket
  return Bucket:new({
    name = name,
    anonymous_access = Meta:array {},
    events = Meta:array {},
  })
end

function Bucket.with_anonymous_access(self: Bucket, command: string): Bucket
  self.anonymous_access[#self.anonymous_access + 1] = command
  return self
end

function Bucket.unwrap(self: Bucket): Unwrapped
  return {
    name = self.name,
    anonymous_access = self.anonymous_access,
  }
end

return Bucket
