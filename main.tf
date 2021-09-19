resource "aws_instance" "ec2Project2AER" {



    ami = "ami-0133407e358cc1af0"  

    instance_type = "t2.micro" 

    key_name= "aws_key"

    vpc_security_group_ids = [aws_security_group.main.id]



  provisioner "remote-exec" {

    inline = [

      "touch project2test.txt",

      "echo Welcome Project2 Remote Provisioner >> project2test.txt",

    ]

  }

  connection {

      type        = "ssh"

      host        = self.public_ip

      user        = "ubuntu"

      private_key = file("/home/aerodeveloperou/terraform/ProjectTwo/keys/aws")

      timeout     = "4m"

   }

}



resource "aws_security_group" "main" {

  egress = [

    {

      cidr_blocks      = [ "0.0.0.0/0", ]

      description      = ""

      from_port        = 0

      ipv6_cidr_blocks = []

      prefix_list_ids  = []

      protocol         = "-1"

      security_groups  = []

      self             = false

      to_port          = 0

    }

  ]

 ingress                = [

   {

     cidr_blocks      = [ "0.0.0.0/0", ]

     description      = ""

     from_port        = 22

     ipv6_cidr_blocks = []

     prefix_list_ids  = []

     protocol         = "tcp"

     security_groups  = []

     self             = false

     to_port          = 22

  },

   {

     cidr_blocks      = [ "0.0.0.0/0", ]

     description      = "Web Services"

     from_port        = 8080

     ipv6_cidr_blocks = []

     prefix_list_ids  = []

     protocol         = "tcp"

     security_groups  = []

     self             = false

     to_port          = 8090

  }




  ]

}





resource "aws_key_pair" "deployer" {

  key_name   = "aws_key"

  public_key = file("/home/aerodeveloperou/terraform/ProjectTwo/keys/aws.pub")

}
