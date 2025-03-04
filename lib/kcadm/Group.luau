local Meta = require('@develfish-repo.core/Meta')
local Wrapper = require('@develfish-repo.core/Wrapper')

export type Group = {
  __type: 'Group',
  name: string?,
} & Wrapper.Unwrappable<Unwrapped>

export type Unwrapped = {
  name: string?,
}

local Group = {
  __type = 'Group',
  name = nil,
}

Group.__index = Group

function Group:new(o): Group
  return Meta:type(o, self)
end

function Group:from(name: string): Group
  return Group:new({
    name = name,
  })
end

function Group.unwrap(self: Group): Unwrapped
  return {
    name = self.name,
  }
end

return Group
