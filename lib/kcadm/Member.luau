local Meta = require('@develfish-repo.core/Meta')
local Wrapper = require('@develfish-repo.core/Wrapper')

export type Member = {
  __type: 'Member',
  username: string?,
  group: string?,
} & Wrapper.Unwrappable<Unwrapped>

export type Unwrapped = {
  username: string?,
  group: string?,
}

local Member = {
  __type = 'Member',
  username = nil,
  group = nil
}

function Member:new(o): Member
  return Meta:type(o, self)
end

function Member:from(username: string, group: string)
  return Member:new({
    username = username,
    group = group
  })
end

function Member.unwrap(self: Member): Unwrapped
  return {
    username = self.username,
    group = self.group
  }
end

return Member
