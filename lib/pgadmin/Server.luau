local Meta = require('@develfish-repo.core/Meta')
local Wrapper = require('@develfish-repo.core/Wrapper')
local URI = require('@develfish-repo.core/URI')
local Path = require('@develfish-repo.core/Path')

export type Server = {
  __type: 'Server',
  Name: string?,
  Group: string?,
  Port: number?,
  Username: string?,
  Host: string?,
  SSLMode: string?,
  MaintenanceDB: string?,
} & Wrapper.Unwrappable<Unwrapped>

export type Unwrapped = {
  Name: string?,
  Group: string?,
  Port: number?,
  Username: string?,
  Host: string?,
  SSLMode: string?,
  MaintenanceDB: string?,
}

type Datasource = { uri: string?, username: string?, password: string? }

local Server = {
  __type = 'Server',
  Name = 'Postgres',
  Group = 'Default',
  Port = 5432,
  Username = 'postgres',
  Host = 'env-postgres',
  SSLMode = 'prefer',
  MaintenanceDB = 'postgres'
}

function Server:new(o): Server
  return Meta:type(o, self)
end

function Server:from_datasource(datasource: Datasource): Server
  assert(datasource.uri ~= nil)
  local uri = URI:parse_jdbc(datasource.uri)
  local database = Path:parse(uri.path):normalize():path()
  return Server:new({
    Name = database,
    Port = if uri.port == nil then nil else tonumber(uri.port),
    Username = datasource.username,
    Host = uri.hostname,
    MaintenanceDB = database,
  })
end

function Server.unwrap(self: Server): Unwrapped
  return {
    Name = self.Name,
    Group = self.Group,
    Port = self.Port,
    Username = self.Username,
    Host = self.Host,
    SSLMode = self.SSLMode,
    MaintenanceDB = self.MaintenanceDB
  }
end

return Server
