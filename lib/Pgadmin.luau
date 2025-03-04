local Meta = require('@develfish-repo.core/Meta')
local Wrapper = require('@develfish-repo.core/Wrapper')
local Project = require('@develfish-repo.core/Project')
local Server = require('@develfish-repo.compose/pgadmin/Server')

export type Pgadmin = {
  __type: 'Pgadmin',

  project: Project.Project,
  servers: {Server.Server},

  with_rules: (self: Pgadmin, children: {any}) -> Pgadmin,
} & Wrapper.Unwrappable<Unwrapped>

export type Unwrapped = {
  project: Project.UnwrappedProject,
  servers: {Server.Unwrapped},
}

local Pgadmin = {
  __type = 'Pgadmin',

  Server = Server,

  project = nil,
  servers = nil,
}

function Pgadmin:new(o): Pgadmin
  return Meta:type(o, self)
end

function Pgadmin:from(project: Project.Project): Pgadmin
  assert(project ~= nil)
  return Pgadmin
    :new({
      project = project,
      servers = Meta:array {}
    })
end

function Pgadmin.with_rules(self: Pgadmin, children: {any}): Pgadmin
  children = children or {}

  for _, child in children do
    if child.__type == 'Server' then
      self.servers[#self.servers + 1] = child
    end
  end

  return self
end

function Pgadmin.unwrap(self: Pgadmin): Unwrapped
  return {
    project = self.project:unwrap_project(),
    servers = Wrapper:unwrap_array(self.servers),
  }
end

return Pgadmin