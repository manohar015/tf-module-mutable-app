# All the locals will be declared in this file for the ease of readability
locals {
   ALL_INSTANCE_IDS =  concat(aws_spot_instance_request.spot.*.spot_instance_id, aws_instance.od.*.id) 
   ALL_INSTANCE_PRIVATE_IPS = concat(aws_spot_instance_request.spot.*.private_ip, aws_instance.od.*.private_ip) 
}