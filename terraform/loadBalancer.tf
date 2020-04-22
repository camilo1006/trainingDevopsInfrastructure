# Create a new load balancer
resource "aws_elb" "load_balancer_back" {
  name               = "CCDMRampUpTerraformBack"
  security_groups    = [ "${aws_security_group.Allow_Back_Traffic.id}" ]
  subnets            = data.aws_subnet_ids.default_subnet.ids

  listener {
    instance_port     = 3000
    instance_protocol = "http"
    lb_port           = 3000
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 10
    unhealthy_threshold = 2
    timeout             = 5
    target              = "HTTP:3000/"
    interval            = 30
  }

  connection_draining         = true
  connection_draining_timeout = 300

  tags = {
    responsible = "cdavidm"
    project     = "rampup"
  }
}

resource "aws_elb" "load_balancer_front" {
  name               = "CCDMRampUpTerraformFront"
  internal           = false
  security_groups    = [ "${aws_security_group.Allow_Front_Traffic.id}" ]
  subnets            = data.aws_subnet_ids.default_subnet.ids

  listener {
    instance_port     = 3030
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 10
    unhealthy_threshold = 2
    timeout             = 5
    target              = "HTTP:3030/"
    interval            = 30
  }

  connection_draining         = true
  connection_draining_timeout = 300

  tags = {
    responsible = "cdavidm"
    project     = "rampup"
  }
}

output "aws_elb_back" {
    value = "${aws_elb.load_balancer_back.id}"
}

output "aws_elb_front" {
    value = "${aws_elb.load_balancer_front.id}"
}