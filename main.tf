locals {
  stacks = [for i in range(1, 121) : {
    name        = "Kubernetes Cluster ${i}"
    description = "Provisions a Kubernetes cluster"
    branch      = "main"
    repository  = "testworkerqueue"
    worker_pool_id = "01HKWHJ7NNSKESHM0SSPS1ZYZD"
  }]
}

resource "spacelift_stack" "k8s_cluster" {
  for_each         = { for idx, stack in local.stacks : idx => stack }
  name             = each.value.name
  description      = each.value.description
  branch           = each.value.branch
  repository       = each.value.repository
  worker_pool_id   = each.value.worker_pool_id
}

resource "spacelift_run" "this" {
  for_each = { for idx, stack in local.stacks : idx => stack }

  stack_id = spacelift_stack.k8s_cluster[each.key].id

  keepers = {
    branch = spacelift_stack.k8s_cluster[each.key].branch
  }
}
