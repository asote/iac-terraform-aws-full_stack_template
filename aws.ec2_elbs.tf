resource "aws_elb" "prj-ec2_elb" {

	name = "ec2-elb-${var.project_ecosystem}-${var.project_webapplication}-${var.project_environment}"
	#(Optional) The name of the ELB. By default generated by terraform.
	
	#internal = "true"
	#(Optional) If true, ELB will be an internal ELB.

	cross_zone_load_balancing = "true"
	#(Optional) Enable cross-zone load balancing. Default: true
	
	#subnets = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
	#(Required for a VPC ELB) A list of subnet IDs to attach to the ELB.
	
	availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
	#Required for an EC2-classic ELB) The AZ's to serve traffic in.
	#Exactly one of availability_zones or subnets must be specified: this determines if the ELB exists in a VPC or in EC2-classic.
	
	
	#instances = ["${aws_instance.foo.id}"]
	#(Optional) A list of instance ids to place in the ELB pool.
	

	#listener - (Required) A list of listener blocks. Listeners documented below.
	#Listeners (listener) support the following:
	#	instance_port - (Required) The port on the instance to route to
	#	instance_protocol - (Required) The protocol to use to the instance. Valid values are HTTP, HTTPS, TCP, or SSL
	#	lb_port - (Required) The port to listen on for the load balancer
	#	lb_protocol - (Required) The protocol to listen on. Valid values are HTTP, HTTPS, TCP, or SSL
	#	ssl_certificate_id - (Optional) The ARN of an SSL certificate you have uploaded to AWS IAM. Note ECDSA-specific restrictions below. Only valid when lb_protocol is either HTTPS or SSL. (Example: ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName")
	
	listener {
		instance_port = 8000
		instance_protocol = "http"
		lb_port = 80
		lb_protocol = "http"
	}
	
	#health_check - (Optional) A health_check block. Health Check documented below.
	#Health Check (health_check) supports the following:
	#	healthy_threshold - (Required) The number of checks before the instance is declared healthy.
	#	unhealthy_threshold - (Required) The number of checks before the instance is declared unhealthy.
	#	target - (Required) The target of the check. Valid pattern is "${PROTOCOL}:${PORT}${PATH}", where PROTOCOL values are:
	#		HTTP, HTTPS - PORT and PATH are required
	#		TCP, SSL - PORT is required, PATH is not supported
	#	interval - (Required) The interval between checks.
	#	timeout - (Required) The length of time before the check times out.

	health_check {
		healthy_threshold = 2
		unhealthy_threshold = 2
		timeout = 3
		target = "HTTP:8000/"
		interval = 30
	}
	
	idle_timeout = 300
	#(Optional) The time in seconds that the connection is allowed to be idle. Default: 60.
	
	connection_draining = true
	#(Optional) Boolean to enable connection draining.
	
	connection_draining_timeout = 300
	#(Optional) The time in seconds to allow for connections to drain.

	#access_logs - (Optional) An Access Logs block. Access Logs documented below.
	#Access Logs (access_logs) support the following:
	#	bucket - (Required) The S3 bucket name to store the logs in.
	#	bucket_prefix - (Optional) The S3 bucket prefix. Logs are stored in the root if not configured.
	#	interval - (Optional) The publishing interval in minutes. Default: 60 minutes.
	#	enabled - (Optional) Boolean to enable / disable access_logs. Default is true

	#access_logs {
	#	bucket = "foo"
	#	bucket_prefix = "bar"
	#	interval = 60
	#}
	
	#tags - (Optional) A mapping of tags to assign to the resource.
	tags {
		Name = "foobar-terraform-elb"
	}
	
}