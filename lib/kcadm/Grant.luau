local Meta = require('@develfish-repo.core/Meta')
local Wrapper = require('@develfish-repo.core/Wrapper')
local URI = require('@develfish-repo.core/URI')

export type Grant = {
  __type: 'Grant',
  kind: string?,
  username: string?,
  group: string?,
  client: string?,
  role: string?,
} & Wrapper.Unwrappable<Unwrapped>

export type Unwrapped = {
  kind: string?,
  username: string?,
  group: string?,
  client: string?,
  role: string?,
}

local Grant = {
  __type = 'Grant',
  kind = nil,
  username = nil,
  group = nil,
  client = nil,
  role = nil,
}

Grant.__index = Grant

function Grant:new(o): Grant
  return Meta:type(o, self)
end

function Grant:from(target_uri_string: string, role_uri_string: string): Grant
  local kind = nil
  local username = nil
  local group = nil
  local client = nil
  local role = nil

  local target_uri = URI:parse(target_uri_string)

  if target_uri.schema == 'user' then
    kind = 'user'
    username = target_uri.path
  elseif target_uri.schema == 'group' then
    kind = 'group'
    group = target_uri.path
  else
    error(`Unsupported target schema: '{target_uri.schema}'`)
  end

  local role_uri = URI:parse(role_uri_string)

  if role_uri.schema == 'realm' then
    role = role_uri.path
  elseif target_uri.schema == 'client' then
    local client_role_uri = URI:parse(target_uri.path::string)
    client = client_role_uri.schema
    role = client_role_uri.path
  else
    error(`Unsupported role schema: '{role_uri.schema}'`)
  end

  return Grant:new({
    kind = kind,
    username = username,
    group = group,
    client = client,
    role = role,
  })
end

function Grant.unwrap(self: Grant): Unwrapped
  return {
    kind = self.kind,
    username = self.username,
    group = self.group,
    client = self.client,
    role = self.role,
  }
end

return Grant
