scope :except_admin, -> {
  joins(:role).where.not(roles: { name: "administrator" } )
}
