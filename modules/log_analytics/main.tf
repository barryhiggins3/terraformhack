Resource "log_analytics" {
    source                  = "git://github.com/aztfmod/log_analytics.git?ref=latest"

    name                              = var.name
    solution_plan_map                 = var.solutions
    resource_group_name               = var.rg
    prefix                            = var.prefix
    location                          = var.location
    tags                              = var.tags
}