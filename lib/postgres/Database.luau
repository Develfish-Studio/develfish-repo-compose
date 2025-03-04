local Meta = require('@develfish-repo.core/Meta')
local Wrapper = require('@develfish-repo.core/Wrapper')
local URI = require('@develfish-repo.core/URI')
local Path = require('@develfish-repo.core/Path')

export type Database = {
  __type: 'Database',

  name: string?,
  username: string?,
  password: string?,
} & Wrapper.Unwrappable<Unwrapped>

export type Unwrapped = {
  name: string?,
  username: string?,
  password: string?,
}

type Datasource = { uri: string?, username: string?, password: string? }

local Database = {
  __type = 'Database',

  name = 'postgres',
  username = 'postgres',
  password = nil,
}

function Database:new(o): Database
  return Meta:type(o, self)
end

function Database:from_datasource(datasource: Datasource): Database
  assert(datasource.uri ~= nil)
  local uri = URI:parse_jdbc(datasource.uri)
  local database = Path:parse(uri.path):normalize():path()
  return Database:new({
    name = database,
    username = datasource.username,
    password = datasource.password,
  })
end

function Database.unwrap(self: Database): Unwrapped
  return {
    name = self.name,
    username = self.username,
    password = self.password
  }
end

return Database
