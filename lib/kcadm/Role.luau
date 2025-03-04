local Meta = require('@develfish-repo.core/Meta')
local Wrapper = require('@develfish-repo.core/Wrapper')

export type Role = {
  __type: 'Role',
  name: string?,
  client_name: string?,
} & Wrapper.Unwrappable<Unwrapped>

export type Unwrapped = {
  name: string?,
  client: string?,
}

local Role = {
  __type = 'Role',
  name = nil,
  client_name = nil,
}

Role.__index = Role

function Role:new(o): Role
  return Meta:type(o, self)
end

function Role:from(name: string): Role
  return Role:new({
    name = name,
  })
end

function Role:realm(name: string): Role
  return Role:new({
    name = name,
  })
end

function Role:client(client_name: string, name: string): Role
  return Role:new({
    name = name,
    client_name = client_name,
  })
end

function Role.unwrap(self: Role): Unwrapped
  return {
    name = self.name,
    client = self.client_name,
  }
end

return Role
