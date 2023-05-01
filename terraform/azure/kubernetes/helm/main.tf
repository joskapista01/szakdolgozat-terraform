resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress-controller"
  chart      = "charts/ingress-nginx"
  namespace = "nginx-ingress"

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
  set {
    name = "serverPorts.start"
    value = "20000"
  }
  set {
    name = "serverPorts.end"
    value = "20050"
  }
   
}

resource "helm_release" "argo_cd" {
  name       = "argo-cd"
  chart      = "charts/argo-cd"
  namespace = "argo-cd"
  values = ["${file("values/argo-cd.yaml")}"]
}

resource "helm_release" "argo_cd_apps" {
  name       = "argo-cd-apps"
  chart      = "charts/apps"
  namespace = "argo-cd"
}
