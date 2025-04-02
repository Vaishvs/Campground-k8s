

resource "aws_lb" "alb" {
  name               = "traefik-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets           =  [data.aws_subnet.public_subnet_1.id, data.aws_subnet.public_subnet_2.id]
}

resource "aws_lb_target_group" "traefik_tg" {
  name     = "traefik-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id 

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.traefik_tg.arn
  }
}
