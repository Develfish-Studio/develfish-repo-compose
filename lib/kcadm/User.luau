local Meta = require('@develfish-repo.core/Meta')
local Wrapper = require('@develfish-repo.core/Wrapper')

export type User = {
  __type: 'User',
  email: string?,
  username: string?,
  password: string?,
} & Wrapper.Unwrappable<Unwrapped>

export type Unwrapped = {
  email: string?,
  username: string?,
  password: string?,
}

local User = {
  __type = 'User',
  email = nil,
  username = nil,
  password = nil,
}

User.__index = User

function User:new(o): User
  return Meta:type(o, self)
end

function User:from_credentials(email: string, password: string)
  local username = email:match("([^@]*)@(.*)")
  return User:new({
    username = username,
    email = email,
    password = password
  })
end

function User.unwrap(self: User): Unwrapped
  return {
    email = self.email,
    username = self.username,
    password = self.password,
  }
end

return User
