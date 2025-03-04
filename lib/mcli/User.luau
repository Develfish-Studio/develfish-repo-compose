local Meta = require('@develfish-repo.core/Meta')
local Wrapper = require('@develfish-repo.core/Wrapper')

export type User = {
  __type: 'User',
  username: string?,
  password: string?,
} & Wrapper.Unwrappable<Unwrapped>

export type Unwrapped = {
  username: string?,
  password: string?,
}

local User = {
  __type = 'User',
  username = nil,
  password = nil,
}

User.__index = User

function User:new(o): User
  return Meta:type(o, self)
end

function User:from(username: string, password: string): User
  return User:new({
    username = username,
    password = password,
  })
end

function User.unwrap(self: User): Unwrapped
  return {
    username = self.username,
    password = self.password,
  }
end

return User
