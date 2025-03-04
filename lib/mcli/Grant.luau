local Meta = require('@develfish-repo.core/Meta')
local Wrapper = require('@develfish-repo.core/Wrapper')

export type Grant = {
  __type: 'Grant',
  policy: string?,
  username: string?,
} & Wrapper.Unwrappable<Unwrapped>

export type Unwrapped = {
  policy: string?,
  username: string?,
}

local Grant = {
  __type = 'Grant',
  policy = nil,
  username = nil,
}

Grant.__index = Grant

function Grant:new(o): Grant
  return Meta:type(o, self)
end

function Grant:from(username: string, policy: string): Grant
  return Grant:new({
    policy = policy,
    username = username,
  })
end

function Grant.unwrap(self: Grant): Unwrapped
  return {
    policy = self.policy,
    username = self.username,
  }
end

return Grant
