resource "aws_db_instance" "rds_rampup" {
  engine                    = "mysql"
  engine_version            = "5.7.22"
  allocated_storage         = 20
  storage_type              = "gp2"
  publicly_accessible       = true
  vpc_security_group_ids    = [ "${aws_security_group.Allow_DB_Traffic.id}" ]
  port                      = 3306
  skip_final_snapshot       = true

  instance_class            = "db.t2.micro"
  name                      = "rampup"
  username                  = "rampUpUser"
  password                  = "contrasenadeprueba"
}

output "db_instance" {
    value = "${aws_db_instance.rds_rampup.id}"
}
