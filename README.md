Cambios realizados:

Alta disponibilidad:
  - Un NAT GWY para cada subred privada
  - RDS multiAZ
  - ASG: parámetros cambiados (min 2, max 4, desired 2). Política de escalado con utitilización de CPU al 60%
Secret manager:
  - Gestión de passwords con Secret Manager (el secreto debe estar creado previamente)
Otros:
  - Target Group del ALB: stickiness = true
  - User data: DOMAIN_NAME cambiado a "aws_lb.app_lb.dns_name". La url utiliza http
TO_DO:
  - Certificado para HTTPS
  - CloudFront
