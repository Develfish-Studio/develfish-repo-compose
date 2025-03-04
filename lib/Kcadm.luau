local Meta = require('@develfish-repo.core/Meta')
local Wrapper = require('@develfish-repo.core/Wrapper')
local Project = require('@develfish-repo.core/Project')
local Realm = require('@develfish-repo.compose/kcadm/Realm')
local Client = require('@develfish-repo.compose/kcadm/Client')
local User = require('@develfish-repo.compose/kcadm/User')
local Group = require('@develfish-repo.compose/kcadm/Group')
local Role = require('@develfish-repo.compose/kcadm/Role')
local Member = require('@develfish-repo.compose/kcadm/Member')
local Grant = require('@develfish-repo.compose/kcadm/Grant')

export type Kcadm = {
  project: Project.Project,
  realm: Realm.Realm,
  clients: {Client.Client},
  users: {User.User},
  groups: {Group.Group},
  roles: {Role.Role},
  members: {Member.Member},
  grants: {Grant.Grant},

  with_rules: (self: Kcadm, children: {any}) -> Kcadm,
} & Wrapper.Unwrappable<Unwrapped>

export type Unwrapped = {
  project: Project.UnwrappedProject,
  realm: Realm.Unwrapped,
  clients: {Client.Unwrapped},
  users: {User.Unwrapped},
  groups: {Group.Unwrapped},
  roles: {Role.Unwrapped},
  members: {Member.Unwrapped},
  grants: {Grant.Unwrapped},
}

local Kcadm = {
  __type = 'Kcadm',

  Realm = Realm,
  Client = Client,
  User = User,
  Group = Group,
  Role = Role,
  Member = Member,
  Grant = Grant,

  project = nil,
  realm = nil,
  clients = nil,
  users = nil,
  groups = nil,
  roles = nil,
  members = nil,
  grants = nil,
}

function Kcadm:new(o): Kcadm
  return Meta:type(o, self)
end

function Kcadm:from(project: Project.Project): Kcadm
  assert(project ~= nil)
  return Kcadm
    :new({
      project = project,
      realm = nil,
      clients = Meta:array {},
      users = Meta:array {},
      groups = Meta:array {},
      roles = Meta:array {},
      members = Meta:array {},
      grants = Meta:array {},
    })
end

function Kcadm.with_rules(self: Kcadm, children: {any}): Kcadm
  children = children or {}

  for _, child in children do
    if child.__type == 'Realm' then
      self.realm = child
    elseif child.__type == 'Client' then
      self.clients[#self.clients + 1] = child::Client.Client
    elseif child.__type == 'User' then
      self.users[#self.users + 1] = child::User.User
    elseif child.__type == 'Group' then
      self.groups[#self.groups + 1] = child::Group.Group
    elseif child.__type == 'Role' then
      self.roles[#self.roles + 1] = child::Role.Role
    elseif child.__type == 'Member' then
      self.members[#self.members + 1] = child::Member.Member
    elseif child.__type == 'Grant' then
      self.grants[#self.grants + 1] = child::Grant.Grant
    end
  end

  return self
end

function Kcadm.unwrap(self: Kcadm): Unwrapped
  return {
    project = self.project:unwrap_project(),
    realm = self.realm:unwrap(),
    clients = Wrapper:unwrap_array(self.clients),
    users = Wrapper:unwrap_array(self.users),
    groups = Wrapper:unwrap_array(self.groups),
    roles = Wrapper:unwrap_array(self.roles),
    members = Wrapper:unwrap_array(self.members),
    grants = Wrapper:unwrap_array(self.grants),
  }
end

return Kcadm