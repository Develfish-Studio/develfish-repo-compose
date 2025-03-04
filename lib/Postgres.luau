local Meta = require('@develfish-repo.core/Meta')
local Wrapper = require('@develfish-repo.core/Wrapper')
local Project = require('@develfish-repo.core/Project')
local Database = require('@develfish-repo.compose/postgres/Database')

export type Postgres = {
  __type: 'Postgres',

  project: Project.Project,
  databases: {Database.Database},

  with_rules: (self: Postgres, children: {any}) -> Postgres,
} & Wrapper.Unwrappable<Unwrapped>

export type Unwrapped = {
  project: Project.UnwrappedProject,
  databases: {Database.Unwrapped},
}

local Postgres = {
  __type = 'Postgres',

  Database = Database,

  project = nil,
  databases = nil,
}

function Postgres:new(o): Postgres
  return Meta:type(o, self)
end

function Postgres:from(project: Project.Project): Postgres
  assert(project ~= nil)
  return Postgres
    :new({
      project = project,
      databases = Meta:array {}
    })
end

function Postgres.with_rules(self: Postgres, children: {any}): Postgres
  children = children or {}

  for _, child in children do
    if child.__type == 'Database' then
      self.databases[#self.databases + 1] = child::Database.Database
    end
  end

  return self
end

function Postgres.unwrap(self: Postgres): Unwrapped
  return {
    project = self.project:unwrap_project(),
    databases = Wrapper:unwrap_array(self.databases),
  }
end

return Postgres
