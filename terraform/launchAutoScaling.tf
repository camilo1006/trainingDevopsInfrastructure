resource "aws_launch_configuration" "Back_Configuration" {
  name            = "launch_configuration_Back_CCDM"
  image_id        = "ami-0fc20dd1da406780b"
  instance_type   = "t2.micro"
  security_groups = [ "${aws_security_group.Allow_Back_Traffic.id}" ]
  key_name        = "************"
}

resource "aws_launch_configuration" "Front_Configuration" {
  name            = "launch_configuration_Front_CCDM"
  image_id        = "ami-0fc20dd1da406780b"
  instance_type   = "t2.micro"
  security_groups = [ "${aws_security_group.Allow_Front_Traffic.id}" ]
  key_name        = "************"
}

resource "aws_autoscaling_group" "auto_scaling_back" {
  name                      = "auto_scaling_back_CCDM"
  max_size                  = 1
  min_size                  = 1
  desired_capacity          = 1
  load_balancers            = [ "${aws_elb.load_balancer_back.name}" ]
  launch_configuration      = "${aws_launch_configuration.Back_Configuration.name}"
  vpc_zone_identifier       = data.aws_subnet_ids.default_subnet.ids

  tag {
    key                 = "responsible"
    value               = "cdavidm"
    propagate_at_launch = true
  }
  tag {
    key                 = "project"
    value               = "rampup"
    propagate_at_launch = false
  }
  tag {
    key                 = "typeTrainingApp"
    value               = "back"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "auto_scaling_front" {
  name                      = "auto_scaling_front_CCDM"
  max_size                  = 1
  min_size                  = 1
  desired_capacity          = 1
  load_balancers            = [ "${aws_elb.load_balancer_front.name}" ]
  launch_configuration      = "${aws_launch_configuration.Front_Configuration.name}"
  vpc_zone_identifier       = data.aws_subnet_ids.default_subnet.ids

  tag {
    key                 = "responsible"
    value               = "cdavidm"
    propagate_at_launch = true
  }
  tag {
    key                 = "project"
    value               = "rampup"
    propagate_at_launch = false
  }
  tag {
    key                 = "typeTrainingApp"
    value               = "front"
    propagate_at_launch = true
  }
}


output "aws_launch_configuration_front" {
    value = "${aws_launch_configuration.Front_Configuration.id}"
}

output "aws_launch_configuration_back" {
    value = "${aws_launch_configuration.Back_Configuration.id}"
}

output "aws_autoscaling_group_back" {
    value = "${aws_autoscaling_group.auto_scaling_back.id}"
}

output "aws_autoscaling_group_front" {
    value = "${aws_autoscaling_group.auto_scaling_front.id}"
}