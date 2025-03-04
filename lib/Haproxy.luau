local Meta = require('@develfish-repo.core/Meta')
local Wrapper = require('@develfish-repo.core/Wrapper')
local Project = require('@develfish-repo.core/Project')
local Route = require('@develfish-repo.compose/haproxy/Route')
local Proxy = require('@develfish-repo.compose/haproxy/Proxy')
local Server = require('@develfish-repo.compose/haproxy/Server')

export type Haproxy = {
  project: Project.Project,
  routes: {Route.Route},

  with_rules: (self: Haproxy, children: {any}) -> Haproxy,
} & Wrapper.Unwrappable<Unwrapped>

export type Unwrapped = {
  project: Project.UnwrappedProject,
  routes: {Route.Unwrapped},
}

local Haproxy = {
  __type = 'Haproxy',

  Route = Route,
  Proxy = Proxy,
  Server = Server,

  project = nil,
  routes = nil,
}

function Haproxy:new(o): Haproxy
  return Meta:type(o, self)
end

function Haproxy:from(project: Project.Project): Haproxy
  assert(project ~= nil)
  return Haproxy
    :new({
      project = project,
      routes = Meta:array {},
    })
end

function Haproxy.with_rules(self: Haproxy, children: {any}): Haproxy
  children = children or Meta:array {}

  for _, child in children do
    if child.__type == 'Route' then
      self.routes[#self.routes + 1] = child::Route.Route
    end
  end

  return self
end

function Haproxy.unwrap(self: Haproxy): Unwrapped
  return {
    project = self.project:unwrap_project(),
    routes = Wrapper:unwrap_array(self.routes),
  }
end

return Haproxy
