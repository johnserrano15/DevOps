resource "digitalocean_droplet" "web" {
  image              = "34398260"
  name               = "devops-v2"
  region             = "nyc3"
  size               = "512mb"
  ssh_keys           = [20843332]
  user_data          = <<EOF
  #cloud-config
  coreos:
    units:
      - name: "devopsdemo.service"
        command: "start"
        content: |
          [Unit]
          Description=devops demo
          After=docker.service
          [Service]
          ExecStart=/usr/bin/docker -d -p 3000:3000 devops
  EOF
}