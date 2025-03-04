local Meta = require('@develfish-repo.core/Meta')
local Wrapper = require('@develfish-repo.core/Wrapper')

export type Key = {
  __type: 'Key',
  username: string?,
  access_key: string?,
  secret_key: string?,
} & Wrapper.Unwrappable<Unwrapped>

export type Unwrapped = {
  username: string?,
  access_key: string?,
  secret_key: string?,
}

local Key = {
  __type = 'Key',
  username = nil,
  access_key = nil,
  secret_key = nil,
}

Key.__index = Key

function Key:new(o): Key
  return Meta:type(o, self)
end

function Key:from(username: string, access_key: string, secret_key: string): Key
  return Key:new({
    username = username,
    access_key = access_key,
    secret_key = secret_key,
  })
end

function Key.unwrap(self: Key): Unwrapped
  return {
    username = self.username,
    access_key = self.access_key,
    secret_key = self.secret_key,
  }
end

return Key
