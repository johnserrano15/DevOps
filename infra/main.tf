resource "digitalocean_tag" "devopstag" {
  name = "devops-html"
}

resource "digitalocean_droplet" "web" {
  count              = 3
  image              = "34398260"
  name               = "devops-v2"
  region             = "nyc3"
  size               = "512mb"
  tags               = ["${digitalocean_tag.devopstag.id}"] 
  ssh_keys           = [20843332]
  user_data          = "${file("web.conf")}"
}