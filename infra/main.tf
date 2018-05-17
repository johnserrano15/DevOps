resource "digitalocean_droplet" "web" {
  image              = "34398260"
  name               = "devops-v2"
  region             = "nyc3"
  size               = "512mb"
  ssh_keys           = [20843332]
  user_data          = "${file("web.conf")}"
}