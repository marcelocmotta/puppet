# Site.pp para testes de módulos com o vagrant.
#
#
# BEGIN: Definição de variaveis globais que estariam no foreman.
# INCLUIR TODAS AS VARIAVEIS GLOBAIS DO FOREMAN ABAIXO.
$dtp_cp = 'cpdf'
$ip_master = '10.122.9.217' # colocar o ip da máquina
$dtp_download_server = "nfs.pdf.configdtp" # colocar endereço do NFS
# END: Definição de variaveis globais que estariam no foreman.
Yumrepo <| |> -> Package <| provider != 'rpm' |>
File <| tag == 'repositorios' |> -> Package <| provider != 'rpm' |>
Exec <| tag == 'repositorios' |> -> Package <| provider != 'rpm' |>
if versioncmp($::puppetversion,'3.6.1') >= 0 {
  $allow_virtual_packages = hiera('allow_virtual_packages',false)
  Package {
    allow_virtual => $allow_virtual_packages,
  }
}
# if versioncmp($::puppetversion,'6.0.3') >= 0 {
#
# $allow_virtual_packages = hiera('allow_virtual_packages',false)
#
#   Package {
#     allow_virtual => $allow_virtual_packages,
#   }
# }
node default {
  include solr
}
