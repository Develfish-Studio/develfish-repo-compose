local Meta = require('@develfish-repo.core/Meta')
local Wrapper = require('@develfish-repo.core/Wrapper')

export type Client = {
  __type: 'Client',
  name: string?,
  secret: string?,
} & Wrapper.Unwrappable<Unwrapped>

export type Unwrapped = {
  name: string?,
  secret: string?,
}

local Client = {
  __type = 'Client',
  name = nil,
  secret = nil,
}

Client.__index = Client

function Client:new(o): Client
  return Meta:type(o, self)
end

function Client:from(name: string, secret: string): Client
  return Client:new({
    name = name,
    secret = secret,
  })
end

function Client.unwrap(self: Client): Unwrapped
  return {
    name = self.name,
    secret = self.secret,
  }
end

return Client
