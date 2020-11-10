resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "VPC_CUSTOM2"
    }
} 
resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "172.2.0.0/16"
}

data "aws_availability_zones" "Avaib_Zone" {
  state = "available"
}



resource "aws_subnet" "Private_Subnet2" {
    vpc_id = aws_vpc.main.id  
    cidr_block = "10.0.0.0/16"
    availability_zone = data.aws_availability_zones.Avaib_Zone.names[1]
    tags = {
        Name = "Private_Subnet2"
    }
}

resource "aws_subnet" "Public_Subnet2" {
    vpc_id = aws_vpc.main.id  
    cidr_block = "10.0.0.0/16"
    availability_zone = data.aws_availability_zones.Avaib_Zone.names[0]
    tags = {
        Name = "Public_Subnet2"
    }
}
resource "aws_internet_gateway" "Internet_Gateway" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "IG"
    }
}

resource "aws_eip" "Elatic_IP" {
    tags = {
        Name = "ElasticIPAddress"
    }
}

resource "aws_nat_gateway" "Nat_Gateway" {
    allocation_id = aws_eip.Elatic_IP.id
    subnet_id = aws_subnet.Public_Subnet2.id  
    tags = {
        Name = "Nat_Gateway2"
    }
}

resource "aws_route_table" "Pvt_Route_Table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.Nat_Gateway.id
  }

  tags = {
    Name = "Private_Route_Table_2"
  }
}

resource "aws_route_table" "Public_Route_Table2" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_internet_gateway.Internet_Gateway.id
  }

  tags = {
    Name = "Public_Route_Table2"
  }
}

resource "aws_route_table_association" "Public_RT_Assn" {
  subnet_id = aws_subnet.Public_Subnet2.id
  route_table_id = aws_route_table.Public_Route_Table2.id
}

resource "aws_route_table_association" "Private_RT_Assn" {
  subnet_id = aws_subnet.Private_Subnet2.id
  route_table_id = aws_route_table.Pvt_Route_Table.id
}
